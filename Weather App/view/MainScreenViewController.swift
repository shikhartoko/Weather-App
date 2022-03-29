//
//  MainScreenViewController.swift
//  Weather App
//
//  Created by Shikhar Sharma on 16/03/22.
//

import UIKit
import CoreLocation

class MainScreenViewController: UIViewController {

    // Current Weather View
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var CurrentWeatherCondn: UILabel!
    @IBOutlet weak var CurrentLocationLat: UILabel!
    @IBOutlet weak var CurrentLocationLong: UILabel!
    @IBAction func OpenSearchLocationScreen(_ sender: Any) {
        let searchLocationVC = storyboard?.instantiateViewController(withIdentifier: SearchLocationViewController.id) as! SearchLocationViewController
        searchLocationVC.modalPresentationStyle = .fullScreen
        searchLocationVC.currentWeatherViewModel = currentWeatherViewModel
        present(searchLocationVC, animated: true)
    }
    
    // Hourly Weather View
    @IBOutlet weak var HourlyWeatherCollectionView: UICollectionView!
    
    // 10 Day ForeCast View
    @IBOutlet weak var ForecastTableView: UITableView!
    
    // Weather Details 1
    // Air Quality
    @IBOutlet weak var COValueLabel: UILabel!
    @IBOutlet weak var NO2ValueLabel: UILabel!
    @IBOutlet weak var PM25ValueLabel: UILabel!
    @IBOutlet weak var PM10ValueLabel: UILabel!
    
    // Wind
    @IBOutlet weak var SpeedValueLabel: UILabel!
    @IBOutlet weak var DegreeValueLabel: UILabel!
    @IBOutlet weak var DirectionValueLabel: UILabel!
    
    // Astro
    
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var moonRiseTimeLabel: UILabel!
    @IBOutlet weak var moonsetTimeLabel: UILabel!
    
    let currentWeatherViewModel = WeatherViewModel()
    var forecastData : [DayForecastModel] = []
    var todayForecast : [HourForecastModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HourlyWeatherCollectionView.delegate = self
        HourlyWeatherCollectionView.dataSource = self
        ForecastTableView.delegate = self
        ForecastTableView.dataSource = self
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backGroundImage, at: 0)
        
        // Location
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()

        var currentLocation: CLLocation!
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locationManager.location
            print("Location Enabled")
            WeatherViewModel.defaultAddress = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
            currentWeatherViewModel.changeLocation(to: WeatherViewModel.defaultAddress, isAqi: true)
        }
        
        // data binding
        currentWeatherViewModel.currentWeatherDescription.bind { [weak self] currentWeatherView in
            self?.LocationLabel.text = currentWeatherView.location
            self?.CurrentTempLabel.text = "\(currentWeatherView.temp)°"
            self?.CurrentWeatherCondn.text = currentWeatherView.condition
            self?.CurrentLocationLat.text = "H:\(currentWeatherView.lat)°"
            self?.CurrentLocationLong.text = "L:\(currentWeatherView.long)°"
        }
        currentWeatherViewModel.currentAirQuality.bind { [weak self] airQualityView in
            self?.COValueLabel.text = airQualityView.co
            self?.NO2ValueLabel.text = airQualityView.no2
            self?.PM25ValueLabel.text = airQualityView.pm25
            self?.PM10ValueLabel.text = airQualityView.pm10
        }
        currentWeatherViewModel.currentWindDescription.bind { [weak self] windViewModel in
            self?.SpeedValueLabel.text = windViewModel.speed
            self?.DegreeValueLabel.text = windViewModel.degree
            self?.DirectionValueLabel.text = windViewModel.direction
        }
        currentWeatherViewModel.forecastedData.bind { [weak self] tempForecastDataList in
            self?.forecastData = tempForecastDataList
            self?.ForecastTableView.reloadData()
        }
        currentWeatherViewModel.hourforecastToday.bind { [weak self] hourForecastData in
            self?.todayForecast = hourForecastData
            self?.HourlyWeatherCollectionView.reloadData()
        }
        currentWeatherViewModel.backGroundImage.bind { bkgImage in
            backGroundImage.image = bkgImage
        }
        currentWeatherViewModel.astroToday.bind { [weak self] astrotodayData in
            self?.sunriseTimeLabel.text = astrotodayData.sunrise
            self?.sunsetTimeLabel.text = astrotodayData.sunset
            self?.moonRiseTimeLabel.text = astrotodayData.moonrise
            self?.moonsetTimeLabel.text = astrotodayData.moonset
        }
    }
    
}

extension MainScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.todayForecast.count)
        return self.todayForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourWeatherCollectionViewCell.id, for: indexPath) as? HourWeatherCollectionViewCell
        let item = self.todayForecast[indexPath.row]
        cell?.TempLabel.text = item.temp
        var img = UIImage(named: item.cndnUrl.getImageLocationFromUrl())!
        cell?.conditionIcon.image = img
        cell?.TimeLabel.text = item.time.lastFiveSubstring()
        cell?.layer.cornerRadius = 10
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 180)
    }
}

extension MainScreenViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.forecastData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastWeatherTableViewCell.id) as! ForecastWeatherTableViewCell
        cell.DayLabel?.text = item.day.lastFiveSubstring()
        cell.DayConditionImage.image = UIImage(named: item.condnUrl.getImageLocationFromUrl())
        cell.MinTempLabel?.text = item.minTemp
        cell.AvgTempLabel?.text = item.avgTemp
        cell.MaxTempLabel?.text = item.maxTemp
        return cell
    }
}


