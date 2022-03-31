//
//  commonDataModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

public struct Position : Codable {
    public let lat : Double
    public let lon : Double
}

public struct Astro : Codable {
    public let sunrise : String
    public let sunset : String
    public let moonrise : String
    public let moonset : String
    public let moonPhase : String
    public let moonIllumination : String
}

public struct AirQuality : Codable {
    public let co : Double
    public let o3 : Double
    public let no2 : Double
    public let so2 : Double
    public let pm10 : Double
    public let pm25 : Double
    
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

public struct Location : Codable {
    public let name : String
    public let region : String
    public let country : String
    public let lat : Double
    public let lon : Double
    public let tzId : String
    public let localtimeEpoch : Int
    public let localtime : String
    
    enum Codingkeys : String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case tzId
        case localtimeEpoch
        case localtime
    }
}

public struct Condition : Codable {
    public let text : String
    public let icon : String
    public let code : Int
}

public struct WeatherDescription : Codable {
    public let tempC : Double
    public let tempF : Double
    public let isDay : Int
    public let condition : Condition
    public let windMph : Double
    public let windKph : Double
    public let windDegree : Int
    public let windDir : String
    public let pressureMb : Double
    public let pressureIn : Double
    public let precipMm : Double
    public let precipIn : Double
    public let humidity : Int
    public let cloud : Int
    public let feelslikeC : Double
    public let feelslikeF : Double
    public let uv : Double
    public let gustMph : Double
    public let gustKph : Double
    public let airQuality : AirQuality
}
