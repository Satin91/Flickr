//
//  NetworkRepository.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import Alamofire
import AlamofireImage
import UIKit

protocol NetworkServiceProtocol {
    func parseJson<T: Decodable>(url: String, params: [String: Any], type: T.Type) async throws -> T
    func downloadImage(url: String) async throws -> UIImage
}

class NetworkService: NetworkServiceProtocol {
    func parseJson<T: Decodable>(url: String, params: [String: Any], type: T.Type) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
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
        try await withCheckedThrowingContinuation { continuation in
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
