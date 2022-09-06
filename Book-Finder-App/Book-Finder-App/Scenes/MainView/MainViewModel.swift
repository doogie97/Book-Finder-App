//
//  MainViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import RxRelay

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {}

protocol MainViewModelOutput {
    var totalItems: BehaviorRelay<Int> { get }
    var items: BehaviorRelay<[Int]> { get }
}

final class MainViewModel: MainViewModelable {
    private let networkHandler: NetworkHandler
    private let dataDecoder: DataDecoder
    
    init(networkHandler: NetworkHandler, dataDecoder: DataDecoder) {
        self.networkHandler = networkHandler
        self.dataDecoder = dataDecoder
    }
    
    //out
    let totalItems = BehaviorRelay<Int>(value: 0)
    let items = BehaviorRelay<[Int]>(value: [1, 2, 3, 4, 5]) //콜렉션 뷰 확인을 위한 임시 코드
}
