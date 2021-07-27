//
//  PagoViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class PagoViewController: UIViewController {

    @IBOutlet weak public var tblPago : UITableView!
    
    var controllerDetail : DetailVentasViewController?
    
    public var arrayAddPago = [PagoBE]()
    
    public var arrayPago = [PagoBE](){
        didSet{
            self.tblPago.reloadSections(IndexSet(arrayLiteral: 0), with: .left)
        }
    }
    
    public var stateEdit = false
    
    lazy var refreshControll : UIRefreshControl! = {
       
        var objRefreshControll = UIRefreshControl()
        
        objRefreshControll.tintColor = .darkGray
        objRefreshControll.addTarget(self, action: #selector(self.getPago), for: .valueChanged)
        
        return objRefreshControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadValidation()
        // Do any additional setup after loading the view.
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

//MARK:- METHODS
extension PagoViewController {
    
    private func loadValidation(){
        self.controllerDetail?.controllerPago = self
        self.tblPago.backgroundView = self.refreshControll
        self.getPago()
    }
    
    @objc private func getPago(){
        self.refreshControll.beginRefreshing()
        VentasBL.getFacturaPago(secfac: self.controllerDetail?.objVentas?.secnum ?? "") { array in
            self.refreshControll.endRefreshing()
            self.arrayPago = array
        } errorServices: { errorMessage in
            self.refreshControll.endRefreshing()
        }
    }
    
    public func sendPago(){
        if self.arrayAddPago.count == 0{ return }
        self.controllerDetail?.animateSend(true)
        VentasBL.sendPago(array: self.arrayAddPago) { message in
            self.controllerDetail?.animateSend(false)
            self.controllerDetail?.showAlert(withTitle: Alert.titleError, withMessage: message, withAcceptButton: Alert.agreedButton, withCompletion: {
                self.controllerDetail?.dismiss(animated: true, completion: nil)
            })
        } errorServices: { error in
            self.controllerDetail?.animateSend(false)
            self.controllerDetail?.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton, withCompletion: {
            })
        }
    }
    
}

//MARK: -TableView
extension PagoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPago.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = CellIdentifier.PagoTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PagoTableViewCell
        
        cell.viewStyle.backgroundColor = indexPath.row % 2 == 0 ? .white : #colorLiteral(red: 0.948946774, green: 0.9490604997, blue: 0.9489082694, alpha: 1) 
        
        let obj = self.arrayPago[indexPath.row]
                
        if indexPath.row == self.arrayPago.count - 1{
            obj.state = self.stateEdit
            cell.objBE = obj
        }else{
            obj.state = false
            cell.objBE = obj
        }
        
        cell.controller = self.controllerDetail
        
        return cell
    }
}
