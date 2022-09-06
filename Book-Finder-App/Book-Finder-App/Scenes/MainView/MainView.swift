//
//  MainView.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import SnapKit

final class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, searchBar])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "Search"
        
        return label
    }()
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private(set) lazy var bookListCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(BookListCell.self, forCellWithReuseIdentifier: "\(BookListCell.self)")
        
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationStackView)
        self.addSubview(bookListCollectionView)
        
        navigationStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        bookListCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
