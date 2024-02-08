//
//  MatchViewController.swift
//  tinder
//
//  Created by Clovis Carmezini on 07/02/24.
//

import UIKit

class MatchViewController: UIViewController {
    
    var user: User? {
        didSet {
            if let user = user {
                labelMessage.text = "\(user.name) curtiu você também!"
                photoView.image = UIImage(named: user.photo)
            }
        }
    }
    
    let photoView: UIImageView = .imageView()
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
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)

        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar para o Tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: 16)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(photoView)
        
        photoView.fillSuperview()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        
        photoView.layer.addSublayer(gradient)
        
        labelMessage.textAlignment = .center
        
        backButton.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        messageInput.addSubview(submitButton)
        submitButton.fill(
            top: messageInput.topAnchor,
            leading: nil,
            trailing: messageInput.trailingAnchor,
            bottom: messageInput.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
        )
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, labelMessage, messageInput, backButton])
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleGoBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
                self.view.frame = UIScreen.main.bounds
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duration) {
                    self.view.frame = CGRect(
                        x: self.view.frame.origin.x,
                        y: self.view.frame.origin.y,
                        width: self.view.frame.width,
                        height: self.view.frame.height - keyboardSize.height
                    )
                    
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
