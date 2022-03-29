//
//  ApiFunctions.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation
import Moya

class ApiFunctions {
    static func fetchCurrentWeatherData(city : String, aqi: Bool, completion: @escaping (CurrentWeatherResponse) -> Void) {
        let provider = MoyaProvider<Api>()
        provider.request(.current(city: city, aqi: aqi)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    print(try response.mapJSON())
                    let result = try decoder.decode(CurrentWeatherResponse.self, from: response.data)
                    completion(result)
                } catch let error {
                    print("Error occured \(error)")
                }
            case .failure:
              // 5
              print("Failure")
            }
        }
    }
    
    static func fetchLocationSuggestions(query : String, completion: @escaping ([SearchSuggestion]) -> Void) {
        let provider = MoyaProvider<Api>()
        provider.request(.autoComplete(inputCity: query)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode([SearchSuggestion].self, from: response.data)
                    completion(result)
                } catch let error {
                    print("Error occured \(error)")
                }
            case .failure:
              // 5
              print("Failure")
            }
        }
    }
    
    static func fetchForecastedData(city: String, days: Int, aqi: Bool, alerts: Bool, completion: @escaping (ForecastWeatherResponse) -> Void) {
        let provider = MoyaProvider<Api>()
        provider.request(.forecast(city: city, days: days, aqi: aqi, alerts: alerts)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode(ForecastWeatherResponse.self, from: response.data)
                    completion(result)
                    
                } catch let error {
                    print("Error occured \(error)")
                }
            case .failure:
              // 5
              print("Failure")
            }
        }
    }
    
    
}
