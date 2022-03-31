//
//  SearchLocationViewModel.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import Foundation

final public class SearchLocationViewModel {
    internal var searchSuggestion = Box([SearchSuggestion]())
    
    var Delegate : ShowAlertDelegate?
    
    public func getSuggestions (query: String) -> Void {
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
    
    public init() {
        getSuggestions(query: "New Delhi")
    }
}
