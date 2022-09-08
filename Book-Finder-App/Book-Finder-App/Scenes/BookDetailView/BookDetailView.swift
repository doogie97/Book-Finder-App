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
        view.backgroundColor = .red
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        
        return button
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(navigationView)
        navigationView.addSubview(backButton)
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.safeAreaInset.top)
        }
    }
}
