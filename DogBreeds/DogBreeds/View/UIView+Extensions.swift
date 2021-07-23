//
//  UIView+Extensions.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/07/21.
//

import Foundation
import UIKit

extension UIView {
    func loadXib(targetView contentView: inout UIView?, xibName xib: String) {
        // load xib into content view
        contentView = Bundle.main.loadNibNamed(xib, owner: self, options: nil)![0] as? UIView
        self.addSubview(contentView!)
        contentView!.frame = self.bounds
        contentView!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path: UIBezierPath = UIBezierPath(roundedRect: bounds,
                                                  byRoundingCorners: corners,
                                                  cornerRadii: CGSize(width: radius, height: radius))
            let mask: CAShapeLayer = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
