//
//  String + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

extension String {
    var percentString: String? {
        guard let percentString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return percentString
    }
}
