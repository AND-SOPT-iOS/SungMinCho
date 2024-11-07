//
//  LoginRouter.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Alamofire
import Foundation

enum LoginRouter {
    
    case login(dto: LoginDTO)
    
}

extension LoginRouter: Router {
    
    var baseURL: String {
        switch self {
        case .login:
            Environment.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .login:
            "/login"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
                .post
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .login:
            [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var parameters: [String : Any]? {
        do {
            switch self {
            case .login(let dto):
                return try dto.asDictionary()
            }
        } catch {
            // TODO: 에러처리
            print("Parameter Dictionary 변환 실패")
            return nil
        }
    }
    
    var encoding: (any Alamofire.ParameterEncoding)? {
        switch self {
        case .login:
            JSONEncoding.default
        }
    }
    
}
