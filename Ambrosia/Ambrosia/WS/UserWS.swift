//
//  UserWS.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class UserWS: NSObject {

    class func getUser(completion : @escaping Closures.User, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.User.getUser
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: nil) { response in
    
            if let json = response.JSON?.array{
                
                var arrayBE = [UserBE]()
                
                for item in json{
                    arrayBE.append(UserBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
        }
    }
    
}
