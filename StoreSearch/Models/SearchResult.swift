//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/9/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import Foundation

class ResultArray: Codable {
    var resultCount: Int = 0
    var results: [SearchResult] = []
}

class SearchResult: Codable, CustomStringConvertible {
    var artistName: String? = ""
    var trackName: String? = ""
    var kind: String? = ""
    var trackPrice: Double? = 0.0
    var currency: String? = ""
    var imageSmall: String? = ""
    var imageLarge: String? = ""
    var trackViewUrl: String?
    var collectionName: String?
    var collectionViewUrl: String?
    var collectionPrice: Double?
    var itemPrice: Double?
    var itemGenre: String?
    var bookGenre: [String]?
    
    var name: String {
        return trackName ?? collectionName ?? ""
    }
    
    var storeURL: String {
        return trackViewUrl ?? collectionViewUrl ?? ""
    }
    
    var price: Double {
        return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
    }
    
    var genre: String {
        if let genre = itemGenre {
            return genre
        } else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        
        return ""
    }
    
    var type: String {
        let kind = self.kind ?? "audiobook"
        
        switch kind {
        case "album":
            return "Album"
        case "audiobook":
            return "Audio Book"
        case "book":
            return "Book"
        case "ebook":
            return "E-Book"
        case "feature-movie":
            return "Movie"
        case "music-video":
            return "Music Video"
        case "podcast":
            return "Podcast"
        case "software":
            return "App"
        case "song":
            return "Song"
        case "tv-episode":
            return "TV Episode"
        default:
            break
        }
        
        return "Unknown"
    }
    
    var artist: String {
        return artistName ?? ""
    }
    
    var description: String {
        return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None"), Currency: \(currency)\n"
    }
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        case kind
        case artistName
        case trackName
        case trackPrice
        case currency
        case trackViewUrl
        case collectionName
        case collectionViewUrl
        case collectionPrice
    }
}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}

func > (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedDescending
}
