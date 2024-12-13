//
//  RankView.swift
//  SeminarSwiftUI
//
//  Created by 조성민 on 12/10/24.
//

import SwiftUI

struct RankView: View {
    
    @ObservedObject var viewModel = RankViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.rankRowModels) {
                RankRow(
                    rankRowModel: $0,
                    isPresentDetailView: $viewModel.isPresentDetailView
                )
            }
            .listStyle(.plain)
            .ignoresSafeArea()
            .navigationDestination(isPresented: $viewModel.isPresentDetailView) {
                DetailView()
            }
        }
        .navigationTitle("인기 차트")
        .navigationBarTitleDisplayMode(.large)
    }
    
}

#Preview {
    RankView()
}
