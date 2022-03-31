//
//  MainScreenViewController.swift
//  Weather App
//
//  Created by Shikhar Sharma on 16/03/22.
//

import UIKit
import CoreLocation

internal final class MainScreenViewController: UIViewController {

    // Current Weather View
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var currentWeatherCondn: UILabel!
    @IBOutlet private weak var currentLocationLat: UILabel!
    @IBOutlet private weak var currentLocationLong: UILabel!
    @IBAction private func openSearchLocationScreen(_ sender: Any) {
        let searchLocationVC = storyboard?.instantiateViewController(withIdentifier: SearchLocationViewController.id) as! SearchLocationViewController
        searchLocationVC.modalPresentationStyle = .fullScreen
        searchLocationVC.currentWeatherViewModel = currentWeatherViewModel
        present(searchLocationVC, animated: true)
    }
    @IBOutlet private weak var openSearchBtn: UIButton!
    @IBAction private func setCurrentLocation(_ sender: Any) {
        currentWeatherViewModel.setCurrentLocation()
    }
    @IBOutlet private weak var currentLocationBtn: UIButton!
    
    // Hourly Weather View
    @IBOutlet private weak var hourlyWeatherCollectionView: UICollectionView!
    
    // 10 Day ForeCast View
    @IBOutlet private weak var forecastTableView: UITableView!
    
    // Weather Details 1
    // Air Quality
    @IBOutlet private weak var cOValueLabel: UILabel!
    @IBOutlet private weak var nO2ValueLabel: UILabel!
    @IBOutlet private weak var pM25ValueLabel: UILabel!
    @IBOutlet private weak var pM10ValueLabel: UILabel!
    
    // Wind
    @IBOutlet private weak var speedValueLabel: UILabel!
    @IBOutlet private weak var degreeValueLabel: UILabel!
    @IBOutlet private weak var directionValueLabel: UILabel!
    
    // Astro
    
    @IBOutlet private weak var sunriseTimeLabel: UILabel!
    @IBOutlet private weak var sunsetTimeLabel: UILabel!
    @IBOutlet private weak var moonRiseTimeLabel: UILabel!
    @IBOutlet private weak var moonsetTimeLabel: UILabel!
    
    private let currentWeatherViewModel = WeatherViewModel()
    private var forecastData : [DayForecastCompact] = []
    private var todayForecast : [HourForecastCompact] = []
    
    private func bindViewModel () {
        currentWeatherViewModel.alertDelegate = self
        
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backGroundImage, at: 0)
        
        currentWeatherViewModel.currentWeatherDescription.bind { [weak self] currentWeatherView in
            self?.locationLabel.text = currentWeatherView.location
            self?.currentTempLabel.text = "\(currentWeatherView.temp)°"
            self?.currentWeatherCondn.text = currentWeatherView.condition
            self?.currentLocationLat.text = "H:\(currentWeatherView.lat)°"
            self?.currentLocationLong.text = "L:\(currentWeatherView.long)°"
        }
        currentWeatherViewModel.currentAirQuality.bind { [weak self] airQualityView in
            self?.cOValueLabel.text = airQualityView.co
            self?.nO2ValueLabel.text = airQualityView.no2
            self?.pM25ValueLabel.text = airQualityView.pm25
            self?.pM10ValueLabel.text = airQualityView.pm10
        }
        currentWeatherViewModel.currentWindDescription.bind { [weak self] windViewModel in
            self?.speedValueLabel.text = windViewModel.speed
            self?.degreeValueLabel.text = windViewModel.degree
            self?.directionValueLabel.text = windViewModel.direction
        }
        currentWeatherViewModel.forecastedData.bind { [weak self] tempForecastDataList in
            self?.forecastData = tempForecastDataList
            self?.forecastTableView.reloadData()
        }
        currentWeatherViewModel.hourforecastToday.bind { [weak self] hourForecastData in
            self?.todayForecast = hourForecastData
            self?.hourlyWeatherCollectionView.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourlyWeatherCollectionView.delegate = self
        hourlyWeatherCollectionView.dataSource = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self

        bindViewModel()
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurview = UIVisualEffectView(effect: blurEffect)
        blurview.frame = UIScreen.main.bounds
        self.view.insertSubview(blurview, at: 1)
        
        openSearchBtn.layer.cornerRadius = 10
        currentLocationBtn.layer.cornerRadius = 10
    }
    
}

extension MainScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.todayForecast.count)
        return self.todayForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourWeatherCollectionViewCell.id, for: indexPath) as! HourWeatherCollectionViewCell
        let item = self.todayForecast[indexPath.row]
        cell.tempLabel.text = item.temp
        let img = UIImage(named: item.cndnUrl.getImageLocationFromUrl())
        cell.conditionIcon.image = img
        cell.timeLabel.text = item.time.lastFiveSubstring()
        cell.layer.cornerRadius = 10
        return cell
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
        cell.dayLabel?.text = item.day.lastFiveSubstring()
        cell.dayConditionImage.image = UIImage(named: item.condnUrl.getImageLocationFromUrl())
        cell.minTempLabel?.text = item.minTemp
        cell.avgTempLabel?.text = item.avgTemp
        cell.maxTempLabel?.text = item.maxTemp
        return cell
    }
}

extension MainScreenViewController : ShowAlertDelegate {
    func showAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

