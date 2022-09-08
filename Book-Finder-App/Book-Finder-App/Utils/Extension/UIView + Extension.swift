//
//  UIView + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import SnapKit

extension UIView {    
    func colorEemptyView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        
        return view
    }
    
    //BookDetail의 항복 나열에 사용되는 메서드
    func listTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.gray
        
        return label
    }
    
    func listContentsLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }
    
    func horizontalStackView(subViews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        subViews.first?.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        
        return stackView
    }
}
