//
//  AdminBL.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class AdminBL: NSObject {

    class func validateLicencia(text :  String,completion : @escaping Closures.SuccessTwoString, errorServices : @escaping Closures.MessageString){
        
        if text.trim().count == 0 {
            errorServices(Alert.Licencia.messageLicencia)
            return
        }
        
        let dic : [String : Any] = ["ambrocod": text]
        
        AdminWS.validateLicencia(dic: dic) { message, servidor in
            
            CDLicencia.deleteLicencia()
            
            let obj = LicenciaBE()
            
            obj.servidor = servidor
            obj.licencia = text
            obj.cajcod = "00"
            obj.impres1 = "0"
            obj.impres2 = "0"
            obj.resumen = "0"
            obj.qrcuenta = "0"
            obj.almcod = "A1"
            obj.sednum = "1"
            
            Configuration.sharedInstance.configurationUrlServices = obj.servidor
            
            CDLicencia.save(licencia: obj)
            
            completion(message, servidor)
            
        } errorServices: { error in
            errorServices(error)
        }
    }
    
    
    class func getCaja(completion : @escaping Closures.Caja, errorServices : @escaping Closures.MessageString){        
        AdminWS.getCaja(completion: completion, errorServices: errorServices)
    }
    
    class func getImpresoraOne(completion : @escaping Closures.Impresora){
        
        var arrayBE = [ImpresoraBE]()
        
        let objOne = ImpresoraBE()
        
        objOne.impresora_cod = "0"
        objOne.impresora_desc = "No Aplica"
        
        arrayBE.append(objOne)
        
        let objTwo = ImpresoraBE()
        
        objTwo.impresora_cod = "1"
        objTwo.impresora_desc = "Imprime en Caja"
        
        arrayBE.append(objTwo)
        
        completion(arrayBE)
    }
    
    class func getResumen(completion : @escaping Closures.Resumen){
        
        var arrayBE = [ResumenBE]()
        
        let objOne = ResumenBE()
        
        objOne.resumen_cod = "0"
        objOne.resumen_desc = "No Aplica"
        
        arrayBE.append(objOne)
        
        let objTwo = ResumenBE()
        
        objTwo.resumen_cod = "1"
        objTwo.resumen_desc = "Muestra Resumen"
        
        arrayBE.append(objTwo)
        
        completion(arrayBE)
    }
    
    class func getQR(completion : @escaping Closures.Qr){
        
        var arrayBE = [QrBE]()
        
        let objOne = QrBE()
        
        objOne.qr_cod = "0"
        objOne.qr_desc = "No Imprime"
        
        arrayBE.append(objOne)
        
        let objTwo = QrBE()
        
        objTwo.qr_cod = "1"
        objTwo.qr_desc = "Imprime QR"
        
        arrayBE.append(objTwo)
        
        completion(arrayBE)
    }
    
    class func getAlmacen(completion : @escaping Closures.Almacen, errorServices : @escaping Closures.MessageString){        
        AdminWS.getAlmacen(completion: completion, errorServices: errorServices)
    }
    
    class func getSedes(completion : @escaping Closures.Sedes, errorServices : @escaping Closures.MessageString){
        AdminWS.getSedes(completion: completion, errorServices: errorServices)
    }
}
