//
//  Closures.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import Foundation

class Closures: NSObject {

    public typealias MessageString              = (_ message : String)                       -> Void
    public typealias Success                    = ()                                         -> Void
    public typealias SuccessAction              = (()                                        -> ())?
    public typealias SuccessTwoString           = (_ message : String,_ servidor : String)   -> Void
    public typealias Caja                       = (_ arrayBE  : [CajaBE])                    -> Void
    public typealias Impresora                  = (_ arrayBE  : [ImpresoraBE])               -> Void
    public typealias Resumen                    = (_ arrayBE  : [ResumenBE])                 -> Void
    public typealias Qr                         = (_ arrayBE  : [QrBE])                      -> Void
    public typealias Almacen                    = (_ arrayBE  : [AlmacenBE])                 -> Void
    public typealias Sedes                      = (_ arrayBE  : [SedesBE])                   -> Void
    public typealias User                       = (_ arrayBE  : [UserBE])                    -> Void
    public typealias Balance                    = (_ arrayBE  : [BalanceBE])                 -> Void
    public typealias UserObject                 = (_ objBE    :  UserBE )                    -> Void
    public typealias BalanceResumen             = (_ arrayBE  : [BalanceResumenBE])          -> Void
    public typealias Ventas                     = (_ arrayBE  : [VentasBE])                  -> Void
    public typealias Pago                       = (_ arrayBE  : [PagoBE])                    -> Void
    public typealias Check                      = (_ arrayBE  : [CheckBE])                   -> Void
    public typealias Tarjeta                    = (_ arrayBE  : [TarjetaBE])                   -> Void
    public typealias Banco                      = (_ arrayBE  : [BancoBE])                   -> Void
    public typealias Cortesia                   = (_ arrayBE  : [CortesiaBE])                   -> Void
    
}
