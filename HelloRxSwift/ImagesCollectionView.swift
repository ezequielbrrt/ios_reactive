//
//  ImagesCollectionView.swift
//  HelloRxSwift
//
//  Created by beTech CAPITAL on 28/07/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import UIKit
import Photos

class ImagesCollectionView: UICollectionViewController {
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setupViews()
        populatePhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private var images = [PHAsset]()
}

extension ImagesCollectionView {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}

extension ImagesCollectionView {
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ImagesCollectionView {
    private func setupViews() {
        self.collectionView.backgroundColor = .white
    }
}
