//
//  MVVMViewExtensjion.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    // setting border layer, corder radius, borderwidth and border color of a view.
    // If no value is provided it will use default values
    func setBorderLayer(withCornerRadius cornerRadius:CGFloat=0.0, borderWidth:CGFloat=0.0, hexaColor:String?) {
        
        self.setBorderLayer(withCornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: hexaColor != nil ? UIColor.colorWithHexString(hex: hexaColor!):UIColor.clear)
    }
    
    // can be called by above function to set various border params.
    func setBorderLayer(withCornerRadius cornerRadius:CGFloat=0.0, borderWidth:CGFloat=0.0, borderColor:UIColor? = UIColor.black) {
        
        let layer:CALayer = self.layer
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
