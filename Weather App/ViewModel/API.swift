//
//  API.swift
//  Weather App
//
//  Created by Shikhar Sharma on 14/03/22.
//

import Foundation

import Moya

enum Api {
    static private let apiKey = "92bc5e97668e487cbde75839221103"

    case current(city: String, aqi: Bool)
    case forecast(city: String, days: Int, aqi: Bool, alerts: Bool)
    case autoComplete(inputCity: String)
}

extension Api: TargetType {
    var headers: [String : String]? {
        return [
            "Transfer-Encoding": "chunked",
            "Connection": "keep-alive",
            "Vary": "Accept-Encoding",
            "CDN-PullZone": "93447",
            "CDN-Uid": "8fa3a04a-75d9-4707-8056-b7b33c8ac7fe",
            "CDN-RequestCountryCode": "GB",
            "CDN-ProxyVer": "1.02",
            "CDN-RequestPullSuccess": "True",
            "CDN-RequestPullCode": "200",
            "CDN-CachedAt": "03/14/2022 06:00:01",
            "CDN-EdgeStorageId": "576",
            "CDN-Status": "200",
            "CDN-RequestId": "eaf021ba6aa45e4e1655ce60bdc357fe",
            "CDN-Cache": "MISS",
            "Cache-Control": "public, max-age=180",
            "Content-Type": "application/json",
            "Date": "Mon, 14 Mar 2022 06:00:01 GMT",
            "Server": "BunnyCDN-FR1-576"
        ]
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.weatherapi.com/v1") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .current(city: _):
            return "/current.json"
        case .forecast(city: _):
            return "/forecast.json"
        case .autoComplete(inputCity: _):
            return "/search.json"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .current(city: _, aqi: _), .forecast(city: _, days: _, aqi: _, alerts: _), .autoComplete(inputCity: _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
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
