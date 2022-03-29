//
//  SearchLocationViewController.swift
//  Weather App
//
//  Created by Shikhar Sharma on 23/03/22.
//

import UIKit

class SearchLocationViewController: UIViewController {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var locationSuggestionTable: UITableView!
    
    static let id = "searchLocationViewController"
    
    let searchLocVM = SearchLocationViewModel()
    var currentWeatherViewModel = WeatherViewModel()
    var searchSuggestions : [SearchSuggestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchBar.delegate = self
        locationSearchBar.placeholder = "Enter Location Name"
        locationSuggestionTable.delegate = self
        locationSuggestionTable.dataSource = self
        
        // data binding
        searchLocVM.searchSuggestion.bind { [weak self] data in
            self?.searchSuggestions = data
            self?.locationSuggestionTable.reloadData()
        }
    }

}

extension SearchLocationViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count > 3) {
            searchLocVM.getSuggestions(query: searchText)
        }
    }
}

extension SearchLocationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchSuggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.searchSuggestions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationSuggestionTableViewCell.id) as! LocationSuggestionTableViewCell
        cell.nameLabel.text = item.name
        cell.regionLabel.text = item.region
        cell.countryLabel.text = item.country
        cell.bgView.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.searchSuggestions[indexPath.row]
        currentWeatherViewModel.changeLocation(to: item.name, isAqi: true)
        dismiss(animated: true, completion: nil)
        
    }
}
