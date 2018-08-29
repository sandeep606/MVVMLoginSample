//
//  MVVMBaseViewController.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import UIKit
import MBProgressHUD

class MVVMBaseViewController: UIViewController {

    var spinner : MVVMSpinner?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Spinner Methods
    // function will remove the HUD first, if any
    // function will initialize the MVVMSpinner struct and show it accordingly
    func addSpinner(withTitle spinnerTitle:String = "") -> Void {
        
        self.removeSpinner()
        self.spinner = MVVMSpinner(title: spinnerTitle, view: self.view)
        self.spinner?.showHud()
    }
    
    // removing spinner here.
    func removeSpinner() -> Void {
        
        self.spinner?.removeHUD()
        self.spinner = nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
