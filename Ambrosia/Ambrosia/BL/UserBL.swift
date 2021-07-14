//
//  UserBL.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class UserBL: NSObject {

    class func getUser(completion : @escaping Closures.User, errorServices : @escaping Closures.MessageString){        
        UserWS.getUser(completion: completion, errorServices: errorServices)
    }
    
    class func validateSession(completionHome : @escaping Closures.UserObject, completionLogin : @escaping Closures.Success){
        
        if let objUser = CDUsuario.listarTodos().first{
            
            let userBE = UserBE ()
            
            userBE.patpas = objUser.patpas
            userBE.usucod = objUser.usucod
            userBE.usunam = objUser.usunam
            userBE.usudes = objUser.usudes
            
            completionHome(userBE)
        }else{
            completionLogin()
        }
    }
}
