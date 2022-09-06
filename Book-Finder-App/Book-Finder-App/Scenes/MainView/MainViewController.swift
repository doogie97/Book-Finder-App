//
//  MainViewController.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelable
    
    init(viewModel: MainViewModelable) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        viewModel.items.bind(to: mainView.bookListCollectionView.rx.items(cellIdentifier: "\(BookListCell.self)", cellType: BookListCell.self)) { index, bookInfo, cell in
            
        }
        .disposed(by: disposeBag)
    }
}

