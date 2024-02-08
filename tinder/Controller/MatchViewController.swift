//
//  MatchViewController.swift
//  tinder
//
//  Created by Clovis Carmezini on 07/02/24.
//

import UIKit

class MatchViewController: UIViewController {
    let photoView: UIImageView = .imageView(named: "pessoa-1")
    let likeImageView: UIImageView = .imageView(named: "icone-like")
    let labelMessage: UILabel = .textBoldLabel(18, color: .white, numberOfLines: 1)
    
    let messageInput: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoView)
        
        photoView.fillSuperview()
        
        labelMessage.text = "Ana curtiu você também!"
        labelMessage.textAlignment = .center
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, labelMessage, messageInput])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32)
        )
    }
}
