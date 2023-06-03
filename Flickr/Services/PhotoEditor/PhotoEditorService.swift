//
//  PhotoEditorService.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//

import CoreImage

protocol PhotoEditorServiceProtocol {
    func prNames()
}

class PhotoEditorService: PhotoEditorServiceProtocol {
    let filterNames = CIFilter.filterNames(inCategory: nil)
    
    func prNames() {
        for filter in filterNames {
            print(filter)
        }
    }
}
