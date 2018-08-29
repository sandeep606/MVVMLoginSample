//
//  LoginServerRequest.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation

extension ServerRequestManager {
    
    // Actual call to server to authenticate user.
    // one can Map the response here(Example: use of ObjectMapper to Map response objects)
    func doUserLogin(loginUser:LoginUser, completion: @escaping(_ responseObject:AnyObject?, _ error:NSError?, _ success:Bool)->()) -> Void {
        
        self.connectToServer(parameters:  ["username": loginUser.userEmail, "password": loginUser.userPassword,"devicetoken": "ba44r",  "devicetype": "iPhone"]) { (responseObject, error, status) in
                
            completion(responseObject, error, status)
        }
    }
}
