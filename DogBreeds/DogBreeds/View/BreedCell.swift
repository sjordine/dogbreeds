//
//  BreedCell.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 21/07/21.
//

import UIKit

class BreedCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        self.image.image = UIImage(named: "placeholder")
    }
    

}
