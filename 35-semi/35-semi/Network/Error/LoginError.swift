//
//  LoginError.swift
//  35-semi
//
//  Created by 조성민 on 11/7/24.
//

enum LoginError: Error {
    
    case bodyInvalid
    case loginInvalid
    case passwordInvalid
    case decodingFailed
    case tokenSaveFailed
    case wrongPath
    case unknown
    
    var errorMessage: String {
        switch self {
        case .bodyInvalid:
            "request body가 유효하지 못한 경우"
        case .loginInvalid:
            "로그인 요청 정보가 잘못된 경우 (올바르지 못한 password)"
        case .passwordInvalid:
            "password가 틀린 경우"
        case .decodingFailed:
            "decoding에 실패한 경우"
        case .tokenSaveFailed:
            "토큰 저장에 실패한 경우"
        case .wrongPath:
            "유효하지 못한 path로 요청이 들어온 경우 (method, path 확인 필요)"
        case .unknown:
            "알 수 없는 오류"
        }
    }
    
}
