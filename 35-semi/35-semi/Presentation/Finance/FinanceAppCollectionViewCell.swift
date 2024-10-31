//
//  FinanceAppCollectionViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/31/24.
//

import UIKit

final class FinanceAppCollectionViewCell: BaseCollectionViewCell {
    
    private let appView: AppView = {
        let view = AppView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appView.resetUI()
    }
    
    override func setUI() {
        contentView.addSubview(appView)
    }
    
    override func setLayout() {
        appView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func configure(app: App) {
        appView.updateUI(app: app)
    }
    
}

#Preview
{
    let cell: FinanceAppCollectionViewCell = {
        let cell = FinanceAppCollectionViewCell()
        cell.configure(app: App.financialEssencialApps[1])
        cell.snp.makeConstraints {
            $0.width.equalTo(400)
            $0.height.equalTo(100)
        }
        return cell
    }()
    cell
}
