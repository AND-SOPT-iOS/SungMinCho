//
//  UILabel+LineSpacing.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import UIKit

extension UILabel {
    
    func setLineSpacingText(text: String, spacing: CGFloat) {
        let attributedStr = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributedStr.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedStr.length))
        self.attributedText = attributedStr
    }
    
}
