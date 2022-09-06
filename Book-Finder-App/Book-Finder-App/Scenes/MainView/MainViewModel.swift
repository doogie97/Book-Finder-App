//
//  MainViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {}

protocol MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private let networkHandler: NetworkHandler
    private let dataDecoder: DataDecoder
    
    init(networkHandler: NetworkHandler, dataDecoder: DataDecoder) {
        self.networkHandler = networkHandler
        self.dataDecoder = dataDecoder
    }
}
