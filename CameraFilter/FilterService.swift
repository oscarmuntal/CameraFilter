//
//  FilterService.swift
//  CameraFilter
//
//  Created by Òscar Muntal on 13/3/23.
//

import Foundation
import UIKit
import CoreImage

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping (UIImage) -> ()) {
        guard let filter = CIFilter(name: "CICMYKHalftone"),
              let sourceImage = CIImage(image: inputImage) else { return }
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage,
              let cgImg = self.context.createCGImage(outputImage, from: outputImage.extent) else { return }
            
        let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processedImage)
    }
}
