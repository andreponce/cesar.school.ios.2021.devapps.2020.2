//
//  WinnerTableViewCell.swift
//  Campeoes
//
//  Created by Andre Ponce on 15/08/21.
//

import UIKit

class WinnerTableViewCell: UITableViewCell {
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    
    func prepare(countryName :String) {
        self.flagImage.image = UIImage(named: countryName)
        self.nameTxt.text = countryName
    }
}
