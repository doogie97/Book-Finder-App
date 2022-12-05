//
//  UIImageView + Extension.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import Alamofire

extension UIImageView {
    func setImage(urlString: String) -> DataRequest? {
        if let savedImage = ImageCacheManager.shared.getImage(key: urlString) {
            self.image = savedImage
            return nil
        }
        
        let requset = AF.request(urlString)
        
        requset.response { result in
            guard result.error == nil else {
                return
            }
            
            guard let response = result.response, (200...299).contains(response.statusCode) else {
                return
            }
            
            guard let data = result.data,
                  let image = UIImage(data: data) else {
                return
            }
            
            ImageCacheManager.shared.saveImage(key: urlString, image: image)
            self.image = image
        }
        
        return requset
    }
}
