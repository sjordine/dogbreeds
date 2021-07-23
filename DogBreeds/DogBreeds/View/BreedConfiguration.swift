//
//  BreedCellConfiguration.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/07/21.
//

import Foundation
import UIKit

struct BreedConfiguration: UIContentConfiguration, Hashable {
    
    func makeContentView() -> UIView & UIContentView {
        return BreedView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> BreedConfiguration {
        guard let state = state as? UICellConfigurationState else { return self }
        var newConfig =  BreedConfiguration()
        newConfig.image = image
        newConfig.name = name
        return newConfig
    }
    
    var image: UIImage? = nil
    var name:String? = nil
}
