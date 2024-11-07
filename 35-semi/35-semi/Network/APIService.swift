//
//  APIService.swift
//  35-semi
//
//  Created by 조성민 on 11/2/24.
//

import Alamofire
import Foundation

final class APIService {
    
    private let keyChainManager: KeyChainManager
    
    init(keyChainManager: KeyChainManager) {
        self.keyChainManager = keyChainManager
    }
    
    func register(
        username: String,
        password: String,
        hobby: String,
        completion: @escaping (Result<Bool, RegisterError>
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
                completion(.failure(.bodyInvalid))
                return
            }
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                dump(error)
                let error = handleRegisterStatusCode(statusCode: statusCode, responseData: data)
                completion(.failure(error))
            }
        }
    }
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<Void, LoginError>
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
        .validate()
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.bodyInvalid))
                return
            }
            dump(response)
            switch response.result {
            case .success:
                guard let token = convertToDTO(data: data, type: LoginResultDTO.self) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                let status = keyChainManager.saveValue(token: token.result.token)
                if status != errSecSuccess {
                    completion(.failure(.tokenSaveFailed))
                }
                completion(.success(()))
            case .failure(let error):
                dump(error)
                let error = handleLoginStatusCode(statusCode: statusCode, responseData: data)
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
    
    func handleRegisterStatusCode(statusCode: Int, responseData: Data) -> RegisterError {
        let errorCode = decodeError(responseData: responseData)
        switch (statusCode, errorCode) {
        case (400, "00"):
            return .bodyInvalid
        case (400, "01"):
            return .lengthInvalid
        case (404, ""):
            return .wrongPath
        case (409, "00"):
            return .duplicatedUserName
        default:
            return .unknown
        }
    }
    
    func handleLoginStatusCode(statusCode: Int, responseData: Data) -> LoginError {
        let errorCode = decodeError(responseData: responseData)
        switch (statusCode, errorCode) {
        case (400, "01"):
            return .bodyInvalid
        case (400, "02"):
            return .loginInvalid
        case (403, "01"):
            return .passwordInvalid
        case (404, "00"):
            return .wrongPath
        default:
            return .unknown
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
