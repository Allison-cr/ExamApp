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
typealias ProductCollectionDataSource = UICollectionViewDiffableDataSource<ProductModel.Section, ProductModel.Product>
typealias ProductCollectionSnapShot = NSDiffableDataSourceSnapshot<ProductModel.Section, ProductModel.Product>
