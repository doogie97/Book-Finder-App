//
//  MainViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import RxRelay

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func touchSearchButton(_ text: String?)
    func scrolledEndPoint()
    func touchCell(_ index: Int)
}

protocol MainViewModelOutput {
    var totalItems: BehaviorRelay<Int> { get }
    var items: BehaviorRelay<[BookInfo]> { get }
    var startLoading: PublishRelay<Void> { get }
    var stopLoading: PublishRelay<Void> { get }
    var showAlert: PublishRelay<String?> { get }
    var showBookDetail: PublishRelay<BookInfo> { get }
}

final class MainViewModel: MainViewModelable {
    private let networkManager: NetworkMangerable
    private var startIndex = 0
    private let maxResult = 20
    private var searchText = ""
    
    init(networkManager: NetworkMangerable) {
        self.networkManager = networkManager
    }
    
    //in
    func touchSearchButton(_ text: String?) {
        guard let text = text else {
            return
        }
        startIndex = 0
        searchText = text
        items.accept([])
        getSearchInfo()
    }
    
    func scrolledEndPoint() {
        startIndex += maxResult
        getSearchInfo()
    }
    
    private func getSearchInfo() {
        self.startLoading.accept(())
        let api = BookAPIModel(bookTitle: searchText, startIndex: startIndex, maxResult: maxResult, method: .get)
        Task {
            do {
                let searchResult = try await networkManager.newRequest(api: api, resultType: SearchResult.self)
                await MainActor.run {
                    guard let totalItems = searchResult.totalItems, totalItems != 0 else {
                        self.showAlert.accept("검색 결과가 없습니다")
                        self.totalItems.accept(0)
                        self.stopLoading.accept(())
                        return
                    }
                    
                    self.totalItems.accept(totalItems)
                    let oldItems = items.value
                    let newItems = oldItems + (searchResult.items ?? [])
                    self.items.accept(newItems)
                    self.stopLoading.accept(())
                }
            } catch let error {
                await MainActor.run {
                    self.showAlert.accept(error.errorMessage)
                    stopLoading.accept(())
                }
            }
        }
    }
    
    func touchCell(_ index: Int) {
        guard let bookInfo = items.value[safe: index] else {
            return
        }
        
        showBookDetail.accept(bookInfo)
    }
    
    //out
    let totalItems = BehaviorRelay<Int>(value: 0)
    let items = BehaviorRelay<[BookInfo]>(value: [])
    let startLoading = PublishRelay<Void>()
    let stopLoading = PublishRelay<Void>()
    let showAlert = PublishRelay<String?>()
    let showBookDetail = PublishRelay<BookInfo>()
}
