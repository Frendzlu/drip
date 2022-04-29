//
//  ViewController.swift
//  drip
//
//  Created by Mateusz Francik on 29/04/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let result = Utils.checkPESEL("04222911339")
        print(result)
    }

}

