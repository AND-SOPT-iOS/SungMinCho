//
//  UITextField+SetStyle.swift
//  35-semi
//
//  Created by 조성민 on 11/4/24.
//

import UIKit

extension UITextField {
    
    func setStyle() {
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.borderWidth = 0.7
        layer.borderColor = UIColor.label.cgColor
        layer.cornerRadius = 10
        clearButtonMode = .whileEditing
        returnKeyType = .done
        
        let spacingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftView = spacingView
        rightView = spacingView
        rightViewMode = .always
        leftViewMode = .always
    }
    
}
