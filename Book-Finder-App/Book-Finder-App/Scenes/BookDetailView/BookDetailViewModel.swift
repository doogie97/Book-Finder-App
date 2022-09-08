//
//  BookDetailViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

protocol BookDetailViewModelable: BookDetailViewModelInput, BookDetailViewModelOutput {}

protocol BookDetailViewModelInput {}

protocol BookDetailViewModelOutput {
    var bookInfo: BookInfo { get }
}

final class BookDetailViewModel: BookDetailViewModelable {
    init(bookInfo: BookInfo) {
        self.bookInfo = bookInfo
    }
    
    //out
    var bookInfo: BookInfo
}
