//
//  Encodable+Dictionary.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            throw NetworkError.decodingError // TODO: 에러처리
        }
        return dictionary
    }
    
}
