//
//  CountriesTableViewController.swift
//  Campeoes
//
//  Created by Douglas Frari on 8/7/21.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    var worldCups: [WorldCup] = []
    var worldCupWinners: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWorldCups()
    }
    
    func loadWorldCups() {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)
        
        do {
            worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
            
            for worldCup in worldCups {
                worldCupWinners.append(worldCup.winner)
            }
            
            // usando um algoritmo para remover duplicatas:            
            worldCupWinners = unique(source: worldCupWinners)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    // Fonte: https://stackoverflow.com/questions/25738817/removing-duplicate-elements-from-an-array-in-swift
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return worldCupWinners.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
        let worldCupWinner = worldCupWinners[indexPath.row]
        
        cell.textLabel?.text = worldCupWinner
        cell.imageView?.image = UIImage(named: worldCupWinner)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // objeto selecionado pelo usuario na tabela
        let worldCup = worldCups[tableView.indexPathForSelectedRow!.row]
                
        let vc = segue.destination as? CountryDetailViewController
        vc?.worldCups = worldCups
        vc?.winner = worldCup.winner
    }
    

}
