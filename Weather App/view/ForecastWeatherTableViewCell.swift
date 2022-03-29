//
//  ForecastWeatherTableViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

class ForecastWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var DayConditionImage: UIImageView!
    @IBOutlet weak var MinTempLabel: UILabel!
    @IBOutlet weak var AvgTempLabel: UILabel!
    @IBOutlet weak var MaxTempLabel: UILabel!
    
    static let id : String = "forecastWeatherTableCellID"

}
