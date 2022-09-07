//
//  UIImageView + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import UIKit

extension UIImageView {
    func setImage(urlString: String) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
