//
//  BalanceBE.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

class BalanceBE: NSObject {

    var secnum : String?
    var cajcod : String?
    var cajdes : String?
    var cajest : String?
    var fecape_s : String?
    var feccie_s : String?
    var usuape : String?
    var usucie : String?
    var totchi : String?
    
    class func parse(_ json : CSMJSON) -> BalanceBE{
        
        let objBE = BalanceBE()
        
        objBE.secnum = json.dictionary["secnum"]?.stringValue ?? ""
        objBE.cajcod = json.dictionary["cajcod"]?.stringValue ?? ""
        objBE.cajdes = json.dictionary["cajdes"]?.stringValue ?? ""
        objBE.cajest = json.dictionary["cajest"]?.stringValue ?? ""
        objBE.fecape_s = json.dictionary["fecape_s"]?.stringValue ?? ""
        objBE.feccie_s = json.dictionary["feccie_s"]?.stringValue ?? ""
        objBE.usuape = json.dictionary["usuape"]?.stringValue ?? ""
        objBE.usucie = json.dictionary["usucie"]?.stringValue ?? ""
        objBE.totchi = json.dictionary["totchi"]?.stringValue ?? ""
        
        return objBE
    }
}

class BalanceResumenBE: NSObject {

    var totcod : String?
    var totdes : String?
    var tottip : String?
    var totnet : String?
    
    class func parse(_ json : CSMJSON) -> BalanceResumenBE{
        
        let objBE = BalanceResumenBE()
        
        objBE.totcod = json.dictionary["totcod"]?.stringValue ?? ""
        objBE.totdes = json.dictionary["totdes"]?.stringValue ?? ""
        objBE.tottip = json.dictionary["tottip"]?.stringValue ?? ""
        objBE.totnet = json.dictionary["totnet"]?.stringValue ?? ""
        
        return objBE
    }
}
