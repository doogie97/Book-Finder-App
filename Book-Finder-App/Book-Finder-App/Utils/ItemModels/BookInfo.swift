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
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let readingModes: ReadingModes?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case authors
        case publisher
        case publishedDate
        case description
        case readingModes
        case maturityRating
        case allowAnonLogging
        case contentVersion
        case panelizationSummary
        case imageLinks
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

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String
    
    private enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbnail
    }
}

// MARK: - SaleInfo
struct SaleInfo: Decodable {
    let country: String?
    let listPrice: ListPrice?
    let retailPrice: RetailPrice?
    let buyLink: String?
    let offers: [Offer]?
    
    private enum CodingKeys: String, CodingKey {
        case country
        case listPrice
        case retailPrice
        case buyLink
        case offers
    }
}

struct ListPrice: Decodable {
    let amount: Int?
    let currencyCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode
    }
}

struct RetailPrice: Decodable {
    let amount: Int?
    let currencyCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode
    }
}

struct Offer: Decodable {
    let finskyOfferType: Int?
    let listPrice: ListPriceOfOffer?
    let retailPrice: RetailPriceOfOffer?
    
    private enum CodingKeys: String, CodingKey {
        case finskyOfferType
        case listPrice
        case retailPrice
    }
}

struct ListPriceOfOffer: Decodable {
    let amountInMicros: Int?
    let currencyCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case amountInMicros
        case currencyCode
    }
}

struct RetailPriceOfOffer: Decodable {
    let amountInMicros: Int?
    let currencyCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case amountInMicros
        case currencyCode
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
    let acsTokenLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case isAvailable
        case acsTokenLink
    }
}

struct Pdf: Decodable {
    let isAvailable: Bool?
    let acsTokenLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case isAvailable
        case acsTokenLink
    }
}

//MARK: SearchInfo
struct SearchInfo: Decodable {
    let textSnippet: String?
    
    private enum CodingKeys: String, CodingKey {
        case textSnippet
    }
}
