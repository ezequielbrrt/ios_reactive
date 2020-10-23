//
//  ImagesCollectionView.swift
//  HelloRxSwift
//
//  Created by beTech CAPITAL on 28/07/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class ImagesCollectionView: UICollectionViewController {
    
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
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
    private let selectedPhotoSubject = PublishSubject<UIImage>()
}

extension ImagesCollectionView {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 400, height: 400), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            guard let info = info else  { return }
            
            let isDegradeImage = info["PHImageResultDegradeKey"] as! Bool
            
            if !isDegradeImage {
                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCellCollectionCell else { fatalError("ImageCellCollectionCell not found") }
        
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()

        manager.requestImage(for: asset, targetSize: CGSize(width: 400, height: 400), contentMode: .aspectFit, options: nil) { image, error in
            
            DispatchQueue.main.async {
                if let photo = image {
                    cell.imageCellView.image = photo
                }
                
            }
        }
        
        return cell
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
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension ImagesCollectionView {
    private func setupViews() {
        collectionView.register(ImageCellCollectionCell.self, forCellWithReuseIdentifier: "imageCell")
        self.collectionView.backgroundColor = .white
    }
}
