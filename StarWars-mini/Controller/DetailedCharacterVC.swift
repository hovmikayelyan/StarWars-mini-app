//
//  DetailedCharacterVC.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/15/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import UIKit

class DetailedCharacterVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var worldLabel: UILabel!
    
    var planet: Planet?
    
    func setupCharacter(character: Character) {
        NetworkService.shared.getPlanet(URL_PLANET: character.homeworld, onSuccess: { (data) in
            self.planet = data
            self.worldLabel.text = self.planet?.name
        }, onError: { (errorMessage) in
            debugPrint(errorMessage)
        })
        
        nameLabel.text = character.name
        heightLabel.text = character.height
        massLabel.text = character.mass
    }

}
