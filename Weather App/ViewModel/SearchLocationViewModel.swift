//
//  SearchLocationViewModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import Foundation
import UIKit

public class SearchLocationViewModel {
    var searchSuggestion = Box([SearchSuggestion]())
    
    func getSuggestions (query: String) -> Void {
        ApiFunctions.fetchLocationSuggestions(query: query) { [weak self] data in
            self?.searchSuggestion.value = data
        }
    }
    
    init() {
        getSuggestions(query: "New Delhi")
    }
}
