//
//  DIContainer.swift
//  Flickr
//
//  Created by Артур Кулик on 31.05.2023.
//

import Foundation

class DIContainer {
    static var shared = DIContainer()
    var networkRepository: NetworkRepositoryProtocol
    var networkInteractor: NetworkInteractorProtocol
    
    init() {
        networkRepository = NetworkRepository()
        networkInteractor = NetworkInteractor(networkRepository: networkRepository)
    }
    
    func createMainViewModel() -> MainViewModel {
        let mainViewModel = MainViewModel(NetworkInteractor: networkInteractor)
        return mainViewModel
    }
}
