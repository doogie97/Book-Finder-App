//
//  Container.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

protocol Containerable {
    func mainViewController() -> MainViewController
    func bookListCellViewModel(bookInfo: BookInfo) -> BookListCellViewModelable
    func bookDetailViewController(bookInfo: BookInfo) -> BookDetailViewController
}

final class Container: Containerable {
    func mainViewController() -> MainViewController {
        return MainViewController(viewModel: mainViewModel(), container: self)
    }
    
    private func mainViewModel() -> MainViewModelable {
        return MainViewModel(networkManager: NetworkManger(),
                             dataDecoder: DataDecoder())
    }
    
    func bookListCellViewModel(bookInfo: BookInfo) -> BookListCellViewModelable {
        return BookListCellViewModel(bookInfo: bookInfo)
    }
    
    func bookDetailViewController(bookInfo: BookInfo) -> BookDetailViewController {
        return BookDetailViewController(viewModel: bookDetailViewModel(bookInfo: bookInfo))
    }
    
    private func bookDetailViewModel(bookInfo: BookInfo) -> BookDetailViewModelable {
        return BookDetailViewModel(bookInfo: bookInfo)
    }
}
