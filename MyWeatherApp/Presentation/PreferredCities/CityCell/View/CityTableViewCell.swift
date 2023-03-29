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

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var countryAndStateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!

    private var viewModel: CityTableViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    @objc func didFavoriteImageTapped(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            viewModel.setCityToPreferred()
            viewModel.getIsPreferredImage()
        }
    }
    
    private func bind(to viewModel: CityTableViewCellViewModel) {
        viewModel.isPreferredImage.observe(on: favoriteImage) { isPreferredImage in
            DispatchQueue.main.async {
                self.favoriteImage.image = isPreferredImage
            }
        }
    }
    
    private func setupViews() {
        setupBackView()
        setupCityNameLabel()
        setupCountryAndStateLabel()
        setupLatAndLonLabel()
        setupFavoriteImage()
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
    
    private func setupLatAndLonLabel() {
        latLabel.textColor = .systemGray
        lonLabel.textColor = .systemGray
    }
    
    private func setupFavoriteImage() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didFavoriteImageTapped))
        favoriteImage.addGestureRecognizer(imageTapGestureRecognizer)
        favoriteImage.isUserInteractionEnabled = true
    }
    
    func fill(with viewModel: CityTableViewCellViewModel) {
        self.viewModel = viewModel
        bind(to: viewModel)

        viewModel.getIsPreferredImage()
        cityNameLabel.text = viewModel.getCityName()
        countryAndStateLabel.text = viewModel.getCountryAndStateText()
        latLabel.text = viewModel.getLatText()
        lonLabel.text = viewModel.getLonText()
    }
}
