//
//  VentasBE.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class VentasBE: NSObject {

    var secnum : String?
    var usunam : String?
    var tdonum : String?
    var clides : String?
    var comdes : String?
    var facfec_s : String?
    var sernum : String?
    var facnum : String?
    var facnet : String?
    var facest : String?
    var facdir : String?
    var facobs : String?
    var factel : String?
    
    var descripcion = ""
    
// Objetos de factura_cabecera
    var secprf : String?
    var comcod : String?
    var sercod : String?
    var serdes : String?
    var efaqr : String?
    var usucom : String?
    var usupag : String?

    
    class func parse(_ json : CSMJSON) -> VentasBE{
        
        let objBE = VentasBE()
        
        objBE.secnum = json.dictionary["secnum"]?.stringValue ?? ""
        objBE.usunam = json.dictionary["usunam"]?.stringValue ?? ""
        objBE.tdonum = json.dictionary["tdonum"]?.stringValue ?? ""
        objBE.clides = json.dictionary["clides"]?.stringValue ?? ""
        objBE.comdes = json.dictionary["comdes"]?.stringValue ?? ""
        objBE.facfec_s = json.dictionary["facfec_s"]?.stringValue ?? ""
        objBE.sernum = json.dictionary["sernum"]?.stringValue ?? ""
        objBE.facnum = json.dictionary["facnum"]?.stringValue ?? ""
        objBE.facnet = json.dictionary["facnet"]?.stringValue ?? ""
        objBE.facest = json.dictionary["facest"]?.stringValue ?? ""
        objBE.facdir = json.dictionary["facdir"]?.stringValue ?? ""
        objBE.facobs = json.dictionary["facobs"]?.stringValue ?? ""
        objBE.factel = json.dictionary["factel"]?.stringValue ?? ""
        
        objBE.secprf = json.dictionary["sercod"]?.stringValue ?? ""
        objBE.comcod = json.dictionary["serdes"]?.stringValue ?? ""
        objBE.sercod = json.dictionary["sercod"]?.stringValue ?? ""
        objBE.serdes = json.dictionary["serdes"]?.stringValue ?? ""
        objBE.efaqr = json.dictionary["efaqr"]?.stringValue ?? ""
        objBE.usucom = json.dictionary["usucom"]?.stringValue ?? ""
        objBE.usupag = json.dictionary["usupag"]?.stringValue ?? ""
        
        return objBE
    }
    
    class func sendComprobante(objBE : VentasBE,objLicencia : LicenciaBE) -> [String : Any]{
        
        let itemDic : [String : Any] = ["secnum": objBE.secnum ?? "",
                                        "cajcod" : objLicencia.cajcod,
                                        "sednum" : objLicencia.sednum,
                                        "almcod" : objLicencia.almcod,
                                        "secprf" : objBE.secprf ?? "",
                                        "sercod" : objBE.sercod ?? "",
                                        "clides" : objBE.clides ?? "",
                                        "tdonum" : objBE.tdonum ?? "",
                                        "facdir" : objBE.facdir ?? "",
                                        "facobs" : objBE.facobs ?? "",
                                        "factel" : objBE.factel ?? "",
                                        "usunam" : objBE.usunam ?? "",
                                        "facnet" : objBE.facnet ?? ""]
        
        return itemDic
    }
}

class CheckBE: NSObject {

    var secnum : String?
    var facobs : String?
    var secitm : String?
    var secnli : String?
    var faccan_e : String?
    var tarcod : String?
    var tardes : String?
    var facuni1 : String?
    var facnet1 : String?
    
    class func parse(_ json : CSMJSON) -> CheckBE{
        
        let objBE = CheckBE()
        
        objBE.secnum   = json.dictionary["secnum"]?.stringValue ?? ""
        objBE.facobs   = json.dictionary["facobs"]?.stringValue ?? ""
        objBE.secitm   = json.dictionary["secitm"]?.stringValue ?? ""
        objBE.secnli   = json.dictionary["secnli"]?.stringValue ?? ""
        objBE.faccan_e = json.dictionary["faccan_e"]?.stringValue ?? ""
        objBE.tarcod   = json.dictionary["tarcod"]?.stringValue ?? ""
        objBE.tardes   = json.dictionary["tardes"]?.stringValue ?? ""
        objBE.facuni1  = json.dictionary["facuni1"]?.stringValue ?? ""
        objBE.facnet1  = json.dictionary["facnet1"]?.stringValue ?? ""
        
        return objBE
    }
}

class PagoBE: NSObject {
    
    var secnum : String?
    var secitm : String?
    var fpacod : String?
    var fpades : String?
    var tiptar : String?
    var lottar : String?
    var reftar : String?
    var tipban : String?
    var tdpdes : String?
    var opeban : String?
    var fpaobs : String?
    var tipcor : String?
    var moncob : String?
    var monrec : String?
    var monvue : String?
    var descor : String?
    var state = false
    
    class func parse(_ json : CSMJSON) -> PagoBE{
        
        let objBE = PagoBE()
        
        objBE.secnum = json.dictionary["secnum"]?.stringValue ?? ""
        objBE.secitm = json.dictionary["secitm"]?.stringValue ?? ""
        objBE.fpacod = json.dictionary["fpacod"]?.stringValue ?? ""
        objBE.fpades = json.dictionary["fpades"]?.stringValue ?? ""
        objBE.tiptar = json.dictionary["tiptar"]?.stringValue ?? ""
        objBE.lottar = json.dictionary["lottar"]?.stringValue ?? ""
        objBE.reftar = json.dictionary["reftar"]?.stringValue ?? ""
        objBE.tipban = json.dictionary["tipban"]?.stringValue ?? ""
        objBE.tdpdes = json.dictionary["tdpdes"]?.stringValue ?? ""
        objBE.opeban = json.dictionary["opeban"]?.stringValue ?? ""
        objBE.fpaobs = json.dictionary["fpaobs"]?.stringValue ?? ""
        objBE.tipcor = json.dictionary["tipcor"]?.stringValue ?? ""
        objBE.moncob = json.dictionary["moncob"]?.stringValue ?? ""
        objBE.monrec = json.dictionary["monrec"]?.stringValue ?? ""
        objBE.monvue = json.dictionary["monvue"]?.stringValue ?? ""
        objBE.descor = json.dictionary["descor"]?.stringValue ?? ""
        
        return objBE
    }
    
    class func sendPago(array : [PagoBE]) -> [[String : Any]]{
        
        var dic : [[String : Any]] = [[String : Any]]()
        
        for item in array{
            
            let itemDic : [String : Any] = ["fpacod" : item.fpacod ?? "",
                                            "tiptar" : item.tiptar ?? "",
                                            "lottar" : item.lottar ?? "",
                                            "reftar" : item.reftar ?? "",
                                            "tipban" : item.tipban ?? "",
                                            "opeban" : item.opeban ?? "",
                                            "fpaobs" : item.fpaobs ?? "",
                                            "tipcor" : item.tipcor ?? "",
                                            "moncob" : Int(item.moncob ?? "") ?? 0,
                                            "monrec" : Int(item.monrec ?? "") ?? 0,
                                            "monvue" : Int(item.monvue ?? "") ?? 0]
            
            dic.append(itemDic)
        }
        return dic
    }

}

class BancoBE: NSObject {
    
    var name = ""
    var id  = 0
    
    init(name : String, id : Int) {
        self.name = name
        self.id = id
    }
}

class CortesiaBE: NSObject {
    
    var name = ""
    var id  = 0
    
    init(name : String, id : Int) {
        self.name = name
        self.id = id
    }
}

class TarjetaBE: NSObject {
    
    var name = ""
    var id  = 0
    
    init(name : String, id : Int) {
        self.name = name
        self.id = id
    }
}


