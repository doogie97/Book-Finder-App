//
//  BookListCell.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import SnapKit

final class BookListCell: UICollectionViewCell {
    private var viewModel: BookListCellViewModelable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var noImageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = "이미지 없음"
        label.isHidden = true
        
        return label
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
    
    private lazy var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        imageView.tintColor = .systemGray3
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return imageView
    }()
    
    private lazy var underLineView = colorEemptyView(color: .systemGray4)
    
    private func setLayout() {
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(noImageLabel)
        self.contentView.addSubview(underLineView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(disclosureIndicator)
        self.contentView.addSubview(publishedDateLabel)
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(6)
        }
        
        noImageLabel.snp.makeConstraints {
            $0.edges.equalTo(thumbnailImageView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(disclosureIndicator.snp.leading)
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerY.equalTo(thumbnailImageView.snp.centerY)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(disclosureIndicator.snp.leading)
        }
        
        publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(disclosureIndicator.snp.leading)
        }
        
        disclosureIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.bottom.equalToSuperview()
        }
    }
    
    func setCellContents(viewModel: BookListCellViewModelable) {
        self.viewModel = viewModel

        if let imageURL = viewModel.imageURLString {
            imageViewDataTask = thumbnailImageView.setImage(urlString: imageURL)
        } else {
            noImageLabel.isHidden = false
        }
        
        titleLabel.text = viewModel.bookTitle
        authorLabel.text = viewModel.authors
        publishedDateLabel.text = viewModel.publishedDate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageViewDataTask?.suspend()
        imageViewDataTask?.cancel()
        
        thumbnailImageView.image = nil
        noImageLabel.isHidden = true
        titleLabel.text = nil
        authorLabel.text = nil
        publishedDateLabel.text = nil
    }
}
