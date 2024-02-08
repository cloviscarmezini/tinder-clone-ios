//
//  UILabel.swift
//  tinder
//
//  Created by Clovis Carmezini on 06/02/24.
//

import UIKit

extension UILabel {
    static func textLabel (_ size: CGFloat, color: UIColor = .black, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = color
        label.numberOfLines = numberOfLines
        return label
    }
    
    static func textBoldLabel (_ size: CGFloat, color: UIColor = .black, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = color
        label.numberOfLines = numberOfLines
        return label
    }
    
    func addShadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
}
