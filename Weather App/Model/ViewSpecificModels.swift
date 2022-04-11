//
//  ViewSpecificModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

internal struct CurrentWeatherCompact {
    internal var location : String = ""
    internal var temp : String = ""
    internal var condition : String = ""
    internal var lat : String = ""
    internal var long : String = ""
}

internal struct AirQualityCompact {
    internal var co : String = ""
    internal var no2 : String = ""
    internal var pm25 : String = ""
    internal var pm10 : String = ""
}

internal struct WindCompact {
    internal var speed : String = ""
    internal var degree : String = ""
    internal var direction : String = ""
}

internal struct DayForecastCompact {
    internal let day : String
    internal let condnUrl : String
    internal let minTemp : String
    internal let avgTemp : String
    internal let maxTemp : String
}

internal struct HourForecastCompact {
    internal let temp : String
    internal let cndnUrl : String
    internal let time : String
}

internal struct AstroCompact {
    internal var sunrise : String = ""
    internal var sunset : String = ""
    internal var moonrise : String = ""
    internal var moonset : String = ""
}
