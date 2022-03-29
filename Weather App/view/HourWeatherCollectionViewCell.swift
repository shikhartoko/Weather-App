//
//  HourWeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 17/03/22.
//

import UIKit

class HourWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    static let id : String = "HourWeatherCollectionViewCellId"
}
