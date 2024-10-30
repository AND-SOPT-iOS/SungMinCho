//
//  PreviewCollectionViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/31/24.
//

import UIKit

final class PreviewCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        
        return imageView
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
        imageView.image = nil
    }
    
    override func setUI() {
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
}

#Preview
{
    let cell: PreviewCollectionViewCell = {
        let cell = PreviewCollectionViewCell()
        cell.configure(image: .cat)
        return cell
    }()
    cell
}
