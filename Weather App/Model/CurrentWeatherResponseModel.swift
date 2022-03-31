//
//  LocationModels.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation

public struct CurrentWeatherResponse : Codable {
    public let location : Location
    public let current : WeatherDescription
}
