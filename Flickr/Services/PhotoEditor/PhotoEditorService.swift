//
//  PhotoEditorService.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//

import CoreImage.CIFilterBuiltins
import UIKit

protocol PhotoEditorServiceProtocol {
    func applyBuiltInEffect(image: UIImage, effectType: PhotoFilterType?) async -> UIImage
}

class PhotoEditorService: PhotoEditorServiceProtocol {
    func applyBuiltInEffect(image: UIImage, effectType: PhotoFilterType?) async -> UIImage {
        let input = CIImage(image: image)
        guard let filter = self.setFilter(type: effectType) else { return image }
        filter.inputImage = input
        guard let output = filter.outputImage else {
            return UIImage(systemName: "photo")!
        }
        let context = CIContext()
        guard let cgImage = context.createCGImage(output, from: output.extent) else { return UIImage(systemName: "photo")! }
        return UIImage(cgImage: cgImage)
    }
    
    private func setFilter(type: PhotoFilterType?) -> (CIFilter & CIPhotoEffect)? {
        switch type {
        case .photoEffectChrome:
            return CIFilter.photoEffectChrome()
        case .photoEffectFade:
            return CIFilter.photoEffectFade()
        case .photoEffectInstant:
            return CIFilter.photoEffectInstant()
        case .photoEffectMono:
            return CIFilter.photoEffectMono()
        case .photoEffectNoir:
            return CIFilter.photoEffectNoir()
        case .photoEffectProcess:
            return CIFilter.photoEffectProcess()
        case .photoEffectTonal:
            return CIFilter.photoEffectTonal()
        case .photoEffectTransfer:
            return CIFilter.photoEffectTransfer()
        case .none:
            return nil
        }
    }
}

enum PhotoFilterType {
    case photoEffectChrome
    case photoEffectFade
    case photoEffectInstant
    case photoEffectMono
    case photoEffectNoir
    case photoEffectProcess
    case photoEffectTonal
    case photoEffectTransfer
}
