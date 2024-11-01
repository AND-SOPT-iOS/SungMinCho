//
//  FinanceViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

final class FinanceViewController: BaseViewController, UICollectionViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: FinanceCollectionViewCompositionalLayoutFactory.createLayout()
        )
        collectionView.register(
            FinanceMainCollectionViewCell.self,
            forCellWithReuseIdentifier: FinanceMainCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            FinanceAppCollectionViewCell.self,
            forCellWithReuseIdentifier: FinanceAppCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            FinanceAppCollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FinanceAppCollectionViewHeaderView.headerIdentifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
    override func setStyle() {
        view.backgroundColor = .systemBackground
        title = "금융"
    }
    
    override func setUI() {
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension FinanceViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return FinanceMainCellModel.mockModels.count
        default:
            return App.financialEssencialApps.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinanceMainCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? FinanceMainCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(model: FinanceMainCellModel.mockModels[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinanceAppCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(app: App.financialEssencialApps[indexPath.row])
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinanceAppCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(app: App.financialPaidApps[indexPath.row])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinanceAppCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(app: App.financialFreeApps[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FinanceAppCollectionViewHeaderView.headerIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configure(title: "필수 금융 앱", subtitle: "App Store 에디터가 직접 골랐습니다", viewType: .essential)
            headerView.delegate = self
            return headerView
        case 2:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FinanceAppCollectionViewHeaderView.headerIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configure(title: "유료 순위", viewType: .paid)
            headerView.delegate = self
            return headerView
        case 3:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FinanceAppCollectionViewHeaderView.headerIdentifier,
                for: indexPath
            ) as? FinanceAppCollectionViewHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configure(title: "무료 순위", viewType: .free)
            headerView.delegate = self
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension FinanceViewController: FinanceAppCollectionViewHeaderViewDelegate {
    
    func showAllButtonTapped() {
        let nextViewController = ChartViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

#Preview
{
    FinanceViewController()
}
