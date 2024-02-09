//
//  GalleryCell.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = .textBoldLabel(16)
    let siderPhotoViewController = PhotoSliderViewController()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        descriptionLabel.text = "Fotos recentes"
        
        addSubview(descriptionLabel)
        
        descriptionLabel.fill(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
        )
        
        addSubview(siderPhotoViewController.view)
        siderPhotoViewController.view.fill(
            top: descriptionLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
