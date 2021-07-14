//
//  BalanceBL.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

class BalanceBL: NSObject {

    class func getBalance(completion : @escaping Closures.Balance, errorServices : @escaping Closures.MessageString){
        
        var path = ""
        
        if let licencia = CDLicencia.listarTodos().first{
            path = "cajcod=\(licencia.cajcod ?? "")"
        }else{
            errorServices(Alert.problemServices)
            return
        }
        
        BalanceWS.getBalance(path: path, completion: completion, errorServices: errorServices)
    }
    
    class func getResumen(path : String,completion : @escaping Closures.BalanceResumen, errorServices : @escaping Closures.MessageString){
        
        let url = "secnum=\(path)"
        
        BalanceWS.getResumen(path: url, completion: completion, errorServices: errorServices)
    }
}
