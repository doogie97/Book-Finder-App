//
//  BookPublishInfoView.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import SnapKit

final class BookPublishInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var publishInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "출판 정보"
        
        return label
    }()
    
    private lazy var publisherStackView = horizontalStackView(subViews: [publisherTitleLabel, publisherLabel])
    private lazy var publisherTitleLabel = listTitleLabel(text: "출판사")
    private lazy var publisherLabel = listContentsLabel()
    
    private lazy var publishedDateStackView = horizontalStackView(subViews: [publishedDateTitleLabel, publishedDateLabel])
    private lazy var publishedDateTitleLabel = listTitleLabel(text: "출판일")
    private lazy var publishedDateLabel = listContentsLabel()
    
    private func listTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.gray
        
        return label
    }
    
    private func listContentsLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }
    
    private func horizontalStackView(subViews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        subViews.first?.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        
        return stackView
    }
    
    private func setLayout() {
        self.addSubview(publishInfoTitleLabel)
        self.addSubview(publisherStackView)
        self.addSubview(publishedDateStackView)
        
        publishInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        publisherStackView.snp.makeConstraints {
            $0.top.equalTo(publishInfoTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        publishedDateStackView.snp.makeConstraints {
            $0.top.equalTo(publisherStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
}
