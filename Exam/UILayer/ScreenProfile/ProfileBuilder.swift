//
//  ProfileBuilder.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

final class ProfileBuilder {
    func assembly() -> ProfileViewController {
        let viewController = ProfileViewController()
        let productService = ProductService()
        let presenter = ProfilePresenter(view: viewController, productService: productService)
        let coordinator = ProfileCoordinator(navigationController: UINavigationController())
        presenter.coordinator = coordinator
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
