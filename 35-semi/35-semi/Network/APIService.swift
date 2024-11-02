//
//  APIService.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Alamofire
import Foundation

final class APIService {
    
    func register(
        username: String,
        password: String,
        hobby: String,
        completion: @escaping (Result<Bool, NetworkError>
        ) -> Void) {
        AF.request(
            UserRouter.register(
                dto: RegisterDTO(
                    username: username,
                    password: password,
                    hobby: hobby
                )
            )
        )
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                dump(error)
                let error = handleStatusCode(statusCode: statusCode, responseData: data)
                completion(.failure(error))
            }
        }
    }
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>
        ) -> Void
    ) {
        AF.request(
            LoginRouter.login(
                dto: LoginDTO(
                    username: username,
                    password: password
                )
            )
        )
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.unknownError))
                return
            }
            guard let token = convertToDTO(data: data, type: LoginResultDTO.self) else {
                completion(.failure(.unknownError))
                return
            }
            switch response.result {
            case .success:
                completion(.success(token.result.token))
            case .failure(let error):
                dump(error)
                let error = handleStatusCode(statusCode: statusCode, responseData: data)
                completion(.failure(error))
            }
        }
    }
    
}

extension APIService {
    
    func convertToDTO<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            let dto = try JSONDecoder().decode(T.self, from: data)
            return dto
        } catch {
            return nil
        }
    }
    
}

extension APIService {
    
    func handleStatusCode(statusCode: Int,responseData: Data) -> NetworkError {
        let errorCode = decodeError(responseData: responseData)
        switch (statusCode, errorCode) {
        case (400, "00"):
          return .invalidRequest
        case (400, "01"):
          return .expressionError
        case (404, ""):
          return .invalidURL
        case (409, "00"):
          return .duplicateError
        case (500, ""):
          return .serverError
        default:
          return .unknownError
        }
    }
    
    func decodeError(responseData: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(
            ErrorResponseDTO.self,
            from: responseData
        ) else { return "" }
        return errorResponse.code
    }
    
}
