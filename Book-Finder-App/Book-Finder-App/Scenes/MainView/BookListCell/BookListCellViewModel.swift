//
//  BookListCellViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

protocol BookListCellViewModelable: BookListCellViewModelInput, BookListCellViewModelOutput {}

protocol BookListCellViewModelInput {}

protocol BookListCellViewModelOutput {
    var imageURLString: String? { get }
    var bookTitle: String { get }
    var authors: String { get }
    var publishedDate: String { get }
}

final class BookListCellViewModel: BookListCellViewModelable {
    private let bookInfo: BookInfo
    
    init(bookInfo: BookInfo) {
        self.bookInfo = bookInfo
    }
    
    //out
    var imageURLString: String? {
        return bookInfo.volumeInfo?.imageLinks?.smallThumbnail
    }
    
    var bookTitle: String {
        return bookInfo.volumeInfo?.title ?? ""
    }
    
    var authors: String {
        let authorsCount = bookInfo.volumeInfo?.authors?.count ?? 0
        
        if authorsCount <= 1 {
            return bookInfo.volumeInfo?.authors?[safe: 0] ?? "알 수 없음"
        } else {
            return (bookInfo.volumeInfo?.authors?[safe: 0] ?? "") + " 외 \(authorsCount - 1)명"
        }
    }
    
    var publishedDate: String {
        return bookInfo.volumeInfo?.publishedDate ?? "알 수 없음"
    }
}
