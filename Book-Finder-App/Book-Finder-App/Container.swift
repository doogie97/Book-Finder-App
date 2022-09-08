//
//  Container.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

final class Container {
    func mainViewController() -> MainViewController {
        return MainViewController(viewModel: mainViewModel(), container: self)
    }
    
    private func mainViewModel() -> MainViewModelable {
        return MainViewModel(networkHandler: NetworkHandler(),
                             dataDecoder: DataDecoder())
    }
    
    func bookListCellViewModel(bookInfo: BookInfo) -> BookListCellViewModelable {
        return BookListCellViewModel(bookInfo: bookInfo)
    }
    
    private func bookDetailViewModel(bookInfo: BookInfo) -> BookDetailViewModelable {
        return BookDetailViewModel(bookInfo: bookInfo)
    }
}
