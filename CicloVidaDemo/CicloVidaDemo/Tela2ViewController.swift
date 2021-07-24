//
//  Tela2ViewController.swift
//  CicloVidaDemo
//
//  Created by Douglas Del Frari on 23/07/21.
//

import UIKit

class Tela2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("-->> Tela2ViewController::viewDidLoad() <<-- ")
    }
    
    // ENTRANDO NA TELA (ciclo de vida da VIEW)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("-->> Tela2ViewController::viewWillAppear() <<--")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("-->> Tela2ViewController::viewDidAppear() <<--")
    }
    
    // SAINDO DA TELA (ciclo de vida da VIEW)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("-->> Tela2ViewController::viewWillDisappear() <<--")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("-->> Tela2ViewController::viewDidDisappear() <<--")
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
