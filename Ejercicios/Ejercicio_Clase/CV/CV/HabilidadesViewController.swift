//
//  HabilidadesViewController.swift
//  CV
//
//  Created by Axel Vargas Díaz de Vivar on 11/03/26.
//
import UIKit

class HabilidadesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Aparecera en la vista (vieWiLLAppear)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("La vista desaparece (vieWiLLDisarpear)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("La vista desaparecerá (vieWiLLDisarpear)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("La vista desaparece (vieWiLLDisarpear)")
    }
}
