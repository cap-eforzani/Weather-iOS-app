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
        citiesList.register(CityTableViewCell.register(), forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CityTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(CityTableViewCell.self) with reuseIdentifier: \(CityTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: self.cellDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightOfCell()
    }
}
