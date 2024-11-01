//
//  PreviewScreenshotView.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import UIKit

final class PreviewScreenshotView: BaseView, UICollectionViewDelegate {
    
    private lazy var previewCollectionView: UICollectionView = {
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
                PreviewCollectionViewCell.self,
                forCellWithReuseIdentifier: PreviewCollectionViewCell.cellIdentifier
            )
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "미리보기"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let deviceIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "iphone.gen3")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    private let deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [
            titleLabel,
            previewCollectionView,
            deviceIcon,
            deviceLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        previewCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        deviceIcon.snp.makeConstraints {
            $0.top.equalTo(previewCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        deviceLabel.snp.makeConstraints {
            $0.centerY.equalTo(deviceIcon.snp.centerY)
            $0.leading.equalTo(deviceIcon.snp.trailing).offset(10)
        }
    }
    
}

extension PreviewScreenshotView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UIImage.mockImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCollectionViewCell.cellIdentifier, for: indexPath) as? PreviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: UIImage.mockImages[indexPath.row])
        return cell
    }
    
}

extension PreviewScreenshotView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 220, height: 400)
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = 230.0
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left,
            y: scrollView.contentInset.top
        )
    }
    
}

#Preview
{
    PreviewScreenshotView()
}
