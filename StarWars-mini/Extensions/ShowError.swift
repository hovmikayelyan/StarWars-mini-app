//
//  ShowError.swift
//  StarWars-mini
//
//  Created by Hovhannes Mikayelyan on 6/14/22.
//  Copyright © 2022 Hovhannes Mikayelyan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(_ message: String, onIgnore: @escaping ()->()) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ignoreAction = UIAlertAction(title: "Ignore", style: .default) { action in
            onIgnore()
        }
        let tryAgainAction = UIAlertAction(title: "Try again later", style: .default)
        alertVC.addAction(ignoreAction)
        alertVC.addAction(tryAgainAction)
        present(alertVC, animated: true)
    }
    
}
