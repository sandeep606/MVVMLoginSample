//
//  LoginViewController.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: MVVMBaseViewController, LoginViewModelDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var textFieldUserEmail:MVVMTextField!
    @IBOutlet weak var textFieldUserPassword:MVVMTextField!
    
    @IBOutlet weak var lblUserPasswordError:MVVMLabel!
    @IBOutlet weak var lblUserEmailError:MVVMLabel!
    
    @IBOutlet weak var btnHelp:UIButton!
    
    let helpSegueIdentifier = "HelpPopOverSegue"
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    // initializing view with loging model
    // setting layers to help button.
    func initializeView() -> Void {
        
        loginViewModel.loginViewModelDelegate = self
        btnHelp.setBorderLayer(withCornerRadius: btnHelp.frame.size.width/2, borderWidth: 0.0, borderColor: UIColor.clear)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Methods
    // btnLogin will validate the desired/required format.
    // if validation goes true then it will call loginViewModel to verify user.
    @IBAction func btnLoginNowClicked(button:UIButton?){
        
        self.view.endEditing(true)
        if loginViewModel.areValidFormats(){
            
            //use only processed response here...
            self.addSpinner(withTitle: pleaseWait)
            loginViewModel.startVerifyingUser(completion: { (responseObject, error, status) in
                self.removeSpinner()
                print("One can observe RESPONSE here")
            })
            // request to server with the credentials
        }
    }
    
    // Will be called when help is clicked.
    @IBAction func btnHelpClicked(button:UIButton?){
        
        self.view.endEditing(true)
        self.performSegue(withIdentifier: helpSegueIdentifier, sender: button)
    }
    
    // function will test the error text for respective field
    func setErrorText(emailMsg:String?, passwordMsg:String?) -> Void {
        
        lblUserEmailError.text = emailMsg
        lblUserPasswordError.text = passwordMsg
        textFieldUserEmail.errorOccurred = false
        textFieldUserPassword.errorOccurred = false
        
        if emailMsg != nil && emailMsg!.characters.count > 1{
            textFieldUserEmail.errorOccurred = true
        }
        if passwordMsg != nil && passwordMsg!.characters.count > 1{
            textFieldUserPassword.errorOccurred = true
        }
    }
    // will be called when remember me button is clicked
    @IBAction func btnRememberMeClicked(button:UIButton){
        
        button.isSelected = !button.isSelected
        loginViewModel.shouldRememberCredentials = button.isSelected
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
        if textField.tag == 1 && textFieldUserEmail.nowEdited && loginViewModel.isValidEmail(){
            
            self.setErrorText(emailMsg:nil, passwordMsg:lblUserPasswordError.text)
        }
        let mvvmTextField = textField as? MVVMTextField
        mvvmTextField?.nowEdited = true
    }
    
    // delegate method will called with textField editing begins.
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason){
        
        switch textField.tag {
        case 0:
            loginViewModel.userEmail = textField.text!
            
        default:
            loginViewModel.userPassword = textField.text!
        }
    }
    
    
    // MARK: - LoginViewModelDelegate
    
    // function will produce an alert with invalid credentials
    func errorInCredentials(fieldType:FieldType, message:String) {
        
        switch fieldType {
        case .FT_Email:
            self.setErrorText(emailMsg:message, passwordMsg:lblUserPasswordError.text)
        // considering default case for .ET_Password
        default:
            self.setErrorText(emailMsg:lblUserEmailError.text, passwordMsg:message)
        }
    }
    
    // function will produce an alert with invalid credentials
    func validEntryFor(fieldType: FieldType) {
        
        switch fieldType {
        case .FT_Email:
            self.setErrorText(emailMsg:nil, passwordMsg:lblUserPasswordError.text)
        // considering default case for .ET_Password
        default:
            self.setErrorText(emailMsg:lblUserEmailError.text, passwordMsg:nil)
        }
    }
    
    //preparing segues accordingly
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == helpSegueIdentifier {
                let controller = segue.destination
                controller.popoverPresentationController!.delegate = self
                controller.modalPresentationStyle = .popover
                controller.preferredContentSize = CGSize(width: 250, height: 200)
                controller.popoverPresentationController?.permittedArrowDirections = .any
            
        }
    }
    
    // forcing the view to present as popover in iPhone.
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle{
        return .none
    }
    
}
