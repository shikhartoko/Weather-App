//
//  commonDataModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

internal struct Position: Codable {
    internal let lat : Double
    internal let lon : Double
}

internal struct Astro: Codable {
    internal let sunrise : String
    internal let sunset : String
    internal let moonrise : String
    internal let moonset : String
    internal let moonPhase : String
    internal let moonIllumination : String
}

internal struct AirQuality: Codable {
    internal let co : Double
    internal let o3 : Double
    internal let no2 : Double
    internal let so2 : Double
    internal let pm10 : Double
    internal let pm25 : Double
    
    enum Codingkeys : String, CodingKey {
        case co
        case o3
        case no2
        case so2
        case pm10
        case pm25 = "pm2_5"
    }
    
    public init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        co = try response.decode(Double.self, forKey: .co)
        o3 = try response.decode(Double.self, forKey: .o3)
        no2 = try response.decode(Double.self, forKey: .no2)
        so2 = try response.decode(Double.self, forKey: .so2)
        pm10 = try response.decode(Double.self, forKey: .pm10)
        pm25 = try response.decode(Double.self, forKey: .pm25)
    }
}

internal struct Location: Codable {
    internal let name : String
    internal let region : String
    internal let country : String
    internal let lat : Double
    internal let lon : Double
    internal let tzId : String
    internal let localtimeEpoch : Int
    internal let localtime : String
    
}

internal struct Condition: Codable {
    internal let text : String
    internal let icon : String
    internal let code : Int
}

internal struct WeatherDescription: Codable {
    internal let tempC : Double
    internal let tempF : Double
    internal let isDay : Int
    internal let condition : Condition
    internal let windMph : Double
    internal let windKph : Double
    internal let windDegree : Int
    internal let windDir : String
    internal let pressureMb : Double
    internal let pressureIn : Double
    internal let precipMm : Double
    internal let precipIn : Double
    internal let humidity : Int
    internal let cloud : Int
    internal let feelslikeC : Double
    internal let feelslikeF : Double
    internal let uv : Double
    internal let gustMph : Double
    internal let gustKph : Double
    internal let airQuality : AirQuality
}
