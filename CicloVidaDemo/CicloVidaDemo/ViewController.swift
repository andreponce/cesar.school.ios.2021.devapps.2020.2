//
//  ViewController.swift
//  CicloVidaDemo
//
//  Created by Douglas Del Frari on 23/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("-->> ViewController::viewDidLoad() <<--")
    }
    
    // ENTRANDO NA TELA (ciclo de vida da VIEW)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("-->> ViewController::viewWillAppear() <<--")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        print("-->> ViewController::viewDidAppear() <<--")
    }
    
    // SAINDO DA TELA (ciclo de vida da VIEW)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("-->> ViewController::viewWillDisappear() <<--")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("-->> ViewController::viewDidDisappear() <<--")
    }


}

