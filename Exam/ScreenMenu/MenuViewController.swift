//
//  MenuViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

protocol IMenuViewController: AnyObject {
    func viewReady(work: [CategoryModel.Card], free: [CategoryModel.Card])
}

final class MenuViewController: UIViewController {
    
    private var modelWorkCategory = [CategoryModel.Card]()
    private var modelEducationCategory = [CategoryModel.Card]()
    var dataSource: CollectionDataSource?
    private lazy var collectionView: UICollectionView = settingCollectionView()

    var presenter: IMenuPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        settingMainView()
        presenter?.loadData()
    }

}


extension MenuViewController: IMenuViewController {
    func viewReady(work: [CategoryModel.Card], free: [CategoryModel.Card]) {
        modelWorkCategory = work
        modelEducationCategory = free
        reloadData()
    }
}

// MARK: Setting View

private extension MenuViewController {
    private func settingMainView() {
        view.backgroundColor = UIColor(.cyan)
        settingDataSource()
        settingLayout()
        reloadData()
    }
    
    // MARK: settingCollectionView
    func settingCollectionView() -> UICollectionView {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: settingCollectionLayout()
        )
        collection.backgroundColor = UIColor(.black)
        collection.register(
            MenuViewCell.self,
            forCellWithReuseIdentifier: "\(MenuViewCell.self)"
        )
        collection.showsVerticalScrollIndicator = false
        view.addSubview(collection)
        return collection
    }
    // MARK: Setting Layout
    func settingLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: Setting CollectionView
private extension MenuViewController {
    
    // MARK: DataSourceSnapshot
    func reloadData() {
        var snapshot = CollectionSnapShot()
        
        snapshot.appendSections([.work, .education])
        snapshot.appendItems(
            modelWorkCategory,
            toSection: .work
        )
        
        snapshot.appendItems(
            modelEducationCategory,
            toSection: .education
        )
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: DiffableDataSource
    
    func settingDataSource() {
        dataSource = CollectionDataSource(
            collectionView: collectionView,
            cellProvider: {
                collectionView,
                indexPath,
                itemIdentifier in
                
                let section = CategoryModel.Section.allCases[indexPath.section]
                switch section {
                case .work:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "\(MenuViewCell.self)",
                        for: indexPath
                    ) as! MenuViewCell
                    cell.configure(
                        title: itemIdentifier.name,
                        image: itemIdentifier.image
                    )
                    return cell
                case .education:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "\(MenuViewCell.self)",
                        for: indexPath
                    ) as! MenuViewCell

                    cell.configure(
                        title: itemIdentifier.name,
                        image: itemIdentifier.image
                    )
                    return cell
                }
            }
        )
        settingSupplementaryView()
    }
    
    // MARK: SupplementaryView
    // MARK: SupplementaryView
    func settingSupplementaryView() {
        let supplementaryRegistrationSlim = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "work") {  (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "Work"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        let supplementaryRegistrationAutor = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "education") { (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "Education"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case "work":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistrationSlim, for: indexPath)
            case "education":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistrationAutor, for: indexPath)
            default:
                return nil
            }
        }
    }
    
    // MARK: CollectionViewLayout
    func settingCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self]
            (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let section = CategoryModel.Section.allCases[sectionIndex]
            switch section {
            case .work:
                return createLayoutWork()
            case .education:
                return createLayoutEducation()
            }
        }
        return layout
    }
    
    // MARK: LayoutWork
    private func createLayoutWork() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 3),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            ),
            repeatingSubitem: item,
            count: 3
        )

        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 20,
            trailing: 8
        )

        section.interGroupSpacing = 10

        let sectionWork = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            elementKind: "work",
            alignment: .top
        )

        section.boundarySupplementaryItems = [sectionWork]

        return section
    }

    // MARK: LayoutEducation
    private func createLayoutEducation() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(107),
                heightDimension: .estimated(40)
            )
        )
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: NSCollectionLayoutSpacing.fixed(8),
            top: nil,
            trailing: nil,
            bottom: nil
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.1)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 24,
            leading: 8,
            bottom: 0,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionEducation = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            elementKind: "education",
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionEducation]
        
        return section
    }
    
}
