//
//  BookListCell.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import SnapKit

final class BookListCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private var imageViewDataTask: URLSessionDataTask?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(underLineView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(publishedDateLabel)
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(6)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)//이거 나중에는 버튼 leading으로
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerY.equalTo(thumbnailImageView.snp.centerY)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)//이거 나중에는 버튼 leading으로
        }
        
        publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)//이거 나중에는 버튼 leading으로
        }
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.bottom.equalToSuperview()
            
        }
    }
    
    func setCellContents(_ bookInfo: BookInfo) {
        imageViewDataTask = thumbnailImageView
            .setImage(urlString: bookInfo.volumeInfo?.imageLinks?.smallThumbnail ?? "")
        
        titleLabel.text = bookInfo.volumeInfo?.title
        
        let authorsCount = bookInfo.volumeInfo?.authors?.count ?? 0
        
        if authorsCount <= 1 {
            authorLabel.text = bookInfo.volumeInfo?.authors?[safe: 0] ?? "알 수 없음"
        } else {
            authorLabel.text = (bookInfo.volumeInfo?.authors?[safe: 0] ?? "") + " 외 \(authorsCount)명"
        }
        
        publishedDateLabel.text = bookInfo.volumeInfo?.publishedDate ?? "알 수 없음"
    }
}
