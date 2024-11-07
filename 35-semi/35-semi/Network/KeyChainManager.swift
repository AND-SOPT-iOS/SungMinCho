//
//  KeyChainManager.swift
//  35-semi
//
//  Created by 조성민 on 11/7/24.
//

import Security
import Foundation

protocol KeyChainManager {
    
    func saveValue(token: String) -> OSStatus
    func changeValue(token: String) -> OSStatus
    func searchValue() -> String?
    func removeValue() -> OSStatus
    
}

final class DefaultKeyChainManager: KeyChainManager {
    
    static let shared = DefaultKeyChainManager()
    
    let serviceName: String = "35-semi"
    
    func saveValue(token: String) -> OSStatus {
        let saveData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true,
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        let status = SecItemAdd(saveData, nil)
        handleStatus(status: status)
        return status
    }
    
    func changeValue(token: String) -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName
        ] as CFDictionary
        
        let updateData: CFDictionary = [
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        return SecItemUpdate(savedData, updateData)
    }
    
    func searchValue() -> String? {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        var searchWord:CFTypeRef? = nil
        let searchResult = SecItemCopyMatching(savedData, &searchWord)
        if searchResult != errSecSuccess {
            return nil
        }
        let searchData: Data = searchWord as! Data
        return String(data: searchData, encoding: .utf8)
    }
    
    @discardableResult
    func removeValue() -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        return SecItemDelete(savedData)
    }
    
    private func handleStatus(status: OSStatus) {
        switch status {
        case errSecSuccess:
            print("token success")
        case errSecDuplicateItem:
            print("duplicated")
        default:
            print("default")
        }
    }
    
}
