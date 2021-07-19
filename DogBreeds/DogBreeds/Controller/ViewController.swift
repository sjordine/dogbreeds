//
//  ViewController.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 16/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let services = DogServices()
        services.breedGroups { result in
            if case let .success(groups) = result {
                print(groups.keys)
            }
        }
    }


}

