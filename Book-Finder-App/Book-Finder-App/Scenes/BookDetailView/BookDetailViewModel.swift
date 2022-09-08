//
//  BookDetailViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import RxRelay

protocol BookDetailViewModelable: BookDetailViewModelInput, BookDetailViewModelOutput {}

protocol BookDetailViewModelInput {
    func touchBackButton()
}

protocol BookDetailViewModelOutput {
    var bookInfo: BookInfo { get }
    var popView: PublishRelay<Void> { get }
}

final class BookDetailViewModel: BookDetailViewModelable {
    init(bookInfo: BookInfo) {
        self.bookInfo = bookInfo
    }
    
    //in
    func touchBackButton() {
        
    }
    
    //out
    let bookInfo: BookInfo
    let popView = PublishRelay<Void>()
}
