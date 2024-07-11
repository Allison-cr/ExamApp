//
//  NetworkManager .swift
//  Exam
//
//  Created by Alexander Suprun on 09.07.2024.
//

import Foundation
import RxSwift

class ProductService {
    func fetchProducts(limit: Int, offset: Int) -> Observable<[ProductModel.Product]> {
        return Observable.create { observer in
            let url = URL(string: "https://fakestoreapi.com/products?&limit=\(limit)")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        var products = try JSONDecoder().decode([ProductModel.Product].self, from: data)
                //        print("servie  limit - \(limit)  &&& koli4setrvo = \(products.count)")
               //         products = Array(products.dropFirst(offset))
                        observer.onNext(products)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
