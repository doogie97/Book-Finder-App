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
    
    private lazy var mainInfoView = BookMainInfoView()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "책 소개"
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(navigationTitleLabel)
        self.addSubview(contentsView)
        contentsView.addSubview(mainInfoView)
        contentsView.addSubview(descriptionTitleLabel)
        contentsView.addSubview(descriptionLabel)
        
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
        
        mainInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        
        //아마 여기부터 두번째 뷰로 갈듯
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func setViewContents(bookInfo: BookInfo) {
        mainInfoView.setViewLayout(imageURL: bookInfo.volumeInfo?.imageLinks?.thumbnail,
                                   title: bookInfo.volumeInfo?.title,
                                   authors: bookInfo.volumeInfo?.authors?.joined(separator: ", "))
        
        navigationTitleLabel.text = bookInfo.volumeInfo?.title
        descriptionLabel.text = (bookInfo.volumeInfo?.description)
    }
}
