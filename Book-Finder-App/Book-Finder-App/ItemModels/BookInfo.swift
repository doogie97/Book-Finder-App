//
//  BookInfo.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

struct BookInfo: Decodable {
    let volumeInfo: VolumeInfo?
    
    private enum CodingKeys: String, CodingKey {
        case volumeInfo
    }
}

// MARK: - VolumeInfo
struct VolumeInfo: Decodable {
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifiers]?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: ImageLinks?
  
    
    private enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case authors
        case publisher
        case publishedDate
        case description
        case industryIdentifiers
        case pageCount
        case categories
        case imageLinks
    }
}

struct IndustryIdentifiers: Decodable {
    let isbn: String?
    
    private enum CodingKeys: String, CodingKey {
        case isbn = "identifier"
    }
}

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbnail
    }
}
