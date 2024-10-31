//
//  ChartTableViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/26/24.
//

import UIKit

final class ChartTableViewCell: UITableViewCell {
    
    private let appView: AppView = {
        let view = AppView()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appView.resetUI()
    }
    
    private func setUI() {
        contentView.addSubview(appView)
    }
    
    private func setStyle() {
        selectionStyle = .none
    }
    
    private func setLayout() {
        appView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(app: App) {
        appView.updateUI(app: app)
    }
    
}

#Preview
{
    let cell: ChartTableViewCell = {
        let cell = ChartTableViewCell(style: .default, reuseIdentifier: nil)
        cell.snp.makeConstraints {
            $0.width.equalTo(400)
            $0.height.equalTo(92)
        }
        cell.configure(app: App.financialApps[1])
        return cell
    }()
    cell
}
