//
//  BalanceWS.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

class BalanceWS: NSObject {

    class func getBalance(path : String,completion : @escaping Closures.Balance, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Balance.balance + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [BalanceBE]()
                
                for item in json{
                    arrayBE.append(BalanceBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
    
    class func getResumen(path : String,completion : @escaping Closures.BalanceResumen, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Balance.resumen + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [BalanceResumenBE]()
                
                for item in json{
                    arrayBE.append(BalanceResumenBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
}
