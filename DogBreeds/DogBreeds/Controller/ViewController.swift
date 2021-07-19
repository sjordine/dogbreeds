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
        services.breeds { result in
            if case let Result.success(breeds) = result {
                let result = Dictionary.init(grouping: breeds, by: { breed in
                    breed.group
                })
                print(result.keys)
            }
           
        }
    }


}

