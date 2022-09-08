//
//  BookSubInfoView.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import SnapKit

final class BookSubInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var subInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "책 정보"
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var underLineView = colorEemptyView(color: .systemGray6)
    
    private lazy var categoriesStackView = horizontalStackView(subViews: [categoriesTitleLabel, categoriesLabel])
    private lazy var categoriesTitleLabel = listTitleLabel(text: "카테고리")
    private lazy var categoriesLabel = listContentsLabel()
    
    private lazy var pageCountStackView = horizontalStackView(subViews: [pageCountTitleLabel, pageCountLabel])
    private lazy var pageCountTitleLabel = listTitleLabel(text: "쪽수")
    private lazy var pageCountLabel = listContentsLabel()
    
    private lazy var isbnStackView = horizontalStackView(subViews: [isbnTitleLabel, isbnLabel])
    private lazy var isbnTitleLabel = listTitleLabel(text: "ISBN")
    private lazy var isbnLabel = listContentsLabel()
    
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
    
    private lazy var separatorView = colorEemptyView(color: .systemGray6)
    
    private func setLayout() {
        self.addSubview(subInfoTitleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(underLineView)
        self.addSubview(categoriesStackView)
        self.addSubview(pageCountStackView)
        self.addSubview(isbnStackView)
        self.addSubview(separatorView)
        
        subInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subInfoTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        categoriesStackView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        pageCountStackView.snp.makeConstraints {
            $0.top.equalTo(categoriesStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        isbnStackView.snp.makeConstraints {
            $0.top.equalTo(pageCountStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(isbnStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewContents(subTitle: String?, categories: String?, pageCount: Int?, isbn: String?) {
        subTitleLabel.text = subTitle
        categoriesLabel.text = categories ?? "분류 없음"
        pageCountLabel.text = pageCount?.description ?? "정보 없음"
        isbnLabel.text = isbn ?? "정보 없음"
    }
}
