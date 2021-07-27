//
//  CAYTextField.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 10/07/21.
//

import UIKit

enum CSMAllowTypeText: Int {
    case number
    case text
    case special
    case number_text
    case all
}

@objc public protocol CAYTextFieldDelegate {
    @objc optional func textFieldUserDidEndEditing(_ textField: CAYTextField)
}

@IBDesignable public class CAYTextField: UITextField {
    
    @IBOutlet weak open var textFieldDelegate   : CAYTextFieldDelegate?
    
    @IBInspectable public var p_errorColor      : UIColor   = .black
    
    private var typingTimer                     : DispatchSourceTimer?
 
    public override var text: String?{
        didSet{
             self.startTimeOutTyping()
            self.hideErrorMessage()
        }
    }
    
    private func startTimeOutTyping() {
        
        self.cancelTimerKeyboard()
        self.typingTimer = DispatchSource.makeTimerSource()
        self.typingTimer?.schedule(deadline: .now() + 1, repeating: 1)
        self.typingTimer?.setEventHandler(handler: {
            
            DispatchQueue.main.async {
                self.cancelTimerKeyboard()
                self.textFieldDelegate?.textFieldUserDidEndEditing?(self)
            }
        })

        self.typingTimer?.activate()
    }
    
    private func cancelTimerKeyboard(){
        self.typingTimer?.cancel()
        self.typingTimer = nil
    }
    
    
    @IBInspectable public var borderColor : UIColor{
        get{
            if let cgBorderColor = self.layer.borderColor{
                return UIColor(cgColor: cgBorderColor)
            }else{
                return .clear
            }
        }
        set(newValue){
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth
        }
        set(newValue){
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = (newValue < 0) ? 0 : newValue
            self.layer.masksToBounds = (self.layer.cornerRadius != 0)
        }
    }
    
    @IBInspectable public var topMargin : CGFloat{
        get{
            return self.edgeMargin.top
        }
        set(newValue){
            self.edgeMargin.top = newValue
        }
    }
    
    @IBInspectable public var leftMargin : CGFloat{
        get{
            return self.edgeMargin.left
        }
        set(newValue){
            self.edgeMargin.left = newValue
        }
    }
    
    @IBInspectable public var rightMargin : CGFloat{
        get{
            return self.edgeMargin.right
        }
        set(newValue){
            self.edgeMargin.right = newValue
        }
    }
    
    @IBInspectable public var bottomMargin : CGFloat{
        get{
            return self.edgeMargin.bottom
        }
        set(newValue){
            self.edgeMargin.bottom = newValue
        }
    }
    
    @IBInspectable public var leftImage : UIImage?{
        get{
            if let contentView = self.leftView,
                let imageView = contentView.viewWithTag(1) as? UIImageView,
                let image = imageView.image{
                return image
            }else{
                return nil
            }
        }
        set(newValue){
            if let image = newValue{
                
                let contentView = UIView(frame:CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: self.frame.height,
                                                      height: self.frame.height))
                
                let imageView = UIImageView(frame: CGRect(x: self.frame.height*0.25,
                                                          y: self.frame.height*0.25,
                                                          width: self.frame.height*0.5,
                                                          height: self.frame.height*0.5))
                
                imageView.contentMode = .scaleToFill
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.tag = 1
                contentView.addSubview(imageView)
                contentView.isUserInteractionEnabled = false
                self.leftView = contentView
                self.leftViewMode = .always
                self.leftMargin = self.frame.height
            }else{
                self.leftView = nil
                self.leftViewMode = .never
                self.leftMargin = 0.0
            }
        }
    }
    
    @IBInspectable public var rightImage : UIImage?{
        get{
            if let contentView = self.rightView,
                let imageView = contentView.viewWithTag(1) as? UIImageView,
                let image = imageView.image{
                return image
            }else
            {
                return nil
            }
        }
        set(newValue){
            if let image = newValue{
                
                let contentView = UIView(frame:CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: self.frame.height,
                                                      height: self.frame.height))
                
                let imageView = UIImageView(frame: CGRect(x: self.frame.height*0.25,
                                                          y: self.frame.height*0.25,
                                                          width: self.frame.height*0.5,
                                                          height: self.frame.height*0.5))
                
                imageView.contentMode = .scaleToFill
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.tag = 1
                imageView.isUserInteractionEnabled = false
                contentView.addSubview(imageView)
                contentView.isUserInteractionEnabled = false
                self.rightView = contentView
                self.rightViewMode = .always
                self.rightMargin = self.frame.height
            }else{
                self.rightView = nil
                self.rightViewMode = .never
                self.rightMargin = 0.0
            }
        }
    }
    
    @IBInspectable public var colorLeftImage : UIColor{
        get{
            
            for view in self.leftView?.subviews ?? [] {
                if view is UIImageView{
                    return view.tintColor
                }
            }
            
            return .darkGray
        }
        set{
            for view in self.leftView?.subviews ?? [] {
                if view is UIImageView{
                    view.tintColor = newValue
                }
            }
        }
    }
    
    @IBInspectable public var colorRightImage : UIColor{
        get{
            
            for view in self.rightView?.subviews ?? [] {
                if view is UIImageView{
                    return view.tintColor
                }
            }
            
            return .darkGray
        }
        set{
            for view in self.rightView?.subviews ?? [] {
                if view is UIImageView{
                    view.tintColor = newValue
                }
            }
        }
    }
    
    @IBInspectable public var replaceSpecialText : Bool = false
    @IBInspectable public var allowNumbers  : Bool = false
    @IBInspectable public var allowAlphabetic  : Bool = false
    @IBInspectable public var allowEmail  : Bool = false
    @IBInspectable public var maxLength  : Int = 250
        
    @IBInspectable public var placeholderColor : UIColor{
        get{
            return self.internalPlaceholderColor
        }
        set{
            self.internalPlaceholderColor = newValue
            let attribute = NSMutableAttributedString(attributedString: NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: self.internalPlaceholderColor]))
            self.attributedPlaceholder = attribute
        }
    }
    
    
    private var internalPlaceholderColor = UIColor.lightGray
    private var edgeMargin : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.borderColor = UIColor.white
        self.borderWidth = 0.0
        self.leftImage = nil
        self.rightImage = nil
        self.deleteBackward()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        
        self.addTarget(self, action: #selector(self.changeTextWhenUseIsTyping(sender:)), for: .editingChanged)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    public func replaceSpecialText(text: String) -> String{
        
        var result = text
        let replacements = ["Ñ": "N", "ñ": "n",
                            "Á": "A", "á": "a",
                            "É": "E", "é": "e",
                            "Í": "I", "í": "i",
                            "Ó": "O", "ó": "o",
                            "Ú": "U", "ú": "u"]
        
        replacements.keys.forEach { result = result.replacingOccurrences(of: $0, with: replacements[$0]!) }
        
        return result
    }
    
    @objc private func changeTextWhenUseIsTyping(sender: UITextField){
        
        let textAllowed = self.allowNumbers ? "0-9" : ""
        let textAlphabetic = self.allowAlphabetic ? "A-Za-zÑñÁáÉéÍíÓóÚú " : ""
        let textEmail = self.allowEmail ? "@.-_" : ""
        var result = self.text?.replacingOccurrences( of:"[^\(textAllowed + textAlphabetic + textEmail)]", with: "", options: .regularExpression)
        
        if replaceSpecialText {
            result = self.replaceSpecialText(text: result ?? "")
        }
        
        if result?.count ?? 0 > self.maxLength{
            result = result?.replacing(range: self.maxLength...(result?.count ?? self.maxLength) - 1, with: "")
        }
        
        sender.text = result
    }
    
    @IBOutlet public weak var bottomConstraint  : NSLayoutConstraint?
    
    private var topLabelErrorConstraint         : NSLayoutConstraint?
    private var initialBottonConstraintConstant : CGFloat = 0
    
    private var errorMessage: String? {
        didSet{
            self.lblErrorMessage.alpha  = 1
            self.lblErrorMessage.text   = self.errorMessage
        }
    }
    
    private var sizeToErrorMessage : CGSize = .zero
    public lazy var lblErrorMessage: UILabel = {
       
        let lbl             = UILabel()
        lbl.text            = self.errorMessage
        lbl.font            = UIFont(name: self.font?.fontName ?? "", size: 11)
        lbl.textColor       = self.p_errorColor
        lbl.alpha           = 0
        lbl.numberOfLines   = 0
        lbl.lineBreakMode   = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        self.addConstraintsToLabelError()
    }
    
    public func showErrorMessageWithText(_ errorMessage: String) {
        
        self.errorMessage = errorMessage
        self.sizeToErrorMessage = self.lblErrorMessage.attributedText?.getSizeToWidth(self.lblErrorMessage.frame.width) ?? .zero
        
        UIView.animate(withDuration: 0.3) {
            self.topLabelErrorConstraint?.constant = 5
            self.bottomConstraint?.constant = self.initialBottonConstraintConstant + self.sizeToErrorMessage.height + (self.topLabelErrorConstraint?.constant ?? 0)
            self.getSuperView(self).layoutIfNeeded()
        }
    }
    
    public func hideErrorMessage() {
        
        UIView.animate(withDuration: 0.3) {
            self.topLabelErrorConstraint?.constant  = -self.sizeToErrorMessage.height
            self.lblErrorMessage.alpha              = 0
            self.bottomConstraint?.constant         = self.initialBottonConstraintConstant
            self.getSuperView(self).layoutIfNeeded()
        }
    }
    
    private func getSuperView(_ view: UIView) -> UIView {
        
        if let newSuperView = view.superview {
            return self.getSuperView(newSuperView)
        }
        
        return view
    }
    
    private func addConstraintsToLabelError(){
        
        if let bottomConstraint = self.bottomConstraint, self.initialBottonConstraintConstant == 0 {
            
            self.initialBottonConstraintConstant = bottomConstraint.constant
            self.superview?.insertSubview(self.lblErrorMessage, belowSubview: self)
            
            self.topLabelErrorConstraint = self.lblErrorMessage.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            self.topLabelErrorConstraint?.isActive = true
            self.lblErrorMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            self.lblErrorMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            self.getSuperView(self).layoutIfNeeded()
        }
    }
}

extension NSAttributedString {
    
    public func getSizeToWidth(_ width: CGFloat) -> CGSize {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil).size
    }
    
    public func getSizeToHeight(_ height: CGFloat) -> CGSize {
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil).size
    }
    
}
