//
//  CustomLabel.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import Foundation

import UIKit

class CustomLabel: UILabel {
    
    
    init( name fontName: String, fontSize: CGFloat, color: UIColor) {
        super.init(frame: .zero)
            
         font = UIFont(name: fontName, size: fontSize)
         numberOfLines = 0
         textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
