//
//  SearchSuggestionModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

struct SearchSuggestion : Codable {
    let id : Int
    let name : String
    let region : String
    let country : String
    let lat : Double
    let lon : Double
}
