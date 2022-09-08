//
//  BookDetailViewController.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import UIKit

final class BookDetailViewController: UIViewController {
    private let viewModel: BookDetailViewModelable
    
    init(viewModel: BookDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
