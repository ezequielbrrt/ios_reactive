//
//  FilterService.swift
//  HelloRxSwift
//
//  Created by Ezequiel Barreto on 23/10/20.
//  Copyright © 2020 Ezequiel Barreto. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping((UIImage) -> ())) {
        if let filter = CIFilter(name: "CICMYKHalftone") {
            filter.setValue(0.5, forKey: kCIInputWidthKey)
            
            if let sourceImage = CIImage(image: inputImage) {
                filter.setValue(sourceImage, forKey: kCIInputImageKey)
                if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                    
                    let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale , orientation: inputImage.imageOrientation)
                    completion(processedImage)
                }
            }
        }
        
    }
}
