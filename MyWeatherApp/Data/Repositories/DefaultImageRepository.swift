//
//  DefaultImageRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

final class DefaultImageRepository: ImageRepository {

    func getUIImageForCityCell(isPreferred: Bool) throws -> UIImage {
        if (isPreferred == true) {
            if let image =  UIImage(named: "FavoriteOnIcon") {
                return image
            }
        } else {
            if let image =  UIImage(named: "FavoriteOffIcon") {
                return image
            }
        }
        throw GetIsPreferredImageUseCaseError.imageNotFound
    }
}
