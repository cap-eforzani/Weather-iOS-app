//
//  CityTableViewCell.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import UIKit

struct CityTableViewCellData {
    let name, country, state: String
    let lat, lon: Double?
    let imageData: Data
}

protocol CityTableViewCellDelegate {
    func didTapImageButton(index: Int)
}

class CityTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CityTableViewCell.self)
    
    public static func register() -> UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var imageViewButton: UIImageView!
    @IBOutlet weak var countryAndStateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var delegate: CityTableViewCellDelegate?
    var index: Int = 0
    
    func fill(with data: CityTableViewCellData) {
        cityNameLabel.text = data.name
        countryAndStateLabel.text = data.country + ", " + data.state
        setLatLabel(lat: data.lat)
        setLonLabel(lon: data.lon)
        imageViewButton.image = UIImage(data: data.imageData)
    }
    
    private func setLatLabel(lat: Double?) {
        if let latValue: Double = lat {
            latLabel.isHidden = false
            latLabel.isEnabled = true
            latLabel.text = "Latitude: " + String(format: "%f", latValue)
        } else {
            latLabel.isHidden = true
            latLabel.isEnabled = false
        }
    }
    
    private func setLonLabel(lon: Double?) {
        if let lonValue: Double = lon {
            lonLabel.isHidden = false
            lonLabel.isEnabled = true
            lonLabel.text = "Longitude: " + String(format: "%f", lonValue)
        } else {
            lonLabel.isHidden = true
            lonLabel.isEnabled = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
        
    @objc func didFavoriteImageTapped(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            delegate?.didTapImageButton(index: self.index)
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
        imageViewButton.addGestureRecognizer(imageTapGestureRecognizer)
        imageViewButton.isUserInteractionEnabled = true
    }
}
