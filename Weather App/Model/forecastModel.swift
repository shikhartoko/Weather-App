//
//  forecastModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

internal struct CompleteDayForecast: Codable {
    internal let maxtempC : Double
    internal let maxtempF : Double
    internal let mintempC : Double
    internal let mintempF : Double
    internal let avgtempC : Double
    internal let avgtempF : Double
    internal let maxwindMph : Double
    internal let maxwindKph : Double
    internal let totalprecipMm : Double
    internal let totalprecipIn : Double
    internal let avghumidity : Int
    internal let condition : Condition
    internal let uv : Double
    internal let dailyWillItRain : Int
    internal let dailyChanceOfRain : Int
    internal let dailyWillItSnow : Int
    internal let dailyChanceOfSnow : Int
}

internal struct HourForecast: Codable {
    internal let time : String
    internal let tempC : Double
    internal let tempF : Double
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
    internal let willItRain : Int
    internal let willItSnow : Int
    internal let isDay : Int
}

internal struct ForecastDay: Codable {
    internal let date : String
    internal let dateEpoch : Int
    internal let day : CompleteDayForecast
    internal let astro : Astro
    internal let hour : [HourForecast]
}

internal struct Forecast: Codable {
    internal let forecastday : [ForecastDay]
}

internal struct ForecastWeatherResponse: Codable {
    internal let location : Location
    internal let current : WeatherDescription
    internal let forecast : Forecast
}
