//
//  AddPreferredCityViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import UIKit

class AddPreferredCityViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var citiesList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    
    var viewModel: AddPreferredCityViewModel!
    
    var cellDataSource: [CityTableViewCellData] = []
    
    static func create(with viewModel: AddPreferredCityViewModel) -> AddPreferredCityViewController {
        let view = AddPreferredCityViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: viewModel.screenTitle, isBackButtonEnabled: true, didTapBackButton: viewModel.didTapNavigationBarBackButton, isRightButtonEnabled: true, didTapRightButton: viewModel.didTapNavigationBarSettingsButton)
        setupViews()
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task { @MainActor in
            await viewModel.showLastSearch()
            self.reloadTableView()
        }
    }

    private func bind(to viewModel: AddPreferredCityViewModel) {
        viewModel.isLoading.observe(on: activityIndicator) { isLoading in
            DispatchQueue.main.async {
                if (isLoading == true) {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.noResults.observe(on: noResultsLabel) { noResults in
            let isNoResultsLabelHidden = noResults == false ? true : false
            self.showNoResultsLabel(value: isNoResultsLabelHidden)
        }
        viewModel.cellDataSource.observe(on: viewModel.cellDataSource) { cellDataSource in
            self.cellDataSource = cellDataSource
        }
    }
    
    private func showNoResultsLabel(value: Bool) {
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = value
        }
    }

    private func setupViews() {
        cityNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Type a City Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        setupTableView()
    }
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        Task { @MainActor in
            let searchValue = cityNameTextField.text ?? ""
            await viewModel.didTapSearchButton(searchValue: searchValue)
            self.reloadTableView()
        }
    }
}
