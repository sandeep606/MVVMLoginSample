//
//  ServerRequestManager.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


enum errorDes:String{
    
    case jsonParsingError
    case serverError
    case networkError
}

class ServerRequestManager: NSObject {
    
    static let sharedManager = ServerRequestManager()
    // function to be used for contacting server
    func connectToServer(parameters:NSDictionary?=nil, completion:@escaping (_ responseObject:AnyObject?, _ error:NSError?, _ success:Bool)->()){
        
        Alamofire.request(loginURL, method: HTTPMethod.post, parameters: parameters as? Parameters).responseData { (response) in
            
            if(response.result.isSuccess){
                
                do{
                    let responseValue:NSDictionary =  try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    completion(responseValue, nil, true)
                }
                catch{
                    
                    completion(nil,NSError(domain: "www.evontech.com", code: 400, userInfo: ["Error Description":"Parsing failed"]), false)
                }
            }
            else{
                completion(nil, NSError(domain: "www.evontech.com", code: 401, userInfo: ["Error Description":"Response failed"]), false)
            }
        }
        
    }
    
}
