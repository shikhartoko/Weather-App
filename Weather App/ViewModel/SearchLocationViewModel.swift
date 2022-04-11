//
//  SearchLocationViewModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import Foundation

final internal class SearchLocationViewModel {
    internal var searchSuggestion = Box([SearchSuggestion]())
    
    weak var Delegate : ShowAlertDelegate?
    
    internal func getSuggestions (query: String) -> Void {
        ApiFunctions.fetchLocationSuggestions(query: query) { [weak self] data, errorString in
            if let errorString = errorString {
                self?.Delegate?.showAlert(alertMessage: errorString)
                return
            }
            guard let data = data else {
                return
            }
            self?.searchSuggestion.value = data
        }
    }
    
    internal init() {
        getSuggestions(query: "New Delhi")
    }
}
