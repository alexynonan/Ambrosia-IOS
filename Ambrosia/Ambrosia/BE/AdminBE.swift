//
//  AdminBE.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class AdminBE {

    
    
}

class LicenciaBE {
    
    var servidor = ""
    var licencia = ""
    var almcod = ""
    var cajcod = ""
    var impres1 = ""
    var impres2 = ""
    var qrcuenta = ""
    var resumen = ""
    var sednum = ""
}

class CajaBE {
    
    var cojcod : String?
    var cajdes : String?
    
    class func parse(_ json : CSMJSON) -> CajaBE{
        
        let objBE = CajaBE()
        
        objBE.cojcod = json.dictionary["cajcod"]?.stringValue ?? ""
        objBE.cajdes = json.dictionary["cajdes"]?.stringValue ?? ""
        
        return objBE
    }
}


class ImpresoraBE {
    
    var impresora_cod  : String?
    var impresora_desc : String?
}

class ResumenBE {
    
    var resumen_cod  : String?
    var resumen_desc : String?
}

class QrBE {
    
    var qr_cod  : String?
    var qr_desc : String?
}

class AlmacenBE {
    
    var almcod  : String?
    var almdes : String?
    
    class func parse(_ json : CSMJSON) -> AlmacenBE{
        
        let objBE = AlmacenBE()
        
        objBE.almcod = json.dictionary["almcod"]?.stringValue ?? ""
        objBE.almdes = json.dictionary["almdes"]?.stringValue ?? ""
        
        return objBE
    }
}

class SedesBE {
    
    var sednum  : String?
    var seddes : String?
    
    class func parse(_ json : CSMJSON) -> SedesBE{
        
        let objBE = SedesBE()
        
        objBE.sednum = json.dictionary["sednum"]?.stringValue ?? ""
        objBE.seddes = json.dictionary["seddes"]?.stringValue ?? ""
        
        return objBE
    }
}
