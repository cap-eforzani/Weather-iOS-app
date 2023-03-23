//
//  AddPreferredCityViewController.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import UIKit

class AddPreferredCityViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameTextField: UITextField!
    
    var viewModel: AddPreferredCityViewModel!
    
    static func create(with viewModel: AddPreferredCityViewModel) -> AddPreferredCityViewController {
        let view = AddPreferredCityViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        cityNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Type a City Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
    }
}
