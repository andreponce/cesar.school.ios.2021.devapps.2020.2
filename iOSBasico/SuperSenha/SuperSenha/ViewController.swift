//
//  ViewController.swift
//  SuperSenha
//
//  Created by Douglas Frari on 8/7/21.
//

import UIKit

class ViewController: UIViewController {

    // Outlets necessarios:
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PasswordViewController
        
        // forma mais segura (usar if let)
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            // se conseguir obter o valor do campo e converter para inteiro
            vc.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            vc.numberOfCharacters = numberOfCharacters
        }
        vc.useNumbers = swNumbers.isOn
        vc.useCapitalLetters = swCaptitalLetters.isOn
        vc.useLetters = swLetters.isOn
        vc.useSpecialCharacters = swSpecialCharacters.isOn
        
        // forcar encerrar o modo de edicao // remove o foco e libera teclado
        view.endEditing(true)
        
        //view.becomeFirstResponder() // para fechar o teclado
        
    }

}

