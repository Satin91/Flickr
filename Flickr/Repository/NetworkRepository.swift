//
//  NetworkRepository.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit
import Alamofire
import AlamofireImage

protocol NetworkRepositoryProtocol {
    func parseJson<T: Decodable>(url: String, params: [String: Any], type: T.Type) async throws -> T
    func downloadImage(url: String) async throws -> UIImage
}

class NetworkRepository: NetworkRepositoryProtocol {
    
    func parseJson<T: Decodable>(url: String, params: [String : Any], type: T.Type) async throws -> T {
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: params).responseDecodable(of: type.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func downloadImage(url: String) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseImage { response in
                switch response.result {
                case .success(let image):
                    continuation.resume(returning: image)
                case .failure(let downloadError):
                    continuation.resume(throwing: downloadError)
                }
            }
        }
    }
}
