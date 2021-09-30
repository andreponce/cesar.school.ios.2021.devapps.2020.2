//
//  ConsolesManager.swift
//  MyGames
//
//  Created by Douglas Frari on 8/21/21.
//

import CoreData

class ConsolesManager {
    
    // usando Singleton
    static let shared = ConsolesManager()
    
    var consoles: [Console] = []
    
    
    func loadConsoles(with context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
        
        // usamos o atributo que foi definido no arquivo da entidade Console
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            // isso é equivalente a query do SQL (select * from Console)
            consoles = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteConsole(index: Int, context: NSManagedObjectContext) {
        let console = consoles[index]
        context.delete(console)
        
        do {
            try context.save()
            consoles.remove(at: index)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    // Singleton design patters
    private init() {
        
    }
}
