//
//  FinanceCollectionViewCompositionalLayoutFactory.swift
//  35-semi
//
//  Created by 조성민 on 11/1/24.
//

import UIKit

struct FinanceCollectionViewCompositionalLayoutFactory {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return FinanceCollectionViewCompositionalLayoutFactory.createSection(index: sectionIndex)
        }
    }
    
    private static func createSection(index: Int) -> NSCollectionLayoutSection {
        let itemSize = FinanceCollectionViewCompositionalLayoutFactory.createItemSize(sectionIndex: index)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = createGroup(sectionIndex: index, item: item)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging
        if let headerSize = createHeaderSize(sectionIndex: index) {
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
        }
        
        return section
    }
    
    private static func createItemSize(sectionIndex: Int) -> NSCollectionLayoutSize {
        switch sectionIndex {
        case 0:
                .init(
                    widthDimension: .absolute(UIScreen.main.bounds.width - 40),
                    heightDimension: .absolute(336)
                )
        default:
                .init(
                    widthDimension: .absolute(UIScreen.main.bounds.width - 40),
                    heightDimension: .absolute(84)
                )
        }
    }
    
    private static func createGroupSize(sectionIndex: Int) -> NSCollectionLayoutSize {
        switch sectionIndex {
        case 0:
            return NSCollectionLayoutSize(
                widthDimension: .absolute(UIScreen.main.bounds.width - 40),
                heightDimension: .absolute(336)
            )
        default:
            return NSCollectionLayoutSize(
                widthDimension: .absolute(UIScreen.main.bounds.width - 40),
                heightDimension: .absolute(84 * 3)
            )
        }
    }
    
    private static func createGroup(sectionIndex: Int, item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = createGroupSize(sectionIndex: sectionIndex)
        switch sectionIndex {
        case 0:
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
        default:
            return NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item, item, item]
            )
        }
    }
    
    private static func createHeaderSize(sectionIndex: Int) -> NSCollectionLayoutSize? {
        switch sectionIndex {
        case 1:
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(72)
            )
        case 2, 3:
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(56)
            )
        default:
            nil
        }
    }
    
}
