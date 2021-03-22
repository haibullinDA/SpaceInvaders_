//
//  TutorialViewController.swift
//  SpaceInvaders
//
//  Created by Разработчик on 22.03.2021.
//

import UIKit

class TutorialViewController: UIViewController {

  
    @IBAction func backToMainMenu(_ sender: UICustomButton) {
        performSegue(withIdentifier: "backToMainMenu", sender: nil)
    }
    
    
}
