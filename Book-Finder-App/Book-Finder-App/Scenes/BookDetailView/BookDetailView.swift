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
    
    private lazy var navigationView: UIView = {
        let view = UIView()

        return view
    }()
    
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
    
    private lazy var contentsView = UIView()
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        
        return imageView
    }()
    
    private lazy var noImageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "이미지 없음"
        label.isHidden = true
        
        return label
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(navigationTitleLabel)
        self.addSubview(contentsView)
        contentsView.addSubview(bookImageView)
        contentsView.addSubview(noImageLabel)
        contentsView.addSubview(mainTitleLabel)
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(self.safeAreaInset.top + 16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(backButton.snp.trailing).offset(16)
        }
        
        contentsView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(128)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.45)
        }
        
        noImageLabel.snp.makeConstraints {
            $0.edges.equalTo(bookImageView)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setViewContents(bookInfo: BookInfo) {
        if let imageURL = bookInfo.volumeInfo?.imageLinks?.thumbnail {
            _ = bookImageView.setImage(urlString: imageURL)
        } else {
            noImageLabel.isHidden = false
        }
        
        navigationTitleLabel.text = bookInfo.volumeInfo?.title
        mainTitleLabel.text = bookInfo.volumeInfo?.title
    }
}
