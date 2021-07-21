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
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalWidth(0.2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let globalHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
            let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: globalHeaderSize, elementKind: "header", alignment: .top)
                // Set true or false depending on the desired behavior
                globalHeader.pinToVisibleBounds = true
            
            section.boundarySupplementaryItems = [globalHeader]
            
            return section
            
        }
        
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

extension DogListViewController {
    
    private func configureDataSource() {
        

        let cellRegistration = UICollectionView.CellRegistration<BreedCell,DogBreed>(cellNib: UINib(nibName: "BreedCell", bundle: nil)) { cell, indexPath, item in
            
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
