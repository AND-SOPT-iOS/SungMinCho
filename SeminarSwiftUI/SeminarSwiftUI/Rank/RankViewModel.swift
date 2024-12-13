//
//  RankViewModel.swift
//  SeminarSwiftUI
//
//  Created by 조성민 on 12/13/24.
//

import SwiftUI

final class RankViewModel: ObservableObject {
    
    @Published var rankRowModels = RankRowModel.mockDataArray
    @Published var isPresentDetailView = false
    
}
