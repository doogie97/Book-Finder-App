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
        label.text = "📚 Book Finder"
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private lazy var resultsView = colorEemptyView(color: .systemGray6)
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var underLineView = colorEemptyView(color: .systemGray4)
    
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
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
        collectionView.backgroundColor = .mainBackground
        
        return collectionView
    }()
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.text = "검색하고 싶은 책 정보를 입력해 주세요.\n ex) 제목, 작가, 출판사, 출판일 등"
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationStackView)
        self.addSubview(resultsView)
        self.addSubview(bookListCollectionView)
        self.addSubview(activityIndicator)
        self.addSubview(instructionLabel)
        
        resultsView.addSubview(resultsLabel)
        resultsView.addSubview(underLineView)
        
        navigationStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        resultsView.snp.makeConstraints {
            $0.top.equalTo(navigationStackView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(45)
        }

        resultsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        bookListCollectionView.snp.makeConstraints {
            $0.top.equalTo(resultsView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bookListCollectionView)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setViewContents(results: Int) {
        self.resultsLabel.text = "Results(\(results))"
        self.instructionLabel.isHidden = results == 0 ? false : true
    }
}
