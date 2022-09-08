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
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentsView = UIView()
    
    private lazy var mainInfoView = BookMainInfoView()
    private lazy var subInfoView = BookSubInfoView()
    private lazy var descriptionView = BookDescriptionView()
    private lazy var publishInfoView = BookPublishInfoView()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentsView)
        contentsView.addSubview(mainInfoView)
        contentsView.addSubview(subInfoView)
        contentsView.addSubview(descriptionView)
        contentsView.addSubview(publishInfoView)

        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
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
