//
//  MVVM_Protocols.swift
//  ModelViewViewModel
//
//  Created by evontech on 24/07/18.
//  Copyright © 2018 Evontech. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate : class{
    
    func errorInCredentials(fieldType:FieldType, message:String)
    func validEntryFor(fieldType:FieldType)

}
