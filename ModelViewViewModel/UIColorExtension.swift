//
//  UIColorExtension.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation
import UIKit

//Extension of UIColor

extension UIColor {
    
    // Converting RGB to exact color
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    // converting hexstring to it's exact color
    convenience init(hexString:String) {

        let hexString:NSString =  hexString.trimmingCharacters(in: CharacterSet.whitespaces) as NSString
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    // actual coversion of hexastring to UIColor
    static func colorWithHexString (hex:String, alpha:CGFloat=1) -> UIColor {
        // removing all spaces and new line character set and then coverting the string to UPPERCASE. example AABBCC
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
        
        // checking if hex string contains #, If yes then consider the screen from index 1 otherwise 0
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        // checking length of hexacolor, it should always be 6 else default gray color will be returned.
        if (cString.characters.count != 6) {
            return UIColor.black
        }
        
        let rString = (cString as NSString).substring(to: 2) // first two are red
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2) // next two are green
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2) // rest are blue
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}
