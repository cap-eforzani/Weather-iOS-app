//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lattitudeAndLongitudeLabel: UILabel!
    @IBOutlet weak var lattitudeAndLongitudeSwitch: UISwitch!
    
    var viewModel: SettingsViewModel!
    var navigationBar: NavigationBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(with: self.navigationBar, isBackButtonEnabled: true, isSettingsButtonEnabled: false)
        setupViews()
        bind(to: viewModel)
    }
    
    static func create(with viewModel: SettingsViewModel, navigationBar: NavigationBarViewModel) -> SettingsViewController {
        let view = SettingsViewController()
        view.viewModel = viewModel
        view.navigationBar = navigationBar
        return view
    }
    
    private func setupViews() {
        setupLattitudeAndLongitudeLabel()
    }
    
    private func bind(to viewModel: SettingsViewModel) {
        viewModel.showLattitudeAndLongitude.observe(on: viewModel.showLattitudeAndLongitude) { showLattitudeAndLongitude in
            self.lattitudeAndLongitudeSwitch.setOn(showLattitudeAndLongitude, animated: true)
        }
    }

    @IBAction func didTapLattitudeAndLongitudeSwitch(_ sender: Any) {
        viewModel.didTapLattitudeAndLongitudeSwitch()
    }
    
    private func setupLattitudeAndLongitudeLabel() {
        lattitudeAndLongitudeLabel.text = "Show lattitude and longitude"
    }
}
