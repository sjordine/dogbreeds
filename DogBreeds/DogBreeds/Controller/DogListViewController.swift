//
//  DogListViewController.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 19/07/21.
//

import UIKit

class DogListViewController: UIViewController {

    @IBOutlet weak var dogList: UICollectionView!
    
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, DogBreed>! = nil
    var dogServices = DogServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dogServices.breeds { result in
            if case let .success(breeds) = result {
                var snapshot = NSDiffableDataSourceSnapshot<Section, DogBreed>()
                snapshot.appendSections([.main])
                snapshot.appendItems(breeds)
                OperationQueue.main.addOperation {
                    self.dataSource.apply(snapshot, animatingDifferences: true)
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
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension DogListViewController {
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, DogBreed> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DogBreed>(collectionView: dogList) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DogBreed) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, DogBreed>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}
