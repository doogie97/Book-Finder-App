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
    
    private lazy var sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let listTitleColor = UIColor.gray
    
    private lazy var categoriesTitleLabel = listLabel(text: "카테고리 : ", color: listTitleColor)
    private lazy var categoriesLabel = listLabel()
    
    private lazy var pageCountTitleLabel = listLabel(text: "쪽수 : ", color: listTitleColor)
    private lazy var pageCountLabel = listLabel()
    
    private lazy var isbnTitleLabel = listLabel(text: "ISBN : ", color: listTitleColor)
    private lazy var isbnLabel = listLabel()
    
    private func listLabel(text: String = "", color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = color
        
        return label
    }
    private func setLayout() {
        self.addSubview(subInfoTitleLabel)
        self.addSubview(sepratorView)
        self.addSubview(subTitleLabel)
        
        subInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subInfoTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        sepratorView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewContents(subTitle: String?) {
        subTitleLabel.text = subTitle
    }
}
