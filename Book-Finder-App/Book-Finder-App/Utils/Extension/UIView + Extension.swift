//
//  UIView + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/08.
//

import UIKit

extension UIView {
    var safeAreaInset : UIEdgeInsets {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets ?? UIEdgeInsets()
    }
    
    func colorEemptyView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        
        return view
    }
}
