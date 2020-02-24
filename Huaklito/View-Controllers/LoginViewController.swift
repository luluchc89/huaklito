//
//  LoginViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 22/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let authClient = FirebaseAuthClient()
    var isUserLogged : Bool?
    
    //Auxiliar variables to pass order data to ConfirmationOrderViewController
    var productsToBuy : [ProductInKart]?
    var imagesOfProductsToBuy : [UIImage]?
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogged()
    }
    
    @IBAction func authenticate(_ sender: Any) {
        guard let userEmail = emailTextView.text, userEmail != "", let userPass = passwordTextField.text, userPass != "" else{
            return
        }
        authClient.signIn(email: userEmail, password: userPass) { error in
            if let error = error {
                let errorAlert = UIAlertController(title: "Error al iniciar sesión", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in
                    self.dismiss(animated: true, completion: nil)
                })
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "checkoutOrder", sender: self)
            }
        }
    }
    
    func isLogged(){
        authClient.isLogged { data in
            if data != nil{
                self.performSegue(withIdentifier: "checkoutOrder", sender: self)
            }
        }
    }
    

     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            ConfirmOrderViewController {
            destination.productsToBuy = self.productsToBuy
            destination.imagesOfProductsToBuy = self.imagesOfProductsToBuy
            destination.userEmail = authClient.getCurrentUser()
        }
    }
    

}
