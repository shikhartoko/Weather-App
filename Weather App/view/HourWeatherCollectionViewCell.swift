//
//  HourWeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

class HourWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet public weak var timeLabel: UILabel!
    @IBOutlet public weak var tempLabel: UILabel!
    @IBOutlet public weak var conditionIcon: UIImageView!
    static let id : String = "HourWeatherCollectionViewCellId"
}
