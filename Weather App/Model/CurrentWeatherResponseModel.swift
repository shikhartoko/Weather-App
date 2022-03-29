//
//  LocationModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation

struct CurrentWeatherResponse : Codable {
    let location : Location
    let current : WeatherDescription
}


