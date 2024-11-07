//
//  MyHobbyResultDTO.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

struct MyHobbyResultDTO: Decodable {
    
    let result: MyHobbyResponseDTO
    
}

struct MyHobbyResponseDTO: Decodable {
    
    let hobby: String
    
}
