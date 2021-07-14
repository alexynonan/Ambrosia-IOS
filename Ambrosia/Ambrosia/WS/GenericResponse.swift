//
//  GenericResponse.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import Foundation

class GenericResponseWS: NSObject {
    
    class func responseStatus(_ response: CSMWebServiceResponse,_ success: @escaping Closures.MessageString , error: Closures.MessageString){

            if response.JSON?.dictionary["rpta"]?.stringValue ?? "" == "OK"{
                success(self.manageErrorFromResponse(response))
            }else{
                error(self.manageErrorFromResponse(response))
            }

        }

    class func genericResponse(_ response: CSMWebServiceResponse, success: (_ json: CSMJSON) -> Void, error: Closures.MessageString){

        if response.status == .success {

            if response.JSON?.dictionary["status"]?.intValue == 200 || response.JSON?.dictionary["status"]?.stringValue == "200"{
                if let data = response.JSON?.dictionary["data"]{
                    success(data)
                }
            }else{
                error(self.manageErrorFromResponse(response))
           }

        }else{
            error(self.manageErrorFromResponse(response))
        }
    }
    
   private class func manageErrorFromResponse(_ response: CSMWebServiceResponse) -> String{

        if let message = response.JSON?.dictionary["message"]{
            return message.stringValue ?? ""
        }else if let message = response.JSON?.dictionary["mensaje"]{
            return message.stringValue ?? ""
        }else{
           return "Problemas con el Servicio"
        }
   }
}
