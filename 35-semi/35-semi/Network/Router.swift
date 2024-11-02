//
//  Router.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Alamofire
import Foundation

protocol Router: URLRequestConvertible {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding? { get }
    
}

extension Router {
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        if let encoding = encoding {
            if let parameters = parameters {
                return try encoding.encode(request, with: parameters)
            } else {
                throw NetworkError.invalidRequest//TODO: 수정
            }
        }
        
        return request
    }
        
    
}
