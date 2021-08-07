//
//  CountryDetailViewController.swift
//  Campeoes
//
//  Created by Douglas Frari on 8/7/21.
//

import UIKit

class CountryDetailViewController: UIViewController {

    var worldCups: [WorldCup]!
    var winner: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("- O vencedor \(String(describing: winner))")
        
        var vitoriasAcumuladas = 0
        var dadosConquistas = ""
        
        for worldCup in worldCups {
            
            // posso logica
            if winner == worldCup.winner {
                vitoriasAcumuladas += 1
                dadosConquistas += "País: \(worldCup.country) - ... \n\n"
            }
            
        }
        
        print("Vitórias: \(vitoriasAcumuladas)")
        print("Conquistas: \(dadosConquistas)")
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
