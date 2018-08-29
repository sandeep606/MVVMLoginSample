//
//  LoginViewModel.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation

open class LoginViewModel {
    
    open var userEmail:String = ""
    open var userPassword:String = ""
    open var shouldRememberCredentials = false
    
    weak var loginViewModelDelegate : LoginViewModelDelegate?
    
    // validating email & password; using their text counts for now.
    func areValidFormats() -> Bool{
        
        if isValidEmail() && isValidPassword(){
            return true
        }
        return false
    }
    
    // USER will be verified here.
    // Function will call LoginUser Model for user verification.
    func startVerifyingUser(completion:@escaping (_ responseObject:AnyObject?, _ error:NSError?, _ success:Bool)->()) -> Void {
        
        let loginUser:LoginUser? = LoginUser(withEmail: userEmail, password: userPassword)
        loginUser?.requestToServer(completion: {[weak self] (response, error, status) in
            
            guard let weakSelf = self else{
                return
            }
            weakSelf.checkAndSaveCredentials() // to be done only in success case.
            completion(response, error, status)
        })
    }
    
    // validating email here.
    func isValidEmail() -> Bool {
        
        if MVVMUtils.isValidEmail(email: self.userEmail){
            loginViewModelDelegate?.validEntryFor(fieldType: .FT_Email)
            return true
        }
        loginViewModelDelegate?.errorInCredentials(fieldType: .FT_Email, message: invalidEmail) // throwing email error
        return false
    }
    
    // validating password
    func isValidPassword() -> Bool {
        
        if MVVMUtils.isValidPassword(password: self.userPassword){
            loginViewModelDelegate?.validEntryFor(fieldType: .FT_Password)
            return true
        }
        loginViewModelDelegate?.errorInCredentials(fieldType: .FT_Password, message: invalidPassword) // throwing password error
        return false
    }
    
    // saving user credentials if remember_me is opted by user
    func checkAndSaveCredentials(){
        
        if shouldRememberCredentials{

            print("save credentials to your preferred location")
        }
    }
}

