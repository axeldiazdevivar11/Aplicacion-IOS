//
//  ViewController.swift
//  ResumesUIKit
//
//  Created by Axel Vargas Díaz de Vivar on 04/02/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.isHidden = true
       
    }

    @IBAction func coursesButtonTapped(_ sender: Any) {
        print("Button tapped")
        messageLabel.text = "Courses List"
        messageLabel.isHidden = false
       
    }
}

