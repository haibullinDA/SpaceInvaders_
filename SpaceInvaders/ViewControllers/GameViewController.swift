//
//  GameViewController.swift
//  SpaceInvaders
//
//  Created by Разработчик on 22.03.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(0)
        
    }

}
