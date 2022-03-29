//
//  commonDataModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

struct Position : Codable {
    let lat : Double
    let lon : Double
}

struct Astro : Codable {
    let sunrise : String
    let sunset : String
    let moonrise : String
    let moonset : String
    let moonPhase : String
    let moonIllumination : String
}

struct AirQuality : Codable {
    let co : Double
    let o3 : Double
    let no2 : Double
    let so2 : Double
    let pm10 : Double
    let pm25 : Double
    
    enum Codingkeys : String, CodingKey {
        case co
        case o3
        case no2
        case so2
        case pm10
        case pm25 = "pm2_5"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        co = try response.decode(Double.self, forKey: .co)
        o3 = try response.decode(Double.self, forKey: .o3)
        no2 = try response.decode(Double.self, forKey: .no2)
        so2 = try response.decode(Double.self, forKey: .so2)
        pm10 = try response.decode(Double.self, forKey: .pm10)
        pm25 = try response.decode(Double.self, forKey: .pm25)
    }
}

struct Location : Codable {
    let name : String
    let region : String
    let country : String
    let lat : Double
    let lon : Double
    let tzId : String
    let localtimeEpoch : Int
    let localtime : String
    
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

struct Condition : Codable {
    let text : String
    let icon : String
    let code : Int
}

struct WeatherDescription : Codable {
    let tempC : Double
    let tempF : Double
    let isDay : Int
    let condition : Condition
    let windMph : Double
    let windKph : Double
    let windDegree : Int
    let windDir : String
    let pressureMb : Double
    let pressureIn : Double
    let precipMm : Double
    let precipIn : Double
    let humidity : Int
    let cloud : Int
    let feelslikeC : Double
    let feelslikeF : Double
    let uv : Double
    let gustMph : Double
    let gustKph : Double
    let airQuality : AirQuality
}
