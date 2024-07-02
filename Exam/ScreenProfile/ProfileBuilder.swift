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
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        return viewController
    }
}
