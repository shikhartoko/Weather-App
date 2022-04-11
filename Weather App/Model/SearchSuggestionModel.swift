//
//  SearchSuggestionModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

internal struct SearchSuggestion: Codable {
    internal let id : Int
    internal let name : String
    internal let region : String
    internal let country : String
    internal let lat : Double
    internal let lon : Double
    
    enum Codingkeys : String, CodingKey {
        case id, name, region, country
    }
}

extension SearchSuggestion {
    internal init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        id = try response.decode(Int.self, forKey: .id)
        name = try response.decode(String.self, forKey: .name)
        region = try response.decode(String.self, forKey: .region)
        country = try response.decode(String.self, forKey: .country)
        lat = try response.decode(Double.self, forKey: .lat)
        lon = try response.decode(Double.self, forKey: .lon)
    }
}
