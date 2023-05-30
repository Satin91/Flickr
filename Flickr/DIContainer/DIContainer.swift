//
//  DIContainer.swift
//  Flickr
//
//  Created by Артур Кулик on 31.05.2023.
//

import Foundation

class DIContainer {
    static var shared = DIContainer()
    
    func createMainViewModel() -> MainViewModel {
        let networkRepository = NetworkRepository()
        let networkInteractor = NetworkInteractor(networkRepository: networkRepository)
        let mainViewModel = MainViewModel(NetworkInteractor: networkInteractor)
        return mainViewModel
    }
}
