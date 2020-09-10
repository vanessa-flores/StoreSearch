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
    var currency: String = ""
    var imageSmall: String? = ""
    var imageLarge: String? = ""
    var storeURL: String? = ""
    var genre: String = ""
    
    var name: String {
        return trackName ?? ""
    }
    
    var description: String {
        return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None"), Currency: \(currency)\n"
    }
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrk"
        case genre = "primaryGenreName"
        case kind
        case artistName
        case trackName
        case trackPrice
        case currency
    }
}
