//
//  ViewController+CoreData.swift
//  MyGames
//
//  Created by Douglas Frari on 8/21/21.
//

import UIKit
import CoreData

extension UIViewController {
    
    // propriedade computada que através de uma Extension permite agora que qualquer
    // objeto UIViewController conheça essa propriedade context.
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // obtem a instancia do Core Data stack
        return appDelegate.persistentContainer.viewContext
    }
}
