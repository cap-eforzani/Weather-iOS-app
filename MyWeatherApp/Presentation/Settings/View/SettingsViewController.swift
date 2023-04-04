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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: viewModel.screenTitle, isBackButtonEnabled: true, didTapBackButton: viewModel.didTapNavigationBarBackButton, isRightButtonEnabled: false)
        setupViews()
        bind(to: viewModel)
    }
    
    static func create(with viewModel: SettingsViewModel) -> SettingsViewController {
        let view = SettingsViewController()
        view.viewModel = viewModel
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
