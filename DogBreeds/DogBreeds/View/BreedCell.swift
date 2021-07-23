//
//  BreedCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 21/07/21.
//

import UIKit

class BreedCell: UICollectionViewCell {
    
    var name: String? {
        didSet {
            update()
        }
    }
    
    var image: UIImage? {
        didSet {
            update()
        }
    }
    
    private func update() {
        OperationQueue.main.addOperation {
            self.setNeedsUpdateConfiguration()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        name = ""
        image = nil
    }
    
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = BreedConfiguration().updated(for: state)
        content.image = image
        content.name = name
        contentConfiguration = content
    }

}
