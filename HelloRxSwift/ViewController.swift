//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by beTech CAPITAL on 08/06/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: UIVariables
    private let containerImageView = UIImageView()
    private let filterButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: Private
    @objc private func addImage() {
        let nav = UINavigationController()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let photosViewController = ImagesCollectionView(collectionViewLayout: layout)
        
        photosViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.containerImageView.image = photo
                self?.filterButton.isHidden = false
            }
            
        }).disposed(by: disposeBag)
        
        nav.viewControllers = [photosViewController]
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc private func applyFilterButtonPressed() {
        guard let sourceImage = self.containerImageView.image else { return }
//        FilterService().applyFilter(to: sourceImage) { filteredImage in
//            DispatchQueue.main.async { [weak self] in
//                self?.containerImageView.image = filteredImage
//            }
//        }
        FilterService().applyFilter(to: sourceImage).subscribe(onNext: { filteredImage in
            DispatchQueue.main.async { [weak self] in
                self?.containerImageView.image = filteredImage
            }
        }).disposed(by: disposeBag)
    }
    
    private var disposeBag = DisposeBag()
}

extension ViewController {
    private func setupViews() {
        setupNavigationController()
        setupMainView()
        setupContainerImageView()
        setupButton()
    }
    
    private func setupButton() {
        filterButton.addTarget(self, action: #selector(applyFilterButtonPressed), for: .touchUpInside)
        filterButton.isHidden = true
        filterButton.setTitle("Apply filter" , for: .normal)
        filterButton.setTitleColor(.systemBlue, for: .normal)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButton)
    }
    
    private func setupContainerImageView() {
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerImageView)
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Images Filters"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
    }
    
    private func setupMainView() {
        self.view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        // ContainerImageView
        containerImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        containerImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        containerImageView.backgroundColor = .yellow
        
        // FilterButton
        filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filterButton.topAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: 20).isActive = true
    }
}

