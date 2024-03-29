//
//  CombineCardView.swift
//  tinder
//
//  Created by Clovis Carmezini on 06/02/24.
//

import UIKit

class CombineCardView: UIView {
    
    var user: User? {
        didSet {
            if let user = user {
                imageView.image = UIImage(named: user.photo)
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                descriptionLabel.text = user.description
                
            }
        }
    }
        
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        
//        return imageView
//    }()
    
    let imageView: UIImageView = .imageView()
    
    let nameLabel: UILabel = .textBoldLabel(32, color: .white)
    let ageLabel: UILabel = .textLabel(28, color: .white)
    let descriptionLabel: UILabel = .textLabel(18, color: .white)
    
    let dislikeImageView: UIImageView = .iconCard(named: "card-deslike")
    let likeImageView: UIImageView = .iconCard(named: "card-like")
    
    var callback: ((User) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        nameLabel.addShadow()
        ageLabel.addShadow()
        descriptionLabel.addShadow()
        
        addSubview(imageView)
        
        addSubview(dislikeImageView)
        
        dislikeImageView.fill(
            top: topAnchor,
            leading: nil,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 0, bottom: 0, right: 20)
        )
        
        addSubview(likeImageView)
        
        likeImageView.fill(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        imageView.fillSuperview()
        
        let titleStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        titleStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [titleStackView, descriptionLabel])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fill(
            top: nil,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
        
        let viewProfileTap = UITapGestureRecognizer(target: self, action: #selector(onProfileTap))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(viewProfileTap)
    }
    
    @objc func onProfileTap() {
        if let user = self.user {
            self.callback?(user)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
