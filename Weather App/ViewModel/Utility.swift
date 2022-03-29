//
//  Utility.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

extension DateFormatter {
    func dateTimeFormatted (unixTimeStamp : Double?) -> String {
        if unixTimeStamp == nil {
            return "No Time Stamp returned"
        }
        if let timeResult = (unixTimeStamp as? Double?) {
            let date = Date(timeIntervalSince1970: timeResult!)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return "Invalid Time Stamp"
    }
}

extension String {
    func getImageLocationFromUrl () -> String{
        let ch = self[self.index(self.endIndex, offsetBy: -11)]
        if ch == "d" {
            return String(self[self.index(self.endIndex, offsetBy: -11)..<self.index(self.endIndex, offsetBy: -4)])
        }
        return String(self[self.index(self.endIndex, offsetBy: -13)..<self.index(self.endIndex, offsetBy: -4)])
    }
    func lastFiveSubstring () -> String {
        return String(self[self.index(self.endIndex, offsetBy: -5)..<self.endIndex])
    }
}
