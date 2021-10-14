//
//  Extension.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import UIKit

extension UIColor {
    static func rgb(red:CGFloat, green: CGFloat, blue:CGFloat) -> UIColor{
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let  backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
}

extension UIView {
    
    func anchor(top:NSLayoutYAxisAnchor? = nil,
                left:NSLayoutXAxisAnchor? = nil,
                bottom:NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left  = left {
            
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
        
        func checkIfAutoLayOut() {
            if frame == .zero {
                translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
    }
    
    
    extension UIViewController {
        
        func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool){
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .backgroundColor
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            navigationItem.title = title
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        }
    
    }
