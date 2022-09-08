//
//  BookDetailViewModel.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

protocol BookDetailViewModelable: BookDetailViewModelInput, BookDetailViewModelOutput {}

protocol BookDetailViewModelInput {}

protocol BookDetailViewModelOutput {}

final class BookDetailViewModel: BookDetailViewModelable {}
