//
//  LoginViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 10/07/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak private var clvUser : UICollectionView!
    
    private var arrayUser = [UserBE](){
        didSet{
            self.clvUser.reloadSections(IndexSet(arrayLiteral: 0))
        }
    }
    
    private var indexSelect = 0
    
    lazy private var refreshControll : UIRefreshControl! = {
       
        var objRefreshControl = UIRefreshControl()
        objRefreshControl.tintColor = .darkGray
        objRefreshControl.addTarget(self, action: #selector(self.loadLogin), for: .valueChanged)
        return objRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvUser.backgroundView = self.refreshControll
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.indexSelect = 0
        self.loadLogin()
    }
    
    @IBAction private func showAdmin(_ sender : Any?){
        self.eventAdmin()
    }

    @IBAction private func refreshLoad(_ sender : Any?){
        self.loadLogin()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? AdminViewController{
            controller.delegate = self
        }else if let controller = segue.destination as? HomeViewController{
            controller.objUser = sender as! UserBE
        }else if let controller = segue.destination as? SecurityViewController{
            controller.delegate = self
            controller.objUser = sender as! UserBE
        }
    }

}

//MARK: - Methods

extension LoginViewController {
    
    @objc private func loadLogin(){
        self.arrayUser.removeAll()
        
        if let _ = CDLicencia.listarTodos().first{
            self.animateLoad(show: true)
            UserBL.getUser { array in
                self.animateLoad(show: false)
                self.arrayUser = array
            } errorServices: { error in
                self.animateLoad(show: false)
                self.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton, withCompletion: nil)
            }
        }else{
            
        }
    }
    
    private func animateLoad(show : Bool){
        show ? self.refreshControll.beginRefreshing() : self.refreshControll.endRefreshing()
        self.view.isUserInteractionEnabled = !show
    }
    
    private func eventAdmin(){
        
        self.indexSelect += 1
        
        switch self.indexSelect {
        
        case 10:
            self.indexSelect = 0
            self.performSegue(withIdentifier: Segue.AdminViewController, sender: nil)            
        default:
            return
        }
    }
}

//MARK: -ProtocolDelegate AdminPopApp - Security Code
extension LoginViewController : AdminViewControllerDelegate, SecurityViewControllerDelegate{
    
    func reiniciarApp(controller: AdminViewController, state: Bool) {
        
        if state{
            self.navigationController?.popViewController(animated: true)
        }else{
            
        }
    }
    
    func showHome(_ controller: SecurityViewController, codigo: Any?) {
        
        if let data = codigo as? UserBE{
            
            CDUsuario.save(user: data)
            
            self.navigationController?.popToRootViewController(animated: true)
        }else{
         
            
        }
    }
    
}


//MARK: -CollectionView
extension LoginViewController  : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = CellIdentifier.LoginCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! LoginCollectionViewCell
        
        cell.objBE = self.arrayUser[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfElements: CGFloat = 2
        let widthCell = (UIScreen.main.bounds.size.width - (numberOfElements + 1)*10) / numberOfElements
        let heightCell = widthCell - 80
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.arrayUser[indexPath.row]
        self.performSegue(withIdentifier: Segue.SecurityViewController, sender: obj)
    }
}
