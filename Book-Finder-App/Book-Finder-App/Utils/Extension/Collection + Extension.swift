//
//  Collection + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
