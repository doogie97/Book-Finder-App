//
//  BookInfo.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

struct BookInfo: Decodable {
    let kind: String?
    let id: String?
    let etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
    let searchInfo: SearchInfo
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case etag
        case selfLink
        case volumeInfo
        case saleInfo
        case accessInfo
        case searchInfo
    }
}

// MARK: - VolumeInfo
struct VolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
    let publishedDate: String?
    let readingModes: ReadingModes?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publishedDate
        case readingModes
        case maturityRating
        case allowAnonLogging
        case contentVersion
        case panelizationSummary
        case previewLink
        case infoLink
        case canonicalVolumeLink
    }
}

struct ReadingModes: Decodable {
    let text: Bool
    let image: Bool
    
    private enum CodingKeys: String, CodingKey {
        case text
        case image
    }
}


struct PanelizationSummary: Decodable {
    let containsEpubBubbles: Bool?
    let containsImageBubbles: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case containsEpubBubbles
        case containsImageBubbles
    }
}

// MARK: - SaleInfo
struct SaleInfo: Decodable {
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case country
    }
}

//MARK: - AccessInfo
struct AccessInfo: Decodable {
    let country: String?
    let epub: Epub?
    let pdf: Pdf?
    let accessViewStatus: String?
    
    private enum CodingKeys: String, CodingKey {
        case country
        case epub
        case pdf
        case accessViewStatus
    }
}

struct Epub: Decodable {
    let isAvailable: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case isAvailable
    }
}

struct Pdf: Decodable {
    let isAvailable: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case isAvailable
    }
}

//MARK: SearchInfo
struct SearchInfo: Decodable {
    let textSnippet: String?
    
    private enum CodingKeys: String, CodingKey {
        case textSnippet
    }
}

