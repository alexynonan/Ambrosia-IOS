//
//  ValidationsBL.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 23/07/21.
//

import UIKit

class ValidationsBL: NSObject {

    class func validateMail(_ mail : String?) -> String? {
        if mail?.mailIsValid() != true{
            return Alert.Form.error_email
        }else{
            return nil
        }
    }
    
    class func validateFormWithDocument(_ documentNumber: String?) -> String? {
        
        if documentNumber?.count != 0 || documentNumber?.count == 8 || documentNumber?.count == 11{
            if documentNumber?.count == 8{
                return Alert.Form.error_reniec
            }else if documentNumber?.count == 11{
                return Alert.Form.error_sunat
            }else{
                return nil
            }            
        } else {
            return nil
        }
    }

    class func validateText(_ text : String?,message : String) -> String? {
        if text?.trim().count == 0 || text?.trim().count ?? 0 < 3{
            return message
        }else{
            return nil
        }
    }
    
    class func validateLink(_ text : String?) -> String?{
        if text?.trim().count == 0 || text?.isValidURL == false {
            return Alert.Form.error_link
        }else{
            return nil
        }
    }
    
}
