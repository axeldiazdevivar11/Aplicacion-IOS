//
//  ExperienciaLaboralViewController.swift
//  CV
//
//  Created by Axel Vargas Díaz de Vivar on 11/03/26.
//
import UIKit

class ExperienciaLaboralViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var buttonClickme:
        UIButton!
    
    var contador = 0
    
    @IBAction func increment(_sender:
                             UIButton) {
        contador += 1
        print("Conrtador: \(contador)")
        buttonClickme
            .setTitle("\(contador)", for: .normal)
    }
        
}

