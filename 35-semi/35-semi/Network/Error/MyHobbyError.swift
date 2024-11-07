//
//  MyHobbyError.swift
//  35-semi
//
//  Created by 조성민 on 11/7/24.
//

enum MyHobbyError: Error {
    
    case tokenMissing
    case tokenInvalid
    case wrongPath
    case unknown
    
    var errorMessage: String {
        switch self {
        case .tokenMissing:
            "header에 token 이 없거는 경우"
        case .tokenInvalid:
            "token이 유효하지 않은 경우"
        case .wrongPath:
            "유효하지 못한 path로 요청이 들어온 경우 (method, path 확인 필요)"
        case .unknown:
            "알 수 없는 오류"
        }
    }
    
}
