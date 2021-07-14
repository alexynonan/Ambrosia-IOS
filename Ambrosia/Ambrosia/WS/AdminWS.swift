//
//  AdminWS.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class AdminWS: NSObject {
    
    class func validateLicencia(dic : [String : Any],completion : @escaping Closures.SuccessTwoString, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Licencia.licencia
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: dic) { response in
            
            if response.JSON?.dictionary["rpta"]?.stringValue ?? "" == "OK"{
                completion(Alert.Licencia.messageOK,response.JSON?.dictionary["servidor"]?.stringValue ?? "")
            }else{
                errorServices(Alert.Licencia.messageError)
            }
        }
    }

    class func getCaja(completion : @escaping Closures.Caja, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Licencia.caja
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: nil) { response in
    
            if let json = response.JSON?.array{
                
                var arrayBE = [CajaBE]()
                
                for item in json{
                    arrayBE.append(CajaBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
        }
    }
    
    class func getAlmacen(completion : @escaping Closures.Almacen, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Licencia.almacen
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: nil) { response in
    
            if let json = response.JSON?.array{
                
                var arrayBE = [AlmacenBE]()
                
                for item in json{
                    arrayBE.append(AlmacenBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
        }
    }
    
    class func getSedes(completion : @escaping Closures.Sedes, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Licencia.sedes
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: nil) { response in
    
            if let json = response.JSON?.array{
                
                var arrayBE = [SedesBE]()
                
                for item in json{
                    arrayBE.append(SedesBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
        }
    }
}
