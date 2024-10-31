//
//  FinanceViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

final class FinanceViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.register(
            FinanceMainCollectionViewCell.self,
            forCellWithReuseIdentifier: FinanceMainCollectionViewCell.identifier
        )
        collectionView.register(
            FinanceEssentialCollectionViewCell.self,
            forCellWithReuseIdentifier: FinanceEssentialCollectionViewCell.identifier
        )
        collectionView.register(
            FinancePaidRankingCollectionViewCell.self,
            forCellWithReuseIdentifier: FinancePaidRankingCollectionViewCell.identifier
        )
        collectionView.register(
            FinanceFreeRankingCollectionViewCell.self,
            forCellWithReuseIdentifier: FinanceFreeRankingCollectionViewCell.identifier
        )
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 10)
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
        self.view.backgroundColor = .systemBackground
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

extension FinanceViewController: UICollectionViewDelegate {}

extension FinanceViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinanceMainCollectionViewCell.identifier, for: indexPath) as? FinanceMainCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinanceEssentialCollectionViewCell.identifier, for: indexPath) as? FinanceEssentialCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinancePaidRankingCollectionViewCell.identifier, for: indexPath) as? FinancePaidRankingCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinanceFreeRankingCollectionViewCell.identifier, for: indexPath) as? FinanceFreeRankingCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension FinanceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 200)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 3)
        }
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = scrollView.bounds.width
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
    
}

#Preview
{
    FinanceViewController()
}
