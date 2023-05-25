//
//  ViewController.swift
//  API_Http_Post_Method_Simple
//
//  Created by Mac on 16/05/23.
//
/*
struct AddProduct: Encodable{
    let title: String
    let userId: Int
}

struct RecivedProductResponse: Decodable{
    let id: Int
    let title: String
    let userId: Int
}
*/

struct AddProductResponse: Codable{
    var id: Int? = nil
    let title: String
    let userId: Int
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        addProduct()
    }

    func addProduct(){
        guard let url = URL(string: "https://dummyjson.com/posts/add") else{
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [ "Content-Type": "application/json" ]
        let parameter = AddProductResponse(title: "Vivek Dress", userId: 24)
        let data = try? JSONEncoder().encode(parameter)
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                print("invalid data")
                return
            }
            do{
                let productAddResponse = try JSONDecoder().decode(AddProductResponse.self, from: data)
                print(productAddResponse)
            }
            catch let err{
                print(err)
            }
        }.resume()
    }
}

