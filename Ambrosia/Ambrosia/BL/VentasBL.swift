//
//  VentasBL.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class VentasBL: NSObject {

    class func getVentas(completion : @escaping Closures.Ventas, errorServices : @escaping Closures.MessageString){
        
        var path = ""
        
        if let licencia = CDLicencia.listarTodos().first{
            path = "secnum=\(licencia.cajcod ?? "")"
        }else{
            errorServices(Alert.problemServices)
            return
        }
        
        VentasWS.getVentas(path: path, completion: completion, errorServices: errorServices)
    }
    
    class func getFacturaCheck(secfac : String,completion : @escaping Closures.Check, errorServices : @escaping Closures.MessageString){
        
        VentasWS.getFacturaCheck(path: "secfac=\(secfac)", completion: completion, errorServices: errorServices)
    }

    class func getFacturaDocumento(secfac : String,completion : @escaping Closures.Ventas, errorServices : @escaping Closures.MessageString){
        
        VentasWS.getFacturaDocumento(path: "secfac=\(secfac)", completion: completion, errorServices: errorServices)
    }
    
    class func getFacturaPago(secfac : String,completion : @escaping Closures.Pago, errorServices : @escaping Closures.MessageString){
    
        VentasWS.getFacturaPago(path: "secfac=\(secfac)", completion: completion, errorServices: errorServices)
    }
    
    class func getBancos() -> [BancoBE]{
        
        let banco1 = BancoBE(name: "YAPE", id: 0)
        let banco2 = BancoBE(name: "TRANSFERENCIA", id: 1)
        let banco3 = BancoBE(name: "DEPOSITO", id: 1)
        
        return [banco1,banco2,banco3]
    }
    
    class func getTarjeta() -> [TarjetaBE]{
        
        let tarjeta1 = TarjetaBE(name: "VISA", id: 0)
        let tarjeta2 = TarjetaBE(name: "MASTERCARD", id: 1)
        let tarjeta3 = TarjetaBE(name: "DINERS CLUB", id: 1)
        let tarjeta4 = TarjetaBE(name: "AMERICAN EXPRESS", id: 1)
        
        return [tarjeta1,tarjeta2,tarjeta3,tarjeta4]
    }
    
    class func getCortesia() -> [CortesiaBE]{
        
        let cortesia1 = CortesiaBE(name: "AUT X SRA ELVA", id: 0)
        
        return [cortesia1]
    }
    
    class func sendPago(array : [PagoBE],completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        let dic = PagoBE.sendPago(array: array)
        VentasWS.sendPago(dic: dic, completion: completion, errorServices: errorServices)
    }
    
    class func sendComprobante(obj : VentasBE,completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        if let coreLicencia = CDLicencia.listarTodos().first{
            
            let licencia = LicenciaBE()
            
            coreLicencia.cajcod = coreLicencia.cajcod
            coreLicencia.sednum = coreLicencia.sednum
            coreLicencia.almcod = coreLicencia.almcod
            
            let dic = VentasBE.sendComprobante(objBE: obj, objLicencia: licencia)
            VentasWS.sendComprobante(dic: dic, completion: completion, errorServices: errorServices)
        }else{
            errorServices(Alert.problemServices)
            return
        }
    }
    
    class func sendAnular(obj : VentasBE,completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        let path = "secfac=\(obj.secnum ?? "")&motivo=\(obj.descripcion)&usunam=\(obj.usunam ?? "")"
        
        VentasWS.sendAnular(path: path, completion: completion, errorServices: errorServices)
    }
}
