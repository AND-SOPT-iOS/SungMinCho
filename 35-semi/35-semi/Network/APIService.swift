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
        completion: @escaping (Result<Void, RegisterError>
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
        .validate()
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
                completion(.success(()))
            case .failure:
                let error = handleRegisterStatusCode(
                    statusCode: statusCode,
                    responseData: data
                )
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
            keyChainManager.removeValue()
            switch response.result {
            case .success:
                guard let token = convertToDTO(
                    data: data,
                    type: LoginResultDTO.self
                ) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                let status = keyChainManager.saveValue(token: token.result.token)
                if status != errSecSuccess {
                    completion(.failure(.tokenSaveFailed))
                }
                completion(.success(()))
            case .failure:
                let error = handleLoginStatusCode(
                    statusCode: statusCode,
                    responseData: data
                )
                completion(.failure(error))
            }
        }
    }
    
    func fetchMyHobby(
        completion: @escaping (Result<String, MyHobbyError>
        ) -> Void
    ) {
        AF.request(
            UserRouter.getMyHobby,
            interceptor: Interceptor(keyChainManager: keyChainManager)
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
            switch response.result {
            case .success:
                guard let token = convertToDTO(
                    data: data,
                    type: MyHobbyResultDTO.self
                ) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                completion(.success(token.result.hobby))
            case .failure:
                let error = handleMyHobbyStatusCode(
                    statusCode: statusCode,
                    responseData: data
                )
                completion(.failure(error))
            }
        }
    }
    
}

extension APIService {
    
    private func convertToDTO<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            let dto = try JSONDecoder().decode(T.self, from: data)
            return dto
        } catch {
            return nil
        }
    }
    
}

extension APIService {
    
    private func handleRegisterStatusCode(
        statusCode: Int,
        responseData: Data
    ) -> RegisterError {
        let errorCode = decodeError(responseData: responseData)
        dump(responseData)
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
    
    private func handleLoginStatusCode(
        statusCode: Int,
        responseData: Data
    ) -> LoginError {
        let errorCode = decodeError(responseData: responseData)
        dump(responseData)
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
    
    private func handleMyHobbyStatusCode(
        statusCode: Int,
        responseData: Data
    ) -> MyHobbyError {
        let errorCode = decodeError(responseData: responseData)
        dump(responseData)
        switch (statusCode, errorCode) {
        case (401, "00"):
            return .tokenMissing
        case (403, "00"):
            return .tokenInvalid
        case (404, "00"):
            return .wrongPath
        default:
            return .unknown
        }
    }
    
    private func decodeError(responseData: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(
            ErrorResponseDTO.self,
            from: responseData
        ) else { return "" }
        return errorResponse.code
    }
    
}
