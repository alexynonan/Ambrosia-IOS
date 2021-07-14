//
//  PickerDateViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit


protocol PickerDateViewControllerDelegate {
    func selectDateViewController(_ controller : PickerDateViewController, sender : Date)
}

class PickerDateViewController: UIViewController {

    @IBOutlet private weak var constraintBottomPicker       : NSLayoutConstraint!
    @IBOutlet private weak var constraintHeightContainer    : NSLayoutConstraint!
    @IBOutlet private weak var pickerDate                   : UIDatePicker!
    
    var delegate : PickerDateViewControllerDelegate?
    
    var dataTypeSelectDate  : LDDateType = .date
    var deadLine            : Date?
    var restrictDate        : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animate()
    }
    
    @IBAction func seleccionoFecha(_ sender: UIDatePicker) {
        self.delegate?.selectDateViewController(self, sender: sender.date)
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

//
extension PickerDateViewController {
    
    private func load(){
        
        self.view.backgroundColor = .clear
        
        self.constraintBottomPicker.constant = -self.constraintHeightContainer.constant
       
        let currentDate = Date()
        
        if let restrict = self.restrictDate{
            
            if restrict == true{
                
                if let deadLine = self.deadLine, deadLine <= currentDate{
                    let maxDate = currentDate.addingTimeInterval(currentDate.timeIntervalSinceNow)
                    self.pickerDate.minimumDate = maxDate
                }

            }else{
                let maxDate = currentDate.addingTimeInterval(currentDate.timeIntervalSinceNow)
                self.pickerDate.maximumDate = maxDate
            }
        }
        
        if self.dataTypeSelectDate == .date {
                    
            self.pickerDate.datePickerMode = .date
            
        }else if self.dataTypeSelectDate == .start_time_minute || self.dataTypeSelectDate == .end_time_minute{
            
            self.pickerDate.datePickerMode = .countDownTimer
        }
        
        self.pickerDate.date = Date()
        self.delegate?.selectDateViewController(self, sender: self.pickerDate.date)
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
            self.constraintBottomPicker.constant = -self.pickerDate.frame.size.height
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
