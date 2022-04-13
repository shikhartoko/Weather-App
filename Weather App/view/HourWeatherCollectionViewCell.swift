//
//  HourWeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

internal class HourWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet internal weak var timeLabel: UILabel!
    @IBOutlet internal weak var tempLabel: UILabel!
    @IBOutlet internal weak var conditionIcon: UIImageView!
    internal static let id : String = "HourWeatherCollectionViewCellId"
}
