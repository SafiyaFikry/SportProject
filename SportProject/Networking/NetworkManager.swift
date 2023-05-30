//
//  NetworkManager.swift
//  SportProject
//
//  Created by Mac on 20/05/2023.
//

import Foundation
import Alamofire
protocol NetworkService{
    func getData<T:Decodable>(url:URL,handler: @escaping (T?,Error?)->Void)
}
class NetworkManager:NetworkService{
    
    func getData<T:Decodable>(url:URL,handler: @escaping (T?,Error?)->Void){
        
        let request = AF.request(url)
            request.responseDecodable(of:T.self) { response in
            guard let res = response.value else{
                return
            }
            handler(res,response.error)
        }
    }
}

