//
//  API.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation

import Moya

public enum Api {
    static private let apiKey = "92bc5e97668e487cbde75839221103"

    case current(city: String, aqi: Bool)
    case forecast(city: String, days: Int, aqi: Bool, alerts: Bool)
    case autoComplete(inputCity: String)
}

extension Api: TargetType {
    public var headers: [String : String]? {
        return [
            "Transfer-Encoding": "chunked",
            "Connection": "keep-alive",
            "Vary": "Accept-Encoding",
            "Content-Type": "application/json",
        ]
    }
    
    public var baseURL: URL {
        guard let url = URL(string: "https://api.weatherapi.com/v1") else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .current(city: _):
            return "/current.json"
        
        case .forecast(city: _):
            return "/forecast.json"
        
        case .autoComplete(inputCity: _):
            return "/search.json"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        case .current(city: _, aqi: _), .forecast(city: _, days: _, aqi: _, alerts: _), .autoComplete(inputCity: _):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .current(city: let city, aqi: let aqi):
            var parameters = [ "key" : Api.apiKey, "q" : city]
            if (aqi) {
                parameters["aqi"] = "yes"
            }
            return .requestParameters(
                parameters: parameters, encoding: URLEncoding.queryString)
        
        case .forecast(city: let city, days: let days, aqi: let aqi, alerts: let alerts):
            var parameters = [ "key" : Api.apiKey, "q" : city, "days" : days ] as [String : Any]
            if aqi {
                parameters["aqi"] = "yes"
            }
            if alerts {
                parameters["alerts"] = "yes"
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        
        case .autoComplete(inputCity: let inputCity):
            return .requestParameters(parameters: [ "key" : Api.apiKey, "q" : inputCity], encoding: URLEncoding.queryString)
        }
    }
}
