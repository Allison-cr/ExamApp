//
//  TESTViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 12.07.2024.
//

import UIKit

class TESTViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        label.text = "Test View Controller"
        view.addSubview(label)
        
        print("view")
    }
}
