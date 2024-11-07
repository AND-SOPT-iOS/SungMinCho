//
//  RegisterError.swift
//  35-semi
//
//  Created by 조성민 on 11/7/24.
//

enum RegisterError: Error {
    
    case bodyInvalid
    case lengthInvalid
    case wrongPath
    case duplicatedUserName
    case unknown
    
    var errorMessage: String {
        switch self {
        case .bodyInvalid:
            "request body가 유효하지 못한 경우"
        case .lengthInvalid:
            "userName 혹은 password 혹은 hobby 가 8자를 넘기는 경우"
        case .wrongPath:
            "유효하지 못한 path로 요청이 들어온 경우 (method, path 확인 필요)"
        case .duplicatedUserName:
            "userName 이 중복되는 경우"
        case .unknown:
            "알 수 없는 오류"
        }
    }
    
}
