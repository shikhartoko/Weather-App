//
//  ForecastWeatherTableViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

internal class ForecastWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet internal weak var dayLabel: UILabel!
    @IBOutlet internal weak var dayConditionImage: UIImageView!
    @IBOutlet internal weak var minTempLabel: UILabel!
    @IBOutlet internal weak var avgTempLabel: UILabel!
    @IBOutlet internal weak var maxTempLabel: UILabel!
    
}
