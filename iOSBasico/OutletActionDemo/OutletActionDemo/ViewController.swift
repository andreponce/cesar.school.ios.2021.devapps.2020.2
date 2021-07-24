//
//  ViewController.swift
//  OutletActionDemo
//
//  Created by Douglas Frari on 7/24/21.
//

import UIKit

class ViewController: UIViewController {

    // use Refactory para renomear (botao direito na variavel)
    @IBOutlet weak var labelSimNao: UILabel!
    
    
    // outlet collection example
    @IBOutlet var numeros: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func acaoSimNaoGenerica(_ sender: Any) {
        // usando Any precisa fazer cast
        if (sender as? UISwitch) != nil {
            let option = sender as! UISwitch
            if option.isOn {
                print("Ligado")
                labelSimNao.text = "Sim"
            } else {
                print("Desligado")
                labelSimNao.text = "Não"
            }
        } else {
            print("Nao é o componente esperado")
        }
    }
    
    // prefira usar uma abordagem em vez de duas para fazer a mesma coisa. No caso, recomenda-se usa essa forma e nao a generica.
    @IBAction func acaoSimNaoEspecifica(_ sender: UISwitch) {
                
        if sender.isOn {
            print("Ligado")
            labelSimNao.text = "Sim"
        } else {
            print("Desligado")
            labelSimNao.text = "Não"
        }
        
    }
    
    // usando o valor do UIButton em si (somente)
    @IBAction func numeroPressionado(_ sender: UIButton) {
        print("Valor do botão: \(sender.titleLabel?.text ?? "sem valor")")
        
    }
    
    
    // usando a propriedade Outlet Collection
    @IBAction func botaoSomar(_ sender: Any) {
        
        if sender as? UIButton == numeros[0] {
            print("Numero 1 foi pressionado")
        } else if sender as? UIButton == numeros[1] {
            print("Numero 2 foi pressionado")
        } // e assim por diante ...
        
        
    }
}

