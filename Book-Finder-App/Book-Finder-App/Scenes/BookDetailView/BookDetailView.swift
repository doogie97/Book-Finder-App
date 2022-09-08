//
//  BookDetailView.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import SnapKit

final class BookDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationView = UIView()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.imageView?.tintColor = .gray
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return button
    }()
    
    private lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    private lazy var underLineView = colorEemptyView(color: .systemGray3)
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentsView = UIView()
    
    private lazy var mainInfoView = BookMainInfoView()
    private lazy var subInfoView = BookSubInfoView()
    private lazy var descriptionView = BookDescriptionView()
    private lazy var publishInfoView = BookPublishInfoView()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(navigationTitleLabel)
        navigationView.addSubview(underLineView)
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentsView)
        contentsView.addSubview(mainInfoView)
        contentsView.addSubview(subInfoView)
        contentsView.addSubview(descriptionView)
        contentsView.addSubview(publishInfoView)
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(backButton.snp.trailing).offset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        subInfoView.snp.makeConstraints {
            $0.top.equalTo(mainInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(subInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }

        publishInfoView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewContents(bookInfo: BookInfo) {
        navigationTitleLabel.text = bookInfo.volumeInfo?.title
        
        mainInfoView.setViewContents(imageURL: bookInfo.volumeInfo?.imageLinks?.thumbnail,
                                   title: bookInfo.volumeInfo?.title,
                                   authors: bookInfo.volumeInfo?.authors?.joined(separator: ", "))
        
        subInfoView.setViewContents(subTitle: bookInfo.volumeInfo?.subtitle,
                                    categories: bookInfo.volumeInfo?.categories?.joined(separator: ", "),
                                    pageCount: bookInfo.volumeInfo?.pageCount,
                                    isbn: bookInfo.volumeInfo?.industryIdentifiers?.first?.isbn)
        
        descriptionView.setViewContents(description: bookInfo.volumeInfo?.description)
        
        publishInfoView.setViewContents(publisher: bookInfo.volumeInfo?.publisher,
                                        publishedDate: bookInfo.volumeInfo?.publishedDate)
    }
}
