//
//  DownloadState.swift
//  35-semi
//
//  Created by 조성민 on 10/26/24.
//

enum DownloadState {
    
    case updatable
    case downloadable
    case downloaded
    case reDownloadable
    
    var downloadButtonTitle: String? {
        switch self {
        case .updatable: 
            return "업데이트"
        case .downloadable:
            return "받기"
        case .downloaded: 
            return "열기"
        case .reDownloadable:
            return nil
        }
    }
    
}
