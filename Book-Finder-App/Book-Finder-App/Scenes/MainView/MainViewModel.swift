//
//  MainViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import RxRelay
import RxSwift

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func touchSearchButton(_ text: String)
    func scrolledEndPoint()
}

protocol MainViewModelOutput {
    var totalItems: BehaviorRelay<Int> { get }
    var items: BehaviorRelay<[BookInfo]> { get }
    var startLoading: PublishRelay<Void> { get }
    var stopLoading: PublishRelay<Void> { get }
}

final class MainViewModel: MainViewModelable {
    private let networkHandler: NetworkHandler
    private let dataDecoder: DataDecoder
    private let disposeBag = DisposeBag()
    private var startIndex = 0
    private let maxResult = 20
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
        startLoading.accept(())
        let api = APIModel(bookTitle: searchText, startIndex: startIndex, maxResult: maxResult, method: .get)
        guard let data = try? networkHandler.request(api: api) else {
            return // 추 후 에러 처리 필요
        }
        
        data.observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let data):
                    guard let searchResult = try? self?.dataDecoder.parse(data: data, resultType: SearchResult.self) else {
                        return // 추 후 에러 처리 필요
                    }
                    let oldItems = self?.items.value ?? []
                    let newItems = oldItems + (searchResult.items ?? [])
                    
                    self?.totalItems.accept(searchResult.totalItems ?? 0)
                    self?.items.accept(newItems)
                case .error(_):
                    return // 추 후 에러 처리 필요
                case .completed:
                    return // 추 후 에러 처리 필요
                }
                self?.stopLoading.accept(())
            }
            .disposed(by: disposeBag)
    }
    
    //out
    let totalItems = BehaviorRelay<Int>(value: 0)
    let items = BehaviorRelay<[BookInfo]>(value: [])
    let startLoading = PublishRelay<Void>()
    let stopLoading = PublishRelay<Void>()
}
