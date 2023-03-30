//
//  PreferredCitiesViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import UIKit

class PreferredCitiesListViewController: UIViewController {

    @IBOutlet weak var noPreferredCityLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PreferredCitiesListViewModel!
    
    var cellDataSource: [CityTableViewCellViewModel] = []

    private var floatingButton: FloatingButton = FloatingButton(backgroundColor: .systemBlue, image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)))
    
    static func create(with viewModel: PreferredCitiesListViewModel) -> PreferredCitiesListViewController {
        let view = PreferredCitiesListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getPreferredCities()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.getPreferredCities()
    }
    
    private func setupViews() {        
        title = viewModel.screenTitle

        setupFloatingButton()
        setupNoPreferredCityLabel()
        setupTableView()
    }
    
    private func bind(to viewModel: PreferredCitiesListViewModel) {
        viewModel.isLoading.observe(on: activityIndicator) { isLoading in
            DispatchQueue.main.async {
                if (isLoading == true) {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.noResults.observe(on: noPreferredCityLabel) { noResults in
            let isNoResultsLabelHidden = noResults == false ? true : false
            self.showNoResultsLabel(value: isNoResultsLabelHidden)
        }
        viewModel.cellDataSource.observe(on: viewModel.cellDataSource) { cellDataSource in
            self.cellDataSource = cellDataSource
            self.reloadTableView()
        }
    }
    
    private func showNoResultsLabel(value: Bool) {
        DispatchQueue.main.async {
            self.noPreferredCityLabel.isHidden = value
        }
    }
    
    private func setupFloatingButton() {
        view.addSubview(floatingButton.button)
        floatingButton.button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    }
    
    private func setupNoPreferredCityLabel() {
        noPreferredCityLabel.isEnabled = false;
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.button.frame = CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 100, width: 60, height: 60)
    }

    @objc private func didTapFloatingButton() {
        viewModel.didTapFloatingButton()
    }
}
