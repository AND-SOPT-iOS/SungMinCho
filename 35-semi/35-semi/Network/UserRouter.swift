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
    case getHobby(id: Int)
    case putInformation
    
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
        case .getHobby(let id):
            "/user/\(id)/hobby"
        case .putInformation:
            "/user"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
                .post
        case .getMyHobby:
                .get
        case .getHobby:
                .get
        case .putInformation:
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
            case .getHobby:
                return nil
            case .putInformation:
                return nil
            }
        } catch {
            return nil
        }
    }
    
    // TODO: Register 외 수정
    var encoding: (any ParameterEncoding)? {
        switch self {
        case .register:
            JSONEncoding.default
        case .getMyHobby:
            nil
        case .getHobby:
            nil
        case .putInformation:
            JSONEncoding.default
        }
    }
    
}
