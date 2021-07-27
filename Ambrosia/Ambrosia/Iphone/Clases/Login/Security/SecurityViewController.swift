//
//  SecurityViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

protocol SecurityViewControllerDelegate {
    func showHome(_ controller : SecurityViewController, codigo : Any?)
}

class SecurityViewController: UIViewController {
    
    @IBOutlet private weak var viewAnimateTwo       : UIView!
    @IBOutlet private weak var constraintViewTwo    : NSLayoutConstraint!
    @IBOutlet private weak var txtCodigo            : UITextField!
    @IBOutlet private weak var btnStyleIngresar     : UIButton!

    var delegate : SecurityViewControllerDelegate?
    var objUser  = UserBE()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAnimateTwo.alpha = 0
        self.animateBackGround(color: .clear)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateBackGround(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
        self.animateView(alphaTwo: 1, constraintTwo: 0, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
    }
    
    @IBAction func btnCancelar(_ sender : UIButton){
        self.animateCancell()
    }
    
    @IBAction func btnSendCodigo(_ sender : UIButton){
        self.animationSuccesCode()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: -Methods

extension SecurityViewController {
 
    private func animateView(alphaTwo : CGFloat, constraintTwo : CGFloat, completion : Closures.SuccessAction){
        
        self.constraintViewTwo.constant = constraintTwo
        self.viewAnimateTwo.alpha = alphaTwo
        UIView.animate(withDuration: 0.9, delay: 0, options: .curveEaseInOut) {
            self.viewAnimateTwo.transform = .identity
            self.viewAnimateTwo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }completion: { (state) in
            completion?()
        }
    }
    
    private func animateCancell(){
        self.constraintViewTwo.constant = -1000
        UIView.animate(withDuration: 0.9, delay: 0, options: .curveEaseInOut) {
            self.viewAnimateTwo.transform = .identity
            self.viewAnimateTwo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }completion: { (state) in
            self.viewAnimateTwo.alpha = 0
            self.dismiss(animated: true) {
                self.delegate?.showHome(self, codigo: nil)
            }
        }
       
    }
    
    private func animationSuccesCode(){
        
        if self.txtCodigo.text == self.objUser.patpas{
            self.animateView(alphaTwo: 1, constraintTwo: 500, completion: {
                self.dismiss(animated: true) {
                    self.delegate?.showHome(self, codigo: self.objUser)
                }
            })
        }else{
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: "Ingrese correcto su codigo", withAcceptButton: Alert.agreedButton, withCompletion: nil)
        }
    }

}
