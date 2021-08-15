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
    @IBOutlet weak var generateBt: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.swLetters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        self.swNumbers.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        self.swSpecialCharacters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        self.swCaptitalLetters.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        generateBt.isEnabled = !(!swLetters.isOn && !swNumbers.isOn && !swSpecialCharacters.isOn && !swCaptitalLetters.isOn)
        generateBt.alpha = generateBt.isEnabled ? 1 : 0.5;
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let totalPass = Int(tfTotalPasswords.text ?? "0") ?? 0
        let maxChars = Int(tfNumberOfCharacters.text ?? "0") ?? 0
        var message = ""
        
        if(totalPass==0){
            message = "A quantidade de senhas deve ser superior a 0";
        }else if(totalPass > 99){
            message = "A quantidade de senhas não pode ser superior a 99";
        }else if(maxChars==0){
            message = "A quantidade de caracteres deve ser maior que 0";
        }else if(maxChars > 16){
            message = "A quantidade máxima de caracters é 16";
        }
        
        if(message != ""){
            let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
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

