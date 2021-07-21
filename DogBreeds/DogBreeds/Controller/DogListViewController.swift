//
//  DogListViewController.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 19/07/21.
//

import UIKit

class DogListViewController: UIViewController {
    
    @IBOutlet weak var dogList: UICollectionView!
    
    
    var dataSource: UICollectionViewDiffableDataSource<String, DogBreed>! = nil
    var dogServices = DogServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dogServices.breedGroups { [self] result in
            if case let .success(breedGroups) = result {
                var snapshot = NSDiffableDataSourceSnapshot<String, DogBreed>()
                snapshot.appendSections(Array<String>(breedGroups.keys))
                for group in breedGroups.keys {
                    let breeds = breedGroups[group] ?? []
                    snapshot.appendItems(breeds, toSection: group)
                }
                OperationQueue.main.addOperation {
                    dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
        }
        
    }
    
}

extension DogListViewController {
    private func configureHierarchy() {
        dogList.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .supplementary
        
        var layout =  UICollectionViewCompositionalLayout.list(using: config)
    
        return layout
    }
}

extension DogListViewController {
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, DogBreed> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
        }
        
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderCell>(supplementaryNib: UINib(nibName: "HeaderCell", bundle: nil), elementKind: "header") { (supplementaryView, sectionName, indexPath) in
            
            let identifiers = self.dataSource.snapshot().sectionIdentifiers
            
            
            supplementaryView.groupTitle.text = identifiers[indexPath.section]

        }
        
        
        dataSource = UICollectionViewDiffableDataSource<String, DogBreed>(collectionView: dogList) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DogBreed) -> UICollectionViewCell? in
            
            
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.dogList.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<String, DogBreed>()
        snapshot.appendSections([])
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}
