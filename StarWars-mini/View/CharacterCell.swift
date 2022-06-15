//
//  CharacterCell.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/15/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func updateCharacter(name: String) {
        nameLabel.text = name
    }

}
