//
//  UITableView.swift
//  Weather App
//
//  Created by Shikhar Sharma on 13/04/22.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

}
