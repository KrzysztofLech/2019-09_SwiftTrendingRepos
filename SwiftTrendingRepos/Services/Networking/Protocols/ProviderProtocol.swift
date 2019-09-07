//
//  ProviderProtocol.swift
//

import UIKit

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void)
}
