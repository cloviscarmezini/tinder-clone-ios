//
//  MatchUserProfileHeader.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class MatchUserProfileHeader: UICollectionReusableView {
    
    var user: User? {
        didSet {
            if let user = user {
                photoView.image = UIImage(named: user.photo)
                
            }
        }
    }
    
    var photoView: UIImageView = .imageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(photoView)
        photoView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
