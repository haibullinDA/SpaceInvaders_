//
//  ViewController.swift
//  SpaceInvaders
//
//  Created by Разработчик on 17.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func showTutorialViewController(_ sender: UICustomButton) {
        performSegue(withIdentifier: "showTutorialViewController", sender: nil)
    }
    
    @IBAction func showGameViewController(_ sender: UICustomButton) {
        performSegue(withIdentifier: "showGameViewController", sender: nil)
    }
    
    @IBAction func unwindSegueToMainMenu(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindSegueToMainMenuTwo(segue: UIStoryboardSegue){
        
    }
}

