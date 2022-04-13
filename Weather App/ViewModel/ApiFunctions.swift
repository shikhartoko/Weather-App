//
//  ApiFunctions.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation
import Moya

internal class ApiFunctions {
    
    internal static func fetchLocationSuggestions(query : String, completion: @escaping ([SearchSuggestion]?, String?) -> Void) {
        let provider = MoyaProvider<Api>()
        provider.request(.autoComplete(inputCity: query)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([SearchSuggestion].self, from: response.data)
                    completion(result, nil)
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    internal static func fetchForecastedData(city: String, days: Int, aqi: Bool, alerts: Bool, completion: @escaping (ForecastWeatherResponse?, String?) -> Void) {
        let provider = MoyaProvider<Api>()
        provider.request(.forecast(city: city, days: days, aqi: aqi, alerts: alerts)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode(ForecastWeatherResponse.self, from: response.data)
                    completion(result, nil)
                    
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
}
