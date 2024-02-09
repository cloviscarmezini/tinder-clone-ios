//
//  CombineViewController.swift
//  tinder
//
//  Created by Clovis Carmezini on 06/02/24.
//

import UIKit

enum CardAction {
    case dislike
    case like
    case superlike
}

class CombineViewController: UIViewController {
    
    var profileButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton: UIButton = .iconMenu(named: "icone-chat")
    var logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    var dislikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superButton: UIButton = .iconFooter(named: "icone-superlike")
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor.systemGroupedBackground
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        self.fetchUsers()
        
        self.addHeader()
        self.addFooter()
    }
    
    func fetchUsers() {
        UserService.shared.fetchUsers { (users, error) in
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                    self.makeCards()
                }
            }
        }
    }
}

extension CombineViewController {
    func addHeader() {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [UIView(),chatButton, logoButton, profileButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.fill(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: top, left: 16, bottom: 0, right: 16)
        )
    }
    
    func addFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView(),dislikeButton, superButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 32, right: 16)
        )
        
        superButton.addTarget(self, action: #selector(onPressSuperlike), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(onPressDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(onPressLike), for: .touchUpInside)
    }
}

extension CombineViewController {
    func makeCards() {
        for user in users {
            let card = CombineCardView()
            card.user = user
            card.tag = user.id
            
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            
            card.center = view.center
            
            card.callback = {(user) in
                self.viewProfile(user: user)
            }
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(cardHandler))
            
            card.addGestureRecognizer(gesture)
            
            view.insertSubview(card, at: 1)
        }
    }
    
    func removeCard(card: UIView) {
        card.removeFromSuperview()
        self.users = self.users.filter({(user) -> Bool in return user.id != card.tag})
    }
    
    func verifyMatch(user: User) {
        if user.match {
            print("match")
            
            let matchViewController = MatchViewController()
            matchViewController.modalPresentationStyle = .fullScreen
            matchViewController.user = user
            
            self.present(matchViewController, animated: true, completion: nil)
        }
    }
    
    func viewProfile(user: User) {
        let userProfileViewController = UIViewController()
        userProfileViewController.view.backgroundColor = .red
        userProfileViewController.modalPresentationStyle = .fullScreen
        
        self.present(userProfileViewController, animated: true, completion: nil)
    }
}

extension CombineViewController {
    @objc func cardHandler (gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            if(point.x > 0) {
                card.likeImageView.alpha = rotationAngle * 5
                card.dislikeImageView.alpha = 0
            } else {
                card.dislikeImageView.alpha = rotationAngle * 5 * -1
                card.likeImageView.alpha = 0
            }
            
            
            if gesture.state == .ended {
                
                if card.center.x > self.view.bounds.width + 50 {
                    self.animatedCard(rotationAngle: rotationAngle, action: CardAction.like)
                    return
                }
                
                if card.center.x < -50 {
                    self.animatedCard(rotationAngle: rotationAngle, action: CardAction.dislike)
                    return
                }
                
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                    
                    card.likeImageView.alpha = 0.0
                    card.dislikeImageView.alpha = 0.0
                }
            }
        }
    }
    
    @objc func onPressDislike() {
        self.animatedCard(rotationAngle: -0.4, action: CardAction.dislike)
    }
    
    
    @objc func onPressLike() {
        self.animatedCard(rotationAngle: 0.4, action: CardAction.like)
    }
    
    @objc func onPressSuperlike() {
        self.animatedCard(rotationAngle: 0, action: CardAction.superlike)
    }
    
    func animatedCard(rotationAngle: CGFloat, action: CardAction) {
        if let user = self.users.first {
            for view in self.view.subviews {
                if view.tag == user.id {
                    if let card = view as? CombineCardView {
                        let center: CGPoint
                        
                        switch action {
                            case CardAction.dislike:
                                center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            case CardAction.like:
                                center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            case CardAction.superlike:
                                center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                        }
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            card.likeImageView.alpha = action == CardAction.like ? 1 : 0
                            card.dislikeImageView.alpha = action == CardAction.dislike ? 1 : 0
                        }) { (_) in
                            if action == CardAction.like {
                                self.verifyMatch(user: user)
                            }
                            self.removeCard(card: card)
                        }
                    }
                }
            }
        }
    }
}
