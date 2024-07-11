//
//  ProfileBuilder.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation

final class ProfileBuilder {
    func assembly() -> ProfileViewController {
        let viewController = ProfileViewController()
        let productService = ProductService()
        let presenter = ProfilePresenter(view: viewController, productService: productService)
        viewController.presenter = presenter
        return viewController
    }
}
