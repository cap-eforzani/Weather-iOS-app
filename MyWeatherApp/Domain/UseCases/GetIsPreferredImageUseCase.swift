//
//  GetImageUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

enum GetIsPreferredImageUseCaseError: Error {
    case imageNotFound
}

protocol GetIsPreferredImageUseCase {
    func execute(isPreferred: Bool) throws -> UIImage
}

final class DefaultGetIsPreferredImageUseCase : GetIsPreferredImageUseCase {

    private let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func execute(isPreferred: Bool) throws -> UIImage {
        return try imageRepository.getUIImageForCityCell(isPreferred: isPreferred)
    }
}
