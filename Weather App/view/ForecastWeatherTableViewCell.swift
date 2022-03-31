//
//  ForecastWeatherTableViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

public class ForecastWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet public weak var dayLabel: UILabel!
    @IBOutlet public weak var dayConditionImage: UIImageView!
    @IBOutlet public weak var minTempLabel: UILabel!
    @IBOutlet public weak var avgTempLabel: UILabel!
    @IBOutlet public weak var maxTempLabel: UILabel!
    
    public static let id : String = "forecastWeatherTableCellID"

}
