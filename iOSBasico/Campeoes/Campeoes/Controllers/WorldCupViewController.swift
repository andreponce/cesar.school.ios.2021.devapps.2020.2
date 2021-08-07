//
//  WorldCupViewController.swift
//  Campeoes
//
//  Created by Douglas Frari on 7/24/21.
//

import UIKit

class WorldCupViewController: UIViewController {

    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lbVice: UILabel!
    
    // somente precisamos adicionar quando o componente for adicionado sobre uma tela UIViewController
    @IBOutlet weak var tableView: UITableView!
    
    // vai recever o objeto que o usuario escolheu na selecao da tableview
    var worldCup: WorldCup!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WorldCup \(worldCup.year)"

        ivWinner.image = UIImage(named: worldCup.winner)
        ivVice.image = UIImage(named: worldCup.vice)
        lbScore.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
        lbWinner.text = worldCup.winner
        lbVice.text = worldCup.vice
        
        
        // registrando programaticamente a tableview para suportar o dataSource e delegate
        // Comantamos porque fizemos o registro usando o Storyboard
        //tableView.dataSource = self
        //tableView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // fim da classe


extension WorldCupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // total de secoes disponiveis
        return worldCup.matches.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // numero de linhas para a secao
        return worldCup.matches[section].games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // recuperando o Game que se encontra em algum Match (oitavas de final, quartas, semi...)
        let match = worldCup.matches[indexPath.section]
        let game = match.games[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        cell.printCellValues(with: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // obter um nome para secao
        let match = worldCup.matches[section]
        return match.stage // stage representa a string que é o titulo da secao
    }
    
}
