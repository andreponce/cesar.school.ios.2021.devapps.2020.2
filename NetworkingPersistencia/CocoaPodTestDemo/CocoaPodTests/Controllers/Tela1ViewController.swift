//
//  Tela1ViewController.swift
//  CocoaPodTests
//
//  Created by Douglas Frari on 9/4/21.
//  Copyright © 2021 CESAR School. All rights reserved.
//

import UIKit
import Alamofire

class Tela1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        AF.request("https://carangas.herokuapp.com/cars").response { response in
//            debugPrint(response)
//        }
        
        AF.request("https://carangas.herokuapp.com/cars").responseJSON { response in
            
            debugPrint(response)
        }
        
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
