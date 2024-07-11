//
//  MenuViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

protocol IMenuViewController: AnyObject {
    func viewReady(work: [CategoryModel.Card], education: [CategoryModel.Card], news: [CategoryModel.Card])
}

final class MenuViewController: UIViewController {
    
    private var modelWorkCategory = [CategoryModel.Card]()
    private var modelEducationCategory = [CategoryModel.Card]()
    private var modelNewsCategory = [CategoryModel.Card]()
    var dataSource: CollectionDataSource?
    private lazy var collectionView: UICollectionView = settingCollectionView()
    private lazy var bannerView = BannersView(items: MokData().bannerNewsModel())
    private lazy var scrollView : UIScrollView = settingScrollView()
    
    var presenter: IMenuPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        settingMainView()
        presenter?.loadData()
    }
    
}


extension MenuViewController: IMenuViewController {
    func viewReady(work: [CategoryModel.Card], education: [CategoryModel.Card], news: [CategoryModel.Card]) {
        modelWorkCategory = work
        modelEducationCategory = education
        modelNewsCategory = news
        reloadData()
    }
}

// MARK: Setting View

private extension MenuViewController {
    func settingMainView() {
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
        collection.backgroundColor = UIColor(.white)
        collection.register(
            MenuViewCell.self,
            forCellWithReuseIdentifier: "\(MenuViewCell.self)"
        )
        collection.showsVerticalScrollIndicator = false
        view.addSubview(collection)
        return collection
    }
    
    func settingScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        return scrollView
    }
    
    
    // MARK: Setting Layout
    func settingLayout() {


//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
            
        view.addSubview(bannerView)
        view.addSubview(collectionView)
              

        bannerView.snp.makeConstraints {
              $0.top.equalToSuperview().offset(32)
              $0.leading.trailing.equalTo(view)
              $0.height.equalTo(200)
          }
              
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: Setting CollectionView
private extension MenuViewController {
    
    // MARK: DataSourceSnapshot
    func reloadData() {
        var snapshot = CollectionSnapShot()
        
        snapshot.appendSections([.work, .education, .news])
        
        snapshot.appendItems(
            modelNewsCategory,
            toSection: .news
        )
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
                case .news:
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
    func settingSupplementaryView() {
        let supplementaryWork = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "work") {  (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "Work"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        
        let supplementaryNews = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "news") {  (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "News"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        let supplementaryEducation = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "education") { (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "Education"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case "work":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryWork, for: indexPath)
            case "education":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryEducation, for: indexPath)
            case "news":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryNews, for: indexPath)

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
            case .news:
                return createLayoutNews()
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
                heightDimension: .fractionalHeight(0.4)
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

    // MARK: LayoutNews
    private func createLayoutNews() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.9)
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
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalHeight(0.3)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
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
            elementKind: "news",
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionEducation]
        
        return section
    }
    
    // MARK: LayoutEducation
    private func createLayoutEducation() -> NSCollectionLayoutSection {
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
            elementKind: "education",
            alignment: .top
        )

        section.boundarySupplementaryItems = [sectionWork]

        return section
    }
}
