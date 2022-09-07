//
//  ImageCacheManager.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImage(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
    func saveImage(key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    private init(){}
}

