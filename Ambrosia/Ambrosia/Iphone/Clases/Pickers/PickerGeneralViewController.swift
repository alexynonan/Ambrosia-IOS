//
//  PickerGeneralViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

protocol PickerGeneralViewControllerDelegate {
    func showSelect(controller : PickerGeneralViewController, sender : Any?, tag : Int)
}

class PickerGeneralViewController: UIViewController {

    @IBOutlet private weak var constraintBottomPicker           : NSLayoutConstraint!
    @IBOutlet private weak var constraintHeightContainer        : NSLayoutConstraint!
    @IBOutlet private weak var pickerGeneral                    : UIPickerView!
    
    var delegate : PickerGeneralViewControllerDelegate?
    var stateTipo = -1
    var arrayGeneral = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animate()
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.close()
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

//MARK: -METHODS
extension PickerGeneralViewController {
 
    private func load(){
        self.arrayGeneral.count == 0 ? self.arrayGeneral.append("Sin datos") : nil
        self.view.backgroundColor = .clear
        self.constraintBottomPicker.constant = -self.constraintHeightContainer.constant
        self.delegate?.showSelect(controller: self, sender: self.arrayGeneral[0],tag: self.stateTipo)
    }
    
    private func animate(){
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.constraintBottomPicker.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func close(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = .clear
            self.constraintBottomPicker.constant = -self.pickerGeneral.frame.size.height
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

//MARK: -METHODS
extension PickerGeneralViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayGeneral.count == 0 ? 1 : self.arrayGeneral.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let textObj : CajaBE = self.arrayGeneral[row] as? CajaBE{
            return textObj.cajdes
            
        }else if let impresora : ImpresoraBE = self.arrayGeneral[row] as?ImpresoraBE{
            return impresora.impresora_desc
            
        }else if let resumen : ResumenBE = self.arrayGeneral[row] as? ResumenBE {
            return resumen.resumen_desc
            
        }else if let qr : QrBE = self.arrayGeneral[row] as? QrBE{
            return qr.qr_desc
            
        }else if let almacen : AlmacenBE = self.arrayGeneral[row] as? AlmacenBE{
            return almacen.almdes
            
        }else if let local : SedesBE = self.arrayGeneral[row] as? SedesBE {
            return local.seddes
        }
        
        return self.arrayGeneral[row] as? String ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.showSelect(controller: self, sender: self.arrayGeneral[row], tag: self.stateTipo)
    }
    
}
