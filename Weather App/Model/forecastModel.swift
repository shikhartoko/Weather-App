//
//  forecastModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 15/03/22.
//

import Foundation

struct CompleteDayForecast : Codable{
    let maxtempC : Double
    let maxtempF : Double
    let mintempC : Double
    let mintempF : Double
    let avgtempC : Double
    let avgtempF : Double
    let maxwindMph : Double
    let maxwindKph : Double
    let totalprecipMm : Double
    let totalprecipIn : Double
    let avghumidity : Int
    let condition : Condition
    let uv : Double
    let dailyWillItRain : Int
    let dailyChanceOfRain : Int
    let dailyWillItSnow : Int
    let dailyChanceOfSnow : Int
}

struct HourForecast : Codable {
    let time : String
    let tempC : Double
    let tempF : Double
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
    let willItRain : Int
    let willItSnow : Int
    let isDay : Int
}

struct ForecastDay : Codable {
    let date : String
    let dateEpoch : Int
    let day : CompleteDayForecast
    let astro : Astro
    let hour : [HourForecast]
}

struct Forecast : Codable {
    let forecastday : [ForecastDay]
}


struct ForecastWeatherResponse : Codable {
    let location : Location
    let current : WeatherDescription
    let forecast : Forecast
}
