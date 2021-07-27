//
//  VentasWS.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class VentasWS: NSObject {

    class func getVentas(path : String,completion : @escaping Closures.Ventas, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Ventas.ventas + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [VentasBE]()
                
                for item in json{
                    arrayBE.append(VentasBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
    
    class func getFacturaCheck(path : String,completion : @escaping Closures.Check, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Ventas.check + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [CheckBE]()
                
                for item in json{
                    arrayBE.append(CheckBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
    
    class func getFacturaDocumento(path : String,completion : @escaping Closures.Ventas, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Ventas.documento + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [VentasBE]()
                
                for item in json{
                    arrayBE.append(VentasBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
    
    class func getFacturaPago(path : String,completion : @escaping Closures.Pago, errorServices : @escaping Closures.MessageString){
        
        let urlBAse = ServicesURL.Ventas.pago + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBAse, parameters: nil) { response in
            
            if let json = response.JSON?.array{
                
                var arrayBE = [PagoBE]()
                
                for item in json{
                    arrayBE.append(PagoBE.parse(item))
                }
                          
                completion(arrayBE)
            }else{
                errorServices(Alert.problemServices)
            }
            
        }
    }
    
    class func sendPago(dic : [[String : Any]],completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Comprobante.pago
        
        let header = CSMWebServiceHeaderRequest()
                
        header.contentType = .raw
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, header: header, parameters: dic) { response in
            
            if response.JSON?.dictionary["rpta"]?.stringValue ?? "" == "OK"{
                completion(Alert.Pago.messageComprobante)
            }else{
                errorServices(Alert.Pago.messageComprobanteError)
            }
        }
    }
    
    class func sendComprobante(dic : [String : Any],completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Comprobante.cambio
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: dic) { response in
            
            if response.JSON?.dictionary["rpta"]?.stringValue ?? "" == "OK"{
                completion(Alert.Pago.messageComprobante)
            }else{
                errorServices(Alert.Pago.messageComprobanteError)
            }
        }
    }
    
    class func sendAnular(path : String,completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Comprobante.anular + path
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: nil) { response in
            
            if response.JSON?.dictionary["rpta"]?.stringValue ?? "" == "OK"{
                completion(Alert.Pago.messageComprobanteAnulada)
            }else{
                errorServices(Alert.Pago.messageErrorAnularCompro)
            }
        }
    }
}
