//
//  PreferredCitiesViewController+TableView.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation
import UIKit

extension PreferredCitiesListViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.viewModel.getNumberOfPreferredCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }
    
    func registerCells() {
        tableView.register(CityTableViewCell.register(), forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CityTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(CityTableViewCell.self) with reuseIdentifier: \(CityTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        let cellData = cellDataSource[indexPath.row]
        cell.fill(with: cellData)
        cell.selectionStyle = .none
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightOfCell()
    }
}

extension PreferredCitiesListViewController : CityTableViewCellDelegate {

    func didTapImageButton(index: Int) {
        viewModel.didTapCityCellImageButton(index: index)
        tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
    }
}
