//
//  UIViewController+Error.swift
//  Carangas
//
//  Created by Andre Ponce on 01/10/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(error :CarError){
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
                    
        let alert = UIAlertController(title: "Erro", message: "Houve um erro inesperado, por favor tente novamente.", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}


