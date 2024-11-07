//
//  Interceptor.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import Alamofire
import Foundation

enum InterceptorError: Error {
    
    case loadTokenFailed
    
}

final class Interceptor: RequestInterceptor {
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (
            Result<URLRequest, any Error>
        ) -> Void
    ) {
        // TODO: KeyChainManager 주입
        guard let token = DefaultKeyChainManager.shared.searchValue() else {
            completion(.failure(InterceptorError.loadTokenFailed))
            return
        }
        var urlRequest = urlRequest
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        completion(.success(urlRequest))
    }
    
}
