//
//  GetImageUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

enum GetUIImageFromImageRepositoryUseCaseError: Error {
    case imageNotFound
}

protocol GetUIImageFromImageRepositoryUseCase {
    func execute(image: ImageAvailableFromImageRepository) throws -> UIImage
}

final class DefaultGetUIImageFromImageRepositoryUseCase : GetUIImageFromImageRepositoryUseCase {

    private let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func execute(image: ImageAvailableFromImageRepository) throws -> UIImage {
        return try imageRepository.getUIImage(image: image)
    }
}
