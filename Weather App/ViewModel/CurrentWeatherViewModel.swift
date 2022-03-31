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
    internal let locationName = Box("Loading..")
    internal let currentWeatherDescription = Box(CurrentWeatherCompact())
    internal let currentAirQuality = Box(AirQualityCompact())
    internal let currentWindDescription = Box(WindCompact())
    internal var forecastedData = Box([DayForecastCompact]())
    internal var backGroundImage = Box(UIImage())
    internal var hourforecastToday = Box([HourForecastCompact]())
    internal var astroToday = Box(AstroCompact())
    
    var alertDelegate : ShowAlertDelegate?
    
    private static func roundTwoDecimal (value: Double) -> String {
        let val = round(value * 100) / 100.0
        let ans = String(format: "%g", val)
        return ans
    }
    
    public static var defaultAddress = "New Delhi"
    
    private func checkCondition(conditionText : String) -> String {
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
            conditionText.contains("cloud") || conditionText.contains("overcast"){
            return "clear"
        }
        return "default"
    }
    
    private func getBackgroundImage(day: Int, conditionText: String) -> UIImage {
        let condition = conditionText.lowercased()
        var conditionName = checkCondition(conditionText: condition)
        if conditionName == "default" || conditionName == "thunder" {
            return UIImage(named: conditionName)!
        }
        if day == 1 {
            conditionName += "Day"
        } else {
            conditionName += "Night"
        }
        return UIImage(named: conditionName)!
    }
    
    public func setCurrentLocation () {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()

        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            changeLocation(to: "\(locManager.location!.coordinate.latitude), \(locManager.location!.coordinate.longitude)")
        }
    }
    
    public func setForecastedData (futureDayForecast : [ForecastDay]) {
        var tempForecastedData = [DayForecastCompact]()
        // excluding first index since it corrosponds to current day
        for i in 1..<futureDayForecast.count {
            let dayForecast = futureDayForecast[i]
            tempForecastedData.append(DayForecastCompact(day: dayForecast.date, condnUrl: dayForecast.day.condition.icon, minTemp:  WeatherViewModel.roundTwoDecimal(value: dayForecast.day.mintempC) , avgTemp: WeatherViewModel.roundTwoDecimal(value: dayForecast.day.avgtempC), maxTemp: WeatherViewModel.roundTwoDecimal(value: dayForecast.day.maxtempC)))
        }
        self.forecastedData.value = tempForecastedData
    }
    
    public func setHourlyData (HourDayData : [HourForecast]) {
        var temp = [HourForecastCompact]()
        for i in 0..<HourDayData.count {
            let hourData = HourDayData[i]
            temp.append(HourForecastCompact(temp: WeatherViewModel.roundTwoDecimal(value: hourData.tempC), cndnUrl: hourData.condition.icon, time: hourData.time))
        }
        self.hourforecastToday.value = temp
    }
    
    public func changeLocation (to city: String) {
        locationName.value = "Loading"
        ApiFunctions.fetchForecastedData(city: city, days: 11, aqi: true, alerts: false) { data, errorString in
            if let errorString = errorString {
                self.alertDelegate?.showAlert(alertMessage: errorString)
                return
            }
            guard let data = data else {
                return
            }
            self.currentWeatherDescription.value = CurrentWeatherCompact(location: data.location.name, temp: WeatherViewModel.roundTwoDecimal(value: data.current.tempC), condition: data.current.condition.text, lat: WeatherViewModel.roundTwoDecimal(value: data.location.lat), long: WeatherViewModel.roundTwoDecimal(value: data.location.lon))
            
            self.currentAirQuality.value = AirQualityCompact(co: WeatherViewModel.roundTwoDecimal(value: data.current.airQuality.co), no2: WeatherViewModel.roundTwoDecimal(value: data.current.airQuality.no2), pm25: WeatherViewModel.roundTwoDecimal(value: data.current.airQuality.pm25), pm10: WeatherViewModel.roundTwoDecimal(value: data.current.airQuality.pm10))
            
            self.currentWindDescription.value = WindCompact(speed: WeatherViewModel.roundTwoDecimal(value: data.current.windMph), degree: WeatherViewModel.roundTwoDecimal(value: Double(data.current.windDegree)), direction: data.current.windDir)
            
            self.backGroundImage.value = self.getBackgroundImage(day: data.current.isDay, conditionText: data.current.condition.text)
            
            self.setForecastedData(futureDayForecast: data.forecast.forecastday)
            
            // using first day since it corrosponds to current day
            self.setHourlyData(HourDayData: data.forecast.forecastday[0].hour)
            
            let todayAstroData = data.forecast.forecastday[0].astro
            self.astroToday.value = AstroCompact(sunrise: todayAstroData.sunrise, sunset: todayAstroData.sunset, moonrise: todayAstroData.moonrise, moonset: todayAstroData.moonset)
        }
    }
    
    internal init() {
        setCurrentLocation()
    }
}
