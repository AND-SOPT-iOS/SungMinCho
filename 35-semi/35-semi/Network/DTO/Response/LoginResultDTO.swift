//
//  LoginResultDTO.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

struct LoginResultDTO: Decodable {
    
    let result: LoginResponseDTO
    
}

struct LoginResponseDTO: Decodable {
    
    let token: String
    
}
