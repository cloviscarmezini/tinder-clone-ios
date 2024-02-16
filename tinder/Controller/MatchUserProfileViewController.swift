//
//  MatchUserProfileViewController.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else {return}
                
                let contentOffSetY = collectionView.contentOffset.y
                
                attribute.frame = CGRect(
                    x: 0,
                    y: contentOffSetY,
                    width: collectionView.bounds.width,
                    height: attribute.bounds.height - contentOffSetY
                )
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class MatchUserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    let cellId = "cellId"
    let headerId = "headerId"
    let profileId = "profileId"
    let galleryId = "galleryId"
    
    var dislikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var goBackButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "icone-down"), for: .normal)
        button.backgroundColor = UIColor(red: 232/255, green: 88/255, blue: 54/255, alpha: 1)
        button.clipsToBounds = true
        
        return button
    }() 
    
    var callback: ((User?, CardAction) -> Void)?
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(MatchUserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(MatchUserDetailsCell.self, forCellWithReuseIdentifier: profileId)
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: galleryId)
        
        self.addGoBackButton()
        self.addFooter()
    }
    
    func addGoBackButton() {
        view.addSubview(goBackButton)
        goBackButton.frame = CGRect(
            x: UIScreen.main.bounds.width - 69,
            y: UIScreen.main.bounds.height * 0.7 - 24,
            width: 48,
            height: 48
        )
        goBackButton.layer.cornerRadius = 24
        goBackButton.addTarget(self, action: #selector(onGoBack), for: .touchUpInside)
    }
    
    func addFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIStackView(), dislikeButton, likeButton, UIStackView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.fill(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 34, right: 16)
        )
        
        dislikeButton.addTarget(self, action: #selector(onPressDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(onPressLike), for: .touchUpInside)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MatchUserProfileHeader
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! MatchUserDetailsCell
            
            cell.user = self.user
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        let width: CGFloat = UIScreen.main.bounds.width
        
        if indexPath.item == 0 {
            let cell = MatchUserDetailsCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.user = self.user
            cell.layoutIfNeeded()
            
            let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimatedSize.height
        }
        
        return .init(width: width, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let originY = view.bounds.height * 0.7 - 24
        self.goBackButton.frame.origin.y = originY - scrollView.contentOffset.y
    }
    
    @objc func onGoBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onPressDislike() {
        self.callback?(self.user, CardAction.dislike)
        self.onGoBack()
    }
    
    @objc func onPressLike() {
        self.callback?(self.user, CardAction.like)
        self.onGoBack()
    }
}
