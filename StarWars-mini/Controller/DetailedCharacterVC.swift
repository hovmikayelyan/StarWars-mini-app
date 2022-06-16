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
    
    func initCharacter(character: Character) {
        
        NetworkService.shared.getPlanet(URL_PLANET: character.homeworld, onSuccess: { (data) in
            print("printing data")
            debugPrint(data)
            self.planet = data
            print("printing successfully name")
            
            self.worldLabel.text = self.planet!.name
        }, onError: { (errorMessage) in
            debugPrint(errorMessage)
        })

        print("printing character")
        debugPrint(character)
        
         print("printing character name")
        debugPrint(character.name)
        nameLabel.text = character.name
        
         print("printing characte r height")
        debugPrint(character.height)
         heightLabel.text = character.height
        
         print("printing character mass")
        debugPrint(character.mass)
        massLabel.text = character.mass
        
//
//
//
//        navigationItem.title = character.name
      
    }
    
    
    @IBAction func goToWorldBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "DetailedPlanetVC", sender: planet!)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedPlanetVC = segue.destination as? DetailedPlanetVC {
            let barBtn = UIBarButtonItem()
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn

            assert(sender as? Character != nil)
            detailedPlanetVC.initPlanet(planet: sender as! Planet)
        }
    }
    
}
