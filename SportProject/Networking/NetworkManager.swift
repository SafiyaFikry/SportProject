//
//  NetworkManager.swift
//  SportProject
//
//  Created by Mac on 20/05/2023.
//

import Foundation
import Alamofire
protocol NetworkService{
    func getLeagues<T:Decodable>(url:URL,handler: @escaping (T?)->Void)
}
class NetworkManager:NetworkService{
    
    func getLeagues<T:Decodable>(url:URL,handler: @escaping (T?)->Void){
//        let request = AF.request(url)
//            request.response { response in
//            switch response.result{
//            case .success(let data):
//                do{
//                    let result = try JSONDecoder().decode(T.self,from: data!)
//                    handler(result)
//                }catch let error{
//                    print(error.localizedDescription)
//                    handler(nil)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        }
        
        let request = AF.request(url)
            request.responseDecodable(of:T.self) { response in
            guard let res = response.value else{
                print("hello")
                return
            }
            handler(res)
        }
    }
}

