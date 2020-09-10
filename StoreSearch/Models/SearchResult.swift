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
    
    var name: String {
        return trackName ?? ""
    }
    
    var description: String {
        return "Name: \(name), Artist Name: \(artistName ?? "None")"
    }
}
