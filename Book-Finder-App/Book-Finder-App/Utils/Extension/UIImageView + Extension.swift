//
//  UIImageView + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import UIKit

extension UIImageView {
    func setImage(urlString: String) -> URLSessionDataTask? {
        if let savedImage = ImageCacheManager.shared.getImage(key: urlString) {
            self.image = savedImage
            return nil
        }
        
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
                guard let image = UIImage(data: data) else {
                    return
                }
                
                ImageCacheManager.shared.saveImage(key: urlString, image: image)
                self.image = image
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
