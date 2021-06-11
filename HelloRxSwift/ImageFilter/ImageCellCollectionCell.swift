//
//  ImageCellCollectionCell.swift
//  HelloRxSwift
//
//  Created by Ezequiel Barreto on 02/10/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import UIKit

class ImageCellCollectionCell: UICollectionViewCell {
    var imageCellView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCellCollectionCell {
    private func setupViews() {
        setupImageCell()
    }
    
    private func setupImageCell() {
        imageCellView.translatesAutoresizingMaskIntoConstraints =  false
        contentView.addSubview(imageCellView)
    }
    
    private func setupConstraints() {
        // imageCellView
        //imageCellView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //imageCellView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageCellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
