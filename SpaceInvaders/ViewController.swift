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
    @IBAction func showPlayViewController(_ sender: UICustomButton) {
        let storyBoard = UIStoryboard(name: "Main",bundle: nil)
        let playViewController = storyBoard.instantiateViewController(identifier: "PlayViewController")
        show(playViewController, sender: self)
    }
    
    @IBAction func showTutorialViewController(_ sender: UICustomButton) {
        let storyBoard = UIStoryboard(name: "Main",bundle: nil)
        let tutorialViewController = storyBoard.instantiateViewController(identifier: "TutorialViewController")
        show(tutorialViewController, sender: self)
    }
    @IBAction func closeTutorialViewController(_ sender: UICustomButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

