//
//  LoginModel.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation

class LoginUser : NSObject{
    
    var userEmail : String
    var userPassword : String
    
    override init() {
        self.userPassword = ""
        self.userEmail = ""
    }
    
    // initializing self with email and Password
    init(withEmail userEmail:String, password:String) {
        self.userEmail = userEmail
        self.userPassword = password
    }
    
    // requesting server to authenticate user.
    // callback/closure with response and error.
    func requestToServer(completion:@escaping (_ responseObject:AnyObject?, _ error:NSError?, _ success:Bool)->()){
    
        ServerRequestManager.sharedManager.doUserLogin(loginUser: self) { (responseObject, error, status) in
            
            completion(responseObject, error, status)
        }
    }
}
