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
    private let container: Container
    
    init(viewModel: MainViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    private func bindView() {
        searchController.searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.viewModel.touchSearchButton(self?.searchController.searchBar.text)
            })
            .disposed(by: disposeBag)
        
        viewModel.totalItems.bind(onNext: { [weak self] in
            self?.mainView.setViewContents(results: $0)
        })
        .disposed(by: disposeBag)
        
        viewModel.items.bind(to: mainView.bookListCollectionView.rx.items(cellIdentifier: "\(BookListCell.self)", cellType: BookListCell.self)) { [weak self] index, bookInfo, cell in
            
            guard let bookListCellViewModel = self?.container.bookListCellViewModel(bookInfo: bookInfo) else {
                return
            }

            cell.setCellContents(viewModel: bookListCellViewModel)
        }
        .disposed(by: disposeBag)
        
        mainView.bookListCollectionView.rx.prefetchItems
            .bind(onNext: { [weak self] in
                guard let itemCount = self?.viewModel.items.value.count else {
                    return
                }
                if $0.last?.row == itemCount - 1 {
                    self?.viewModel.scrolledEndPoint()
                }
            })
            .disposed(by: disposeBag)
        
        mainView.bookListCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCell($0.row)
            })
            .disposed(by: disposeBag)
        
        viewModel.startLoading
            .bind(onNext: { [weak self] in
                self?.mainView.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.stopLoading
            .bind(onNext: {[weak self] in
                self?.mainView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(message: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.showBookDetail
            .bind(onNext: { [weak self] in
                guard let bookDetailVC = self?.container.bookDetailViewController(bookInfo: $0) else {
                    return
                }
                
                self?.navigationController?.pushViewController(bookDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
