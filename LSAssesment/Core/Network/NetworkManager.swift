//
//  NetworkManager.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

enum NetworkError: String {
    case url = "Couldn't convert string to url"
    case data = "Data is empty"
    case unknown = "Something went wrong. Please try again late"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchGameData(requestParameter: RequestModel, complationHandler: @escaping (ResponseModel?, String?)->()) {
        guard var components = URLComponents(string: AppEndpoint.url) else {
            complationHandler(nil, NetworkError.url.rawValue)
            return
        }
        components.queryItems = requestParameter.convertQueryParams.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            complationHandler(nil, NetworkError.url.rawValue)
            return
        }
        let request = URLRequest(url: url)
        
        ActivityIndicator.shared.showIndicator()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                ActivityIndicator.shared.stopIndicator()
                complationHandler(nil, error.localizedDescription)
                return
            }
            if self.isSuccessCode(response) {
                guard let data = data else {
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, NetworkError.data.rawValue)
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(ResponseModel.self, from: data)
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(model, nil)
                } catch (let error) {
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func fetchGameDetail(id: String, complationHandler: @escaping (DetailModel?, String?)->()) {
        guard let url = URL(string: AppEndpoint.url + "/" + id) else {
            complationHandler(nil, NetworkError.url.rawValue)
            return
        }
        let request = URLRequest(url: url)
        ActivityIndicator.shared.showIndicator()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                ActivityIndicator.shared.stopIndicator()
                complationHandler(nil, error.localizedDescription)
                return
            }
            if self.isSuccessCode(response) {
                guard let data = data else {
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, NetworkError.data.rawValue)
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(DetailModel.self, from: data)
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(model, nil)
                } catch (let error) {
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
}

extension NetworkManager {
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return urlResponse.statusCode >= 200 && urlResponse.statusCode < 300
    }
}
