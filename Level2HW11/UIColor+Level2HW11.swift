//
//  UIColor+Level2HW11.swift
//  Level2HW11
//
//  Created by Andrey Buksha on 01.05.2021.
//

import UIKit

extension UIColor {
    
    func image(size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0) -> UIImage {
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            
            self.setFill()
            let rect = CGRect(origin: .zero, size: size)
            let clippingPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            clippingPath.addClip()
            rendererContext.fill(rect)
        }
    }
    
}
