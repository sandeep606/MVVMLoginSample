//
//  MVVMLabel.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import UIKit

class MVVMLabel: UILabel {

    var value:Int = 0
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    @IBInspectable var fontName:String?
    
    var _hexaBGColor:String?
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    // getting a new intrinsic content size.
    override public var intrinsicContentSize: CGSize {
        get {

            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }
    }
    
    // Creating a inspectable Hexa color property
    @IBInspectable var hexaBGColor:String{
        
        set{
            _hexaBGColor = newValue
        }
        get{
            return _hexaBGColor!
        }
    }
    
    //It will be called automatically when contraint based layout changes.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if fontName != nil && fontName!.characters.count>0 {
            
            self.font = UIFont(name: fontName!, size: (self.font?.pointSize)!)
        }
        
        if let hexaColor = _hexaBGColor {
            
            self.backgroundColor = UIColor.colorWithHexString(hex: hexaColor)
        }
    }

}
