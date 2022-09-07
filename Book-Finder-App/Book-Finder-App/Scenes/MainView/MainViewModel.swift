//
//  MainViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import RxRelay

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func touchSearchButton(_ text: String)
    func scrolledEndPoint()
}

protocol MainViewModelOutput {
    var totalItems: BehaviorRelay<Int> { get }
    var items: BehaviorRelay<[BookInfo]> { get }
}

final class MainViewModel: MainViewModelable {
    private let networkHandler: NetworkHandler
    private let dataDecoder: DataDecoder
    private var startIndex = 0
    private let maxResult = 15
    private var searchText = ""
    
    init(networkHandler: NetworkHandler, dataDecoder: DataDecoder) {
        self.networkHandler = networkHandler
        self.dataDecoder = dataDecoder
    }
    
    //in
    func touchSearchButton(_ text: String) {
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
        let api = APIModel(bookTitle: searchText, startIndex: startIndex, maxResult: maxResult, method: .get)
        networkHandler.request(api: api) { [weak self] result in
            switch result {
            case .success(let data):
                guard let searchResult = try? self?.dataDecoder.parse(data: data, resultType: SearchResult.self) else {
                    return // 추후 얼럿 표시 기능 구현 필요
                }
                self?.totalItems.accept(searchResult.totalItems ?? 0)
                
                let oldItems = self?.items.value ?? []
                let newItems = oldItems + (searchResult.items ?? [])
                self?.items.accept(newItems)
                
            case .failure(let error):
                print(error) // 추후 얼럿 표시 기능 구현 필요
            }
        }
    }
    
    //out
    let totalItems = BehaviorRelay<Int>(value: 0)
    let items = BehaviorRelay<[BookInfo]>(value: [])
}
