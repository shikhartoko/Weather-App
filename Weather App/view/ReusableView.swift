//
//  ReusableView.swift
//  Weather App
//
//  Created by Shikhar Sharma on 13/04/22.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
