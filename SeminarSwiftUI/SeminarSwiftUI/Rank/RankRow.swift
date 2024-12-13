//
//  RankRow.swift
//  SeminarSwiftUI
//
//  Created by 조성민 on 12/10/24.
//

import SwiftUI

struct RankRow: View {
    
    @State var rankRowModel: RankRowModel
    @Binding var isPresentDetailView: Bool
    
    var body: some View {
        HStack {
            Image("\(rankRowModel.imageName)")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack(alignment: .top) {
                Text("\(rankRowModel.rank)")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 6)
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(rankRowModel.title)")
                        .font(.system(size: 16))
                    Text("\(rankRowModel.subtitle)")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                }
            }
            
            Spacer()
            
            Button {
                if rankRowModel.title == "토스" {
                    isPresentDetailView.toggle()
                }
            } label: {
                if rankRowModel.downloadState == .redownload {
                    Image(systemName: "icloud.and.arrow.down")
                        .resizable()
                        .foregroundStyle(Color.blue)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 26)
                } else {
                    Text(rankRowModel.downloadState.label())
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 70, height: 32)
                        .background {
                            Capsule()
                                .fill(Color(uiColor: UIColor.systemGray5))
                        }
                }
            }
        }
    }
    
}
