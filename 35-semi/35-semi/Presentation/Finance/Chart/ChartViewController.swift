//
//  ChartViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/26/24.
//

import UIKit

final class ChartViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.cellIdentifier)
        tableView.rowHeight = 100
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
    override func setUI() {
        view.addSubview(tableView)
    }
    
    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension ChartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tossIndex = App.financialApps.firstIndex(where: {$0.title == "토스"}) {
            if tossIndex == indexPath.row {
                let nextViewController = DetailViewController(
                    detail: AppDetail.sampleAppDetail
                )
                navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
}

extension ChartViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return App.financialApps.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChartTableViewCell.cellIdentifier,
            for: indexPath
        ) as? ChartTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(app: App.financialApps[indexPath.row])
        return cell
    }
    
}

#Preview
{
    ChartViewController()
}
