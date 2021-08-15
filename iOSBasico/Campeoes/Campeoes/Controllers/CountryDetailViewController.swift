//
//  CountryDetailViewController.swift
//  Campeoes
//
//  Created by Douglas Frari on 8/7/21.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var winCountTxt: UILabel!
    @IBOutlet weak var achievementsTxt: UILabel!
    
    var worldCups: [WorldCup]!
    var winner: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flagImage.image = UIImage(named: winner)
        nameTxt.text = winner;
        winCountTxt.text = String(worldCups.count)
        
        var achievements = ""
        for worldCup in worldCups {
            
//            - México, 1986 (Argentina 3 x 2 Alemanha Ocidental)
//            - Argentina, 1978 (Argentina 3 x 1 Holanda)
            
            let final = worldCup.matches.last?.games.last
            achievements += "- \(worldCup.country), \(worldCup.year) (\(final!.home) \(final!.score) \(final!.away))\n\n"
            
        }
        achievementsTxt.text = achievements
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
