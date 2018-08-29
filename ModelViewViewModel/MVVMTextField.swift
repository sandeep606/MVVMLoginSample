//
//  MVVMTextField.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation
import UIKit

class MVVMTextField: UITextField {
    
    var _leftSpacing:CGFloat = 0.0
    var answerValue = ""
    var nowEdited = false
    
    // for left spacing
    @IBInspectable var leftSpacing: CGFloat {
        get {
            return _leftSpacing
        }
        set {
            _leftSpacing = newValue
        }
    }
    
    // if error occurred then textField properties will changed accordingly.
    @IBInspectable var errorOccurred:Bool{
        
        get {
            return self.errorOccurred
        }
        set{
            self.setBorderLayer(borderWidth: 1.0, borderColor: newValue == true ? UIColor.red : UIColor.black)
        }
    }
    
 
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    // overriden methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: self.leftSpacing, y: bounds.origin.y, width: bounds.size.width-self.leftSpacing, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds);
    }
    
    
}
