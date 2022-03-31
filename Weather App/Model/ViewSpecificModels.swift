//
//  ViewSpecificModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

public struct CurrentWeatherCompact {
    public var location : String = ""
    public var temp : String = ""
    public var condition : String = ""
    public var lat : String = ""
    public var long : String = ""
}

public struct AirQualityCompact {
    public var co : String = ""
    public var no2 : String = ""
    public var pm25 : String = ""
    public var pm10 : String = ""
}

public struct WindCompact {
    public var speed : String = ""
    public var degree : String = ""
    public var direction : String = ""
}

public struct DayForecastCompact {
    public let day : String
    public let condnUrl : String
    public let minTemp : String
    public let avgTemp : String
    public let maxTemp : String
}

public struct HourForecastCompact {
    public let temp : String
    public let cndnUrl : String
    public let time : String
}

public struct AstroCompact {
    public var sunrise : String = ""
    public var sunset : String = ""
    public var moonrise : String = ""
    public var moonset : String = ""
}
