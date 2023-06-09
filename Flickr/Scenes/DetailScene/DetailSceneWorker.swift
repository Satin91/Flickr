//
//  DetailSceneWorker.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailSceneWorkerLogic {
    func saveObjectToDatabase(request: DetailScene.SaveToDB.Request) -> DetailScene.SaveToDB.Response
}

class DetailSceneWorker: DetailSceneWorkerLogic {
    private var databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func saveObjectToDatabase(request: DetailScene.SaveToDB.Request) -> DetailScene.SaveToDB.Response {
        databaseManager.save(object: request.realmModel)
        let response = DetailScene.SaveToDB.Response(isSaved: true)
        return response
    }
}
