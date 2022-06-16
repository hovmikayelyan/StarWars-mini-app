//
//  DetailedPlanetVC.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/16/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import UIKit

class DetailedPlanetVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    func initPlanet(planet: Planet) {
        nameLabel.text = planet.name
        rotationLabel.text = planet.rotation_period
        orbitLabel.text = planet.orbital_period
        populationLabel.text = planet.population
    }

}
