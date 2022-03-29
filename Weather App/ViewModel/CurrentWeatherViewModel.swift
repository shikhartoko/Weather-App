//
//  CurrentWeatherViewModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation
import UIKit
import CoreLocation

public class WeatherViewModel {
    let locationName = Box("Loading..")
    let currentWeatherDescription = Box(CurrentWeatherViewModel())
    let currentAirQuality = Box(AirQualityViewModel())
    let currentWindDescription = Box(WindViewModel())
    var forecastedData = Box([DayForecastModel]())
    var backGroundImage = Box(UIImage())
    var hourforecastToday = Box([HourForecastModel]())
    var astroToday = Box(AstroModel())
    
    private static func roundTwoDecimalLabel (value: Double) -> String {
        let val = round(value * 100) / 100.0
        let ans = String(format: "%g", val)
        return ans
    }
    
    public static var defaultAddress = "New Delhi"
    
    func checkCondition(conditionText : String) -> String {
        if conditionText.contains("snow") || conditionText.contains("ice") ||
            conditionText.contains("blizzard") ||
            conditionText.contains("Blizzard"){
            return "snow"
        }
        if conditionText.contains("rain") || conditionText.contains("drizzle") || conditionText.contains("sleet"){
            return "rain"
        }
        if conditionText.contains("thunder") {
            return "thunder"
        }
        if conditionText.contains("mist") ||
            conditionText.contains("fog") {
            return "mist"
        }
        if conditionText.contains("sunny") ||
            conditionText.contains("clear") ||
            conditionText.contains("cloud") {
            return "clear"
        }
        return "default"
    }
    
    func getBackgroundImage(isDay: Int, conditionText: String) -> UIImage {
        let condition = conditionText.lowercased()
        var conditionName = checkCondition(conditionText: condition)
        if conditionName == "default" || conditionName == "thunder" {
            return UIImage(named: conditionName)!
        }
        if isDay == 1 {
            conditionName += "Day"
        } else {
            conditionName += "Night"
        }
        return UIImage(named: conditionName)!
    }
    
    func setCurrentLocation () {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!

        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            changeLocation(to: "\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)", isAqi: true)
        }
    }
    
    func changeLocation (to city: String, isAqi: Bool) {
        locationName.value = "Loading"
        ApiFunctions.fetchForecastedData(city: city, days: 11, aqi: isAqi, alerts: false) { data in
            self.currentWeatherDescription.value = CurrentWeatherViewModel(location: data.location.name, temp: WeatherViewModel.roundTwoDecimalLabel(value: data.current.tempC), condition: data.current.condition.text, lat: WeatherViewModel.roundTwoDecimalLabel(value: data.location.lat), long: WeatherViewModel.roundTwoDecimalLabel(value: data.location.lon))
            self.currentAirQuality.value = AirQualityViewModel(co: WeatherViewModel.roundTwoDecimalLabel(value: data.current.airQuality.co), no2: WeatherViewModel.roundTwoDecimalLabel(value: data.current.airQuality.no2), pm25: WeatherViewModel.roundTwoDecimalLabel(value: data.current.airQuality.pm25), pm10: WeatherViewModel.roundTwoDecimalLabel(value: data.current.airQuality.pm10))
            self.currentWindDescription.value = WindViewModel(speed: WeatherViewModel.roundTwoDecimalLabel(value: data.current.windMph), degree: WeatherViewModel.roundTwoDecimalLabel(value: Double(data.current.windDegree)), direction: data.current.windDir)
            self.backGroundImage.value = self.getBackgroundImage(isDay: data.current.isDay, conditionText: data.current.condition.text)
            var tempForecastedData = [DayForecastModel]()
            for i in 1..<data.forecast.forecastday.count {
                let dayForecast = data.forecast.forecastday[i]
                tempForecastedData.append(DayForecastModel(day: dayForecast.date, condnUrl: dayForecast.day.condition.icon, minTemp:  WeatherViewModel.roundTwoDecimalLabel(value: dayForecast.day.mintempC) , avgTemp: WeatherViewModel.roundTwoDecimalLabel(value: dayForecast.day.avgtempC), maxTemp: WeatherViewModel.roundTwoDecimalLabel(value: dayForecast.day.maxtempC)))
            }
            self.forecastedData.value = tempForecastedData
            var temp = [HourForecastModel]()
            let todayForecastedHourData = data.forecast.forecastday[0].hour
            for i in 0..<todayForecastedHourData.count {
                let hourData = todayForecastedHourData[i]
                temp.append(HourForecastModel(temp: WeatherViewModel.roundTwoDecimalLabel(value: hourData.tempC), cndnUrl: hourData.condition.icon, time: hourData.time))
            }
            self.hourforecastToday.value = temp
            let todayAstroData = data.forecast.forecastday[0].astro
            self.astroToday.value = AstroModel(sunrise: todayAstroData.sunrise, sunset: todayAstroData.sunset, moonrise: todayAstroData.moonrise, moonset: todayAstroData.moonset)
        }
    }
    func isValidLocation (location: String) -> Bool {
        return true
    }
    
    init() {
        setCurrentLocation()
    }
}
