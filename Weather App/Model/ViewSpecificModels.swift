//
//  ViewSpecificModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

struct CurrentWeatherCompact {
    var location : String = ""
    var temp : String = ""
    var condition : String = ""
    var lat : String = ""
    var long : String = ""
}

struct AirQualityCompact {
    var co : String = ""
    var no2 : String = ""
    var pm25 : String = ""
    var pm10 : String = ""
}

struct WindCompact {
    var speed : String = ""
    var degree : String = ""
    var direction : String = ""
}

struct DayForecastCompact {
    let day : String
    let condnUrl : String
    let minTemp : String
    let avgTemp : String
    let maxTemp : String
}

struct HourForecastCompact {
    let temp : String
    let cndnUrl : String
    let time : String
}

struct AstroCompact {
    var sunrise : String = ""
    var sunset : String = ""
    var moonrise : String = ""
    var moonset : String = ""
}
