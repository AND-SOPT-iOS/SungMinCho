//
//  MakeReviewView.swift
//  35-semi
//
//  Created by 조성민 on 10/23/24.
//

import UIKit

final class MakeReviewView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "탭하여 평가하기:"
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var starButtonList: [UIButton] = {
        var buttonList: [UIButton] = []
        let buttonSize: CGFloat = 16
        var imageConfig = UIImage.SymbolConfiguration(pointSize: buttonSize)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "star")
        configuration.baseBackgroundColor = .systemBackground
        configuration.preferredSymbolConfigurationForImage = imageConfig
        var configurationHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.configuration?.image = UIImage(systemName: "star.fill")
            case .normal:
                button.configuration?.image = UIImage(systemName: "star")
            default:
                break
            }
        }
        
        for i in 0..<5 {
            let button = UIButton(configuration: configuration)
            button.configurationUpdateHandler = configurationHandler
            
            button.tag = i
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.width.height.equalTo(buttonSize)
            }
            buttonList.append(button)
        }
        return buttonList
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        
        return stackView
    }()
    
    private lazy var reviewCollectionView: UICollectionView = {
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
            ReviewCollectionViewCell.self,
            forCellWithReuseIdentifier: ReviewCollectionViewCell.cellIdentifier
        )
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let writeReviewButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "리뷰 작성"
        configuration.image = UIImage(systemName: "square.and.pencil")
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let applicationSupportButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "앱 지원"
        configuration.image = UIImage(systemName: "questionmark.circle")
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let bestReviews: [Review]
    
    init(bestReviews: [Review]) {
        self.bestReviews = bestReviews
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        starButtonList.enumerated().forEach { (i, button) in
            button.isSelected = i <= index
        }
    }
    
    override func setUI() {
        starButtonList.forEach {
            starStackView.addArrangedSubview($0)
        }
        
        [
            headerLabel,
            starStackView,
            reviewCollectionView,
            writeReviewButton,
            applicationSupportButton
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        starStackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(starStackView)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        writeReviewButton.snp.makeConstraints {
            $0.top.equalTo(reviewCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        applicationSupportButton.snp.makeConstraints {
            $0.top.equalTo(reviewCollectionView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
}

extension MakeReviewView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        Review.sampleReviews.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(review: Review.sampleReviews[indexPath.row])
        
        return cell
    }
    
}

extension MakeReviewView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 40, height: 250)
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = scrollView.bounds.width - 30
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left,
            y: scrollView.contentInset.top
        )
    }
    
}

#Preview
{
    MakeReviewView(
        bestReviews: Review.sampleReviews
    )
}
