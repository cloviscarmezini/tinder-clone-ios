//
//  SlideItemCell.swift
//  tinder
//
//  Created by Clovis Carmezini on 09/02/24.
//

import UIKit

class SlideItemCell:UICollectionViewCell  {
    let photoView: UIImageView = .imageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(photoView)
        photoView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
