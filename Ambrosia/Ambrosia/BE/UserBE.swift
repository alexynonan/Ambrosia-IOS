//
//  UserBE.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class UserBE: NSObject {
    
    var usunam : String?
    var patpas : String?
    var usudes : String?
    var usucod : String?

    class func parse(_ json : CSMJSON) -> UserBE{
        let objBE = UserBE()
        
        objBE.usunam = json.dictionary["usunam"]?.stringValue ?? ""
        objBE.usudes = json.dictionary["usudes"]?.stringValue ?? ""
        objBE.patpas = json.dictionary["patpas"]?.stringValue ?? ""
        objBE.usucod = json.dictionary["usucod"]?.stringValue ?? ""
        
        return objBE
    }
}
