//
//  ImagesCollectionView.swift
//  HelloRxSwift
//
//  Created by beTech CAPITAL on 28/07/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import UIKit

class ImagesCollectionView: UICollectionViewController {
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagesCollectionView {
    private func setupViews() {
        self.collectionView.backgroundColor = .white
    }
}
