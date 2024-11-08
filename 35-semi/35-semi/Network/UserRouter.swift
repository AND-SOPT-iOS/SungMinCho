//
//  UserRouter.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Alamofire
import Foundation

enum UserRouter {
    
    case register(dto: RegisterDTO)
    case getMyHobby
    case putMyHobby(dto: PutMyHobbyDTO)
    
}

extension UserRouter: Router {
    
    var baseURL: String {
        Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .register:
            "/user"
        case .getMyHobby:
            "/user/my-hobby"
        case .putMyHobby:
            "/user"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
                .post
        case .getMyHobby:
                .get
        case .putMyHobby:
                .put
        }
    }
    
    // TODO: Register 외 수정
    var headers: [String : String] {
        switch self {
        default:
            [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var parameters: [String : Any]? {
        do {
            switch self {
            case .register(let dto):
                return try dto.asDictionary()
            case .getMyHobby:
                return [:]
            case .putMyHobby(let dto):
                return try dto.asDictionary()
            }
        } catch {
            return nil
        }
    }
    
    var encoding: (any ParameterEncoding)? {
        switch self {
        case .register:
            JSONEncoding.default
        case .getMyHobby:
            nil
        case .putMyHobby:
            JSONEncoding.default
        }
    }
    
}
