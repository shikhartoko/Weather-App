//
//  Utility.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

extension String {
    func getImageLocationFromUrl () -> String{
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

protocol ShowAlertDelegate {
    func showAlert(alertMessage : String)
}
