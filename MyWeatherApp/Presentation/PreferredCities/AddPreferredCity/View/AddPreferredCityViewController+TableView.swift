//
//  AddPreferredCityViewController+TableView.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation
import UIKit

extension AddPreferredCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.citiesList.delegate = self
        self.citiesList.dataSource = self
        self.citiesList.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.citiesList.reloadData()
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.viewModel.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }
    
    func registerCells() {
        citiesList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = self.cities[indexPath.row]
        cell.textLabel?.text = viewModel.getTitleOfCityCell(city: city)
        return cell
    }
}
