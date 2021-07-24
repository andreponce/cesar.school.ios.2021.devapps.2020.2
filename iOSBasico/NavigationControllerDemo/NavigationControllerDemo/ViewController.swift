//
//  ViewController.swift
//  NavigationControllerDemo
//
//  Created by Douglas Frari on 7/24/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func unwindToTela1(_ unwindSegue: UIStoryboardSegue) {
        
        print("A tela foi fechada e navegado para a tela 1")
    }
    
}

