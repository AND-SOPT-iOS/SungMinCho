//
//  FinanceMainCellModel.swift
//  35-semi
//
//  Created by 조성민 on 10/31/24.
//

struct FinanceMainCellModel {
    
    enum FinanceMainCellType: String {
        
        case newApp = "새로운 앱"
        case newExperienceApp = "새로운 경험"
        case recommendedApp = "추천"
        
    }
    
    let type: FinanceMainCellType
    let thumbnailImageName: String
    let subtitle: String
    let app: App
    
}

extension FinanceMainCellModel {
    
    static let mockModels: [FinanceMainCellModel] = [
        FinanceMainCellModel(
            type: .newApp,
            thumbnailImageName: App.financialApps[0].imageName,
            subtitle: "\(App.financialApps[0].subtitle)",
            app: App.financialMainApps[0]
        ),
        FinanceMainCellModel(
            type: .newExperienceApp,
            thumbnailImageName: App.financialApps[1].imageName,
            subtitle: "\(App.financialApps[1].subtitle)",
            app: App.financialMainApps[1]
        ),
        FinanceMainCellModel(
            type: .recommendedApp,
            thumbnailImageName: App.financialApps[2].imageName,
            subtitle: "\(App.financialApps[2].subtitle)",
            app: App.financialMainApps[2]
        ),
        FinanceMainCellModel(
            type: .recommendedApp,
            thumbnailImageName: App.financialApps[3].imageName,
            subtitle: "\(App.financialApps[3].subtitle)",
            app: App.financialMainApps[3]
        )
    ]
    
}
