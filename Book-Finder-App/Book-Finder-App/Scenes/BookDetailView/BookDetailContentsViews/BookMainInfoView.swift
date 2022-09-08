//
//  BookMainInfoView.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import SnapKit

final class BookMainInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private func setLayout() {
        self.addSubview(bookImageView)
        self.addSubview(noImageLabel)
        self.addSubview(bookTitleLabel)
        self.addSubview(authorsLabel)
        self.addSubview(sepratorView)
        
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(128)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.45)
        }
        
        noImageLabel.snp.makeConstraints {
            $0.edges.equalTo(bookImageView)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        authorsLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        sepratorView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(authorsLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewContents(imageURL: String?, title: String?, authors: String?) {
        if let imageURL = imageURL {
            _ = bookImageView.setImage(urlString: imageURL)
        } else {
            noImageLabel.isHidden = false
        }
        
        bookTitleLabel.text = title
        authorsLabel.text = authors ?? "알 수 없음"
    }
}
