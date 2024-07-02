//
//  ProfileViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

protocol IProfileViewController: AnyObject {
    func viewReady()
}

final class ProfileViewController: UIViewController {
    var presenter: IProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        presenter?.loadData()

    }
}
extension ProfileViewController : IProfileViewController {
    func viewReady() {
        //
    }
}
