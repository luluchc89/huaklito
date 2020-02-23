//
//  RegisterUserViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 22/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {
    
    let authClient = FirebaseAuthClient()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 5
    }
    
    
    @IBAction func registerUser(_ sender: Any) {
        guard let userEmail = emailTextField.text, userEmail != "", let userPass = passwordTextField.text, userPass != "" else{
            return
        }
        authClient.createUser(email: userEmail, pass: userPass) { (auth,error) in
            if let error = error {
                let registerUserErrorAlert = UIAlertController(title: "Error al crear el usuario", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in
                    self.dismiss(animated: true, completion: nil)
                })
                registerUserErrorAlert.addAction(okAction)
                self.present(registerUserErrorAlert, animated: true, completion: nil)
            }
        }
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
