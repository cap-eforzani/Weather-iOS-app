//
//  PreferredCitiesViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import UIKit

class PreferredCitiesListViewController: UIViewController {

    @IBOutlet weak var noPreferredCityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PreferredCitiesListViewModel!

    private var floatingButton: FloatingButton = FloatingButton(backgroundColor: .systemBlue, image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)))
    
    static func create(with viewModel: PreferredCitiesListViewModel) -> PreferredCitiesListViewController {
        let view = PreferredCitiesListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {        
        title = viewModel.screenTitle
        
        view.addSubview(floatingButton.button)
        floatingButton.button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)

        setupNoPreferredCityLabel()
        setupTableView()
    }
    
    private func setupNoPreferredCityLabel() {
        let preferredCitiesLabels = viewModel.getNumberOfPreferredCities()

        noPreferredCityLabel.isEnabled = false;
        noPreferredCityLabel.isHidden = preferredCitiesLabels == 0 ? false : true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.button.frame = CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 100, width: 60, height: 60)
    }

    @objc private func didTapFloatingButton() {
        viewModel.didTapFloatingButton()
    }
}
