//
//  Endpoint.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

private let baseURL = "https://teacher.iprogrammer.uz/api"

enum NetworkEnvironment {
    case dev
    case production
    case stage
    case demo
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var root: String { get }
    var fullURL: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any]? { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
    func makeURLRequest() -> URLRequest
}

extension Endpoint {
    
    var host: String {
        switch APIClient.networkEnviroment {
        case .dev: return baseURL
        case .production: return baseURL
        case .stage: return baseURL
        case .demo: return baseURL
        }
    }

    var fullURL: String {
        return host + root + path
    }
    
    var queryParams: [String: String] {
        return [:]
    }
    
    
    func makeURLRequest() -> URLRequest {
        var urlString = fullURL
        var queryItems = [URLQueryItem]()
        if !queryParams.isEmpty {
            for (name, value) in queryParams {
                queryItems.append(.init(name: name, value: value))
            }
            urlString += "?" + queryItems.map({"\($0.name)=\($0.value ?? "")"}).joined(separator: "&")
        }
        let urlWithAllowedCharacters = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlWithAllowedCharacters!)!
        var urlRequest = URLRequest(url: url)
        if let body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
}

