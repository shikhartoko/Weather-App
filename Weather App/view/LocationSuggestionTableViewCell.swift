//
//  LocationSuggestionTableViewCell.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import UIKit

class LocationSuggestionTableViewCell: UITableViewCell {
    
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var regionLabel: UILabel!
    @IBOutlet public weak var countryLabel: UILabel!
    @IBOutlet public weak var bgView: UIView!
    public static let id = "locationSuggestionTableCellId"

}
