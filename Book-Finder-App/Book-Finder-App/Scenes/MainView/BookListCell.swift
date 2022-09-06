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
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.contentView.addSubview(underLineView)
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.bottom.equalToSuperview()
            
        }
    }
}
