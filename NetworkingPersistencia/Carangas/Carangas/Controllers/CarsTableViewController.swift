//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    var cars: [Car] = []
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Carregando carros..."

        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCars()
    }
    
    // usamos o @objc para o #selector ser reconhecido
    @objc func loadCars() {
        
        REST.loadCars { cars in
            
            self.cars = cars
            
            // precisa recarregar a tableview usando a main UI thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
            
        } onError: { error in
            
            var response: String = ""
            
            switch error {
                case .invalidJSON:
                    response = "invalidJSON"
                case .noData:
                    response = "noData"
                case .noResponse:
                    response = "noResponse"
                case .url:
                    response = "JSON inválido"
                case .taskError(let error):
                    response = "\(error.localizedDescription)"
                case .responseStatusCode(let code):
                    if code != 200 {
                        response = "Algum problema com o servidor. :( \nError:\(code)"
                    }
            }
            
            print(response)
                        
            DispatchQueue.main.async {
                // mostrar mensagem de erro quando ocorrer algum problema
                self.label.text = "Ocorreu um erro no servidor\n\n\(response)"
                self.tableView.backgroundView = self.label
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = cars.count
        
        if count == 0 {
            // mostrar mensagem padrao
            self.tableView.backgroundView = self.label
        } else {
            self.tableView.backgroundView = nil
        }
        
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 1
            let car = cars[indexPath.row]
            REST.delete(car: car) { (success) in
                if success {
                    // ATENCAO nao esquecer disso
                    self.cars.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        // Delete the row from the data source
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                } else {
                    print("Não foi possível deletar do servidor esse carro.")
                }
            }onError: { error in
                self.showError(error: error)
            }
        }
    }
    

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
        
        if segue.identifier == "viewSegue" {
            
            let vc = segue.destination as! CarViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                vc.car = cars[row]
            }
        }
        
    }
    

}
