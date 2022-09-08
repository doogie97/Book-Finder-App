//
//  BookDetailViewController.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import RxSwift

final class BookDetailViewController: UIViewController {
    private let viewModel: BookDetailViewModelable
    
    init(viewModel: BookDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let bookDetailView = BookDetailView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailView.setViewContents(bookInfo: viewModel.bookInfo)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = viewModel.bookInfo.volumeInfo?.title
    }
}
