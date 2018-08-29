//
//  MVVM_HUDManager.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD


struct MVVMSpinner {
    
    var mvvmTitle:String?
    var mvvmSpinnerView:UIView?
    var mvvmSpinner:MBProgressHUD?
    
    // init will initialize all the variables
    init(title:String, view:UIView?){
        
        self.mvvmTitle = title
        self.mvvmSpinnerView = view
    }
    
    // will present the HUD/Spinner on initialized view, otherwise not
    mutating func showHud() {
        
        self.mvvmSpinner = MBProgressHUD.showAdded(to: self.mvvmSpinnerView!, animated: true)
        if mvvmTitle != nil {
            self.mvvmSpinner?.label.text = self.mvvmTitle!
        }
    }
    
    // will hide the HUD/Spinner and create all its objects nil
    mutating func removeHUD() {
        
        hideHUD()
        self.mvvmTitle = nil
        self.mvvmSpinner = nil
        self.mvvmSpinnerView = nil
    }
    
    // hiding HUD here
    func hideHUD(){
        
        if let animatorView = self.mvvmSpinnerView{
        
            MBProgressHUD.hide(for: animatorView, animated: true)
        }
        
    }
}



