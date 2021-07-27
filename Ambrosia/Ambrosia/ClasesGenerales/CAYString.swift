//
//  CAYString.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 10/07/21.
//

import UIKit

public extension String{
    
    func base64Decode() -> Data? {
        
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        
        if paddingLength > 0 {
            
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            
            base64 += padding
        }
        
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    var localized: String {
        
        let languageString = "\((UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first?.split(separator: "-").first ?? "es")"
        let stringPath = Bundle.main.path(forResource: languageString, ofType: "lproj") ?? ""
        let bundle = Bundle(path: stringPath) ?? Bundle.main
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func mailIsValid() -> Bool {

        let emailRegex = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func mailIsValid(stricterFilter : Bool) -> Bool {
        
        let stricterFilterString = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let laxString = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailRegex = stricterFilter ? stricterFilterString : laxString;
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func replacing(range: CountableClosedRange<Int>, with replacementString: String) -> String {
        
        let start = index(replacementString.startIndex, offsetBy: range.lowerBound)
        let end   = index(start, offsetBy: range.count)
        return self.replacingCharacters(in: start ..< end, with: replacementString)
    }
    
    func openScheme(){
        
        if let scheme = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: scheme){
            
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("Open \(self): \(success)")
            })
            
        }
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
}
