//
//  forecastModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

public struct CompleteDayForecast : Codable{
    public let maxtempC : Double
    public let maxtempF : Double
    public let mintempC : Double
    public let mintempF : Double
    public let avgtempC : Double
    public let avgtempF : Double
    public let maxwindMph : Double
    public let maxwindKph : Double
    public let totalprecipMm : Double
    public let totalprecipIn : Double
    public let avghumidity : Int
    public let condition : Condition
    public let uv : Double
    public let dailyWillItRain : Int
    public let dailyChanceOfRain : Int
    public let dailyWillItSnow : Int
    public let dailyChanceOfSnow : Int
}

public struct HourForecast : Codable {
    public let time : String
    public let tempC : Double
    public let tempF : Double
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
    public let willItRain : Int
    public let willItSnow : Int
    public let isDay : Int
}

public struct ForecastDay : Codable {
    public let date : String
    public let dateEpoch : Int
    public let day : CompleteDayForecast
    public let astro : Astro
    public let hour : [HourForecast]
}

public struct Forecast : Codable {
    public let forecastday : [ForecastDay]
}


public struct ForecastWeatherResponse : Codable {
    public let location : Location
    public let current : WeatherDescription
    public let forecast : Forecast
}
