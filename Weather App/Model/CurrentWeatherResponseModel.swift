//
//  LocationModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation

internal struct CurrentWeatherResponse: Decodable {
    internal let location : Location
    internal let current : WeatherDescription
}
