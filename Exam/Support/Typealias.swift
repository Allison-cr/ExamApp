//
//  Typealias.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import UIKit

typealias EmptyClosure = () -> Void
typealias CollectionDataSource = UICollectionViewDiffableDataSource<CategoryModel.Section, CategoryModel.Card>
typealias CollectionSnapShot = NSDiffableDataSourceSnapshot<CategoryModel.Section, CategoryModel.Card>
//typealias CollectionDataSource = UICollectionViewDiffableDataSource<CardModel.Section, CardModel.IngredientsCell>
//typealias CollectionSnapShot = NSDiffableDataSourceSnapshot<CardModel.Section, CardModel.IngredientsCell>
