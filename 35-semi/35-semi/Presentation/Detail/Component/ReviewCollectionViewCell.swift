//
//  ReviewCollectionViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/29/24.
//

import UIKit

final class ReviewCollectionViewCell: BaseCollectionViewCell {
    
    private let reviewView: ReviewView = {
        let view = ReviewView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }
    
    init() {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reviewView.resetUI()
    }
    
    override func setUI() {
        contentView.addSubview(reviewView)
    }
    
    override func setLayout() {
        reviewView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
        }
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.bottom.equalTo(reviewView.snp.bottom)
        }
    }
    
    func configure(review: Review) {
        reviewView.updateUI(review: review)
    }
    
}

#Preview
{
    let cell: ReviewCollectionViewCell = {
        let cell = ReviewCollectionViewCell()
        cell.configure(review: Review.sampleReviews.first!)
        return cell
    }()
    cell
}
