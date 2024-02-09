//
//  MatchUserProfileViewController.swift
//  tinder
//
//  Created by Clovis Carmezini on 08/02/24.
//

import UIKit

class MatchUserProfileViewController: UICollectionViewController {
    
    init () {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .blue
    }
}
