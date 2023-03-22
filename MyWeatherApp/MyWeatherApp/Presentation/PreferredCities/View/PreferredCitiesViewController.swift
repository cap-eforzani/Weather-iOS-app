//
//  PreferredCitiesViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import UIKit

class PreferredCitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PreferredCitiesListViewModel = PreferredCitiesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


    func setupView() {
        self.title = "My Weather App"
        setupTableView()
    }
}
