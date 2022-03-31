//
//  SearchLocationViewController.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import UIKit

class SearchLocationViewController: UIViewController {
    
    @IBOutlet private weak var locationSearchBar: UISearchBar!
    @IBOutlet private weak var locationSuggestionTable: UITableView!
    
    static let id = "searchLocationViewController"
    
    public let searchLocationViewManager = SearchLocationViewModel()
    public var currentWeatherViewModel = WeatherViewModel()
    public var searchSuggestions : [SearchSuggestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLocationViewManager.Delegate = self
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = "Enter Location Name"
        locationSuggestionTable.delegate = self
        locationSuggestionTable.dataSource = self
        
        // data binding
        searchLocationViewManager.searchSuggestion.bind { [weak self] data in
            self?.searchSuggestions = data
            self?.locationSuggestionTable.reloadData()
        }
    }

}

extension SearchLocationViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count > 3) {
            searchLocationViewManager.getSuggestions(query: searchText)
        }
    }
}

extension SearchLocationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchSuggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationSuggestionTableViewCell.id) as! LocationSuggestionTableViewCell
        var item : SearchSuggestion
        if indexPath.row < self.searchSuggestions.count {
            item = self.searchSuggestions[indexPath.row]
        } else {
            item = SearchSuggestion(id: 1, name: "Invalid City", region: "Invalid Region", country: "Invalid Country", lat: 12.21, lon: 23.32)
        }
        cell.nameLabel.text = item.name
        cell.regionLabel.text = item.region
        cell.countryLabel.text = item.country
        cell.bgView.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.searchSuggestions[indexPath.row]
        currentWeatherViewModel.changeLocation(to: item.name)
        dismiss(animated: true, completion: nil)
        
    }
}

extension SearchLocationViewController : ShowAlertDelegate {
    func showAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Error Occured", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
