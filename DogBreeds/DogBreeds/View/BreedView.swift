//
//  BreedView.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/07/21.
//

import UIKit


class BreedView:UIView, UIContentView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    private var appliedConfiguration: BreedConfiguration! = BreedConfiguration()
    private let xibName: String = "BreedView"
    private var contentView: UIView!
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? BreedConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    init(configuration: BreedConfiguration) {
        super.init(frame: .zero)
        xibSetup()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func xibSetup() {
        loadXib(targetView: &contentView, xibName: xibName)
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10.0
    }
    
    private func apply(configuration: BreedConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        title.text  = appliedConfiguration.name
        image.image = appliedConfiguration.image ?? UIImage(named: "placeholder")
    }
}
