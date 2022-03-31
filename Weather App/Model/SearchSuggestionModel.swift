//
//  SearchSuggestionModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

public struct SearchSuggestion : Codable {
    public let id : Int
    public let name : String
    public let region : String
    public let country : String
    public let lat : Double
    public let lon : Double
}
