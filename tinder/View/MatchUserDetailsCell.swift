//
//  MatchUserDetailsCell.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class MatchUserDetailsCell: UICollectionViewCell {
    let nameLabel: UILabel = .textBoldLabel(32)
    let ageLabel: UILabel = .textLabel(28)
    let descriptionLabel: UILabel = .textLabel(18, numberOfLines: 2)
    
    var user: User? {
        didSet {
            if let user = user {
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                descriptionLabel.text = user.description
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        nameStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, descriptionLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20
        ))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
