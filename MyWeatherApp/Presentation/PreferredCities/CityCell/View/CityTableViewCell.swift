//
//  CityTableViewCell.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CityTableViewCell.self)
    
    public static func register() -> UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }

    @IBOutlet weak var countryAndStateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!

    private var viewModel: CityTableViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        setupBackView()
        setupCityNameLabel()
        setupCountryAndStateLabel()
    }
    
    private func setupBackView() {
        backView.round()
    }
    
    private func setupCityNameLabel() {
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        cityNameLabel.textColor = UIColor.black
    }
    
    private func setupCountryAndStateLabel() {
        countryAndStateLabel.textColor = .systemGray
    }
    
    func fill(with viewModel: CityTableViewCellViewModel) {
        self.viewModel = viewModel
        
        cityNameLabel.text = viewModel.cityName
        countryAndStateLabel.text = viewModel.getCountryAndStateText()
    }
}
