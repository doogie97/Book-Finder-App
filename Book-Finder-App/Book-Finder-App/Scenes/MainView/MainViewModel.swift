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
}

protocol MainViewModelOutput {
    var totalItems: BehaviorRelay<Int> { get }
    var items: BehaviorRelay<[BookInfo]> { get }
}

final class MainViewModel: MainViewModelable {
    private let networkHandler: NetworkHandler
    private let dataDecoder: DataDecoder
    
    init(networkHandler: NetworkHandler, dataDecoder: DataDecoder) {
        self.networkHandler = networkHandler
        self.dataDecoder = dataDecoder
    }
    
    //in
    func touchSearchButton(_ text: String) {
        let api = APIModel(bookTitle: text, startIndex: 0, maxResult: 10, method: .get)
        networkHandler.request(api: api) { [weak self] result in
            switch result {
            case .success(let data):
                guard let searchResult = try? self?.dataDecoder.parse(data: data, resultType: SearchResult.self) else {
                    return // 추후 얼럿 표시 기능 구현 필요
                }
                self?.totalItems.accept(searchResult.totalItems ?? 0)
                self?.items.accept(searchResult.items ?? [])
                
            case .failure(let error):
                print(error) // 추후 얼럿 표시 기능 구현 필요
            }
        }
    }
    
    //out
    let totalItems = BehaviorRelay<Int>(value: 0)
    let items = BehaviorRelay<[BookInfo]>(value: [])
}
