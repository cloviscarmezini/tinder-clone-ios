//
//  MatchUserProfileHeader.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class MatchUserProfileHeader: UICollectionReusableView {
    var photoView: UIImageView = .imageView(named: "pessoa-1")
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(photoView)
        photoView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
