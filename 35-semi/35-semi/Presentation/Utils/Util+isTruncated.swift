//
//  Util+isTruncated.swift
//  35-semi
//
//  Created by 조성민 on 10/24/24.
//

import UIKit

extension UILabel {
    
    var isTruncated: Bool {
        guard let text = text, let font = font else { return false }
        
        let width = frame.width
        let height = frame.height
        
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textHeight = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).height
        
        return textHeight > height
    }
    
}
