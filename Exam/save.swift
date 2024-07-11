////
////  save.swift
////  Exam
////
////  Created by Alexander Suprun on 09.07.2024.
////
//
//import Foundation
////
////  ProfileViewController.swift
////  Exam
////
////  Created by Alexander Suprun on 02.07.2024.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//
//protocol IProfileViewController: AnyObject {
//    func appendProducts(_ products: [Product])
//}
//
//final class ProfileViewController: UIViewController {
//    var presenter: IProfilePresenter?
//    private let tableView = UITableView()
//    
//    private var products = [Product]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//        presenter?.loadData()
//    }
//    
//    private func setupTableView() {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//}
//
//extension ProfileViewController: IProfileViewController {
//    func appendProducts(_ products: [Product]) {
//        let startIndex = self.products.count
//        self.products.append(contentsOf: products)
//        let indexPaths = (startIndex..<self.products.count).map { IndexPath(row: $0, section: 0) }
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
//}
//
//extension ProfileViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return products.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
//        let product = products[indexPath.row]
//        cell.textLabel?.text = product.title
//        cell.detailTextLabel?.text = "$\(product.price)"
//        return cell
//    }
//}
//
//extension ProfileViewController: UITableViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.size.height
//        
//        if offsetY > contentHeight - height * 2 {
//            presenter?.loadNextPage()
//        }
//    }
//}
