//
//  ViewController.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/14/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import UIKit

class CharactersVC: UIViewController {

    var characters = Array<Character>()
    var filteredCharacters = Array<Character>()
    
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTable.dataSource = self
        charactersTable.delegate = self
        charactersTable.isHidden = true
        
        activityIndicator.startAnimating()
        
        setupSearchBar()
        getAllCharacters()
    }

    func getAllCharacters() {
        NetworkService.shared.getCharactersByPage(page: 1, onSuccess: { (data) in
            self.characters.append(contentsOf: data.results)
        }, onError: { (errorMessaage) in
            debugPrint(errorMessaage)
        })
        
        self.filteredCharacters = self.characters
        self.activityIndicator.stopAnimating()
        self.charactersTable.isHidden = false
        self.charactersTable.reloadData()
    }


}

extension CharactersVC: UISearchBarDelegate {
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters.removeAll()
        
        characters.forEach({
            if $0.name.lowercased().contains(searchText.lowercased()) || searchText.count == 0 {
                filteredCharacters.append($0)
            }
        })
        
        charactersTable.reloadData()
    }
}

extension CharactersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell
        else {
            return UITableViewCell()
        }
        cell.updateCharacter(name: filteredCharacters[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = filteredCharacters[indexPath.row]
        performSegue(withIdentifier: "DetailedCharacterVC", sender: details)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedCharacterVC = segue.destination as? DetailedCharacterVC {
            let barBtn = UIBarButtonItem()
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn
            
            assert(sender as? Character != nil)
            detailedCharacterVC.setupCharacter(character: sender as! Character)
        }
    }
    
}
