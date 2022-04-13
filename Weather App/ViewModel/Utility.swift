//
//  Utility.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation
import UIKit

extension String {
    func getImageLocationFromUrl () -> String {
        guard self.count >= 18 else {
            return ""
        }
        let ch = self[self.index(self.endIndex, offsetBy: -11)]
        if ch == "d" {
            return String(self[self.index(self.endIndex, offsetBy: -11)..<self.index(self.endIndex, offsetBy: -4)])
        }
        return String(self[self.index(self.endIndex, offsetBy: -13)..<self.index(self.endIndex, offsetBy: -4)])
    }
    func lastFiveSubstring () -> String {
        guard self.count >= 5 else {
            return ""
        }
        return String(self[self.index(self.endIndex, offsetBy: -5)..<self.endIndex])
    }
}

protocol ShowAlertDelegate: AnyObject {
    func showAlert(alertMessage : String)
}

extension Collection {

    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {
    
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
}

extension UITableView {
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
    }
    
}
