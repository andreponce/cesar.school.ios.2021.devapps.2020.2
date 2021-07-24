//
//  ViewController.swift
//  NavegacaoTelaDemo
//
//  Created by Douglas Del Frari on 23/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func proximaTela(_ sender: Any) {
        // temos que declarar na configuracao da propriedade da segue um valor, neste caso 'proximaTela' foi usado.
        performSegue(withIdentifier: "proximaTela", sender: nil)
    }
    
    @IBAction func unwindTela1(segue: UIStoryboardSegue) {
        print("--> unwindTela1 (( segue para voltar para tela 1 )) <<--")
    }
    
}

