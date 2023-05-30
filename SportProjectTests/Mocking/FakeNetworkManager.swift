//
//  FakeNetworkManager.swift
//  SportProjectTests
//
//  Created by Mac on 25/05/2023.
//

import Foundation
@testable import SportProject
class FakeNetworkManager {
    
    var shouldReturnError : Bool
    var data : Data
    
    init(shouldReturnError: Bool, data: String) {
        self.shouldReturnError = shouldReturnError
        self.data = Data(data.utf8)
    }
    
    enum ResponseWithError:Error{
        case responseError
    }
    
    func getData<T:Decodable>(url:URL?,handler: @escaping (T?,Error?)->Void){
        if shouldReturnError{
            handler(nil,ResponseWithError.responseError)
        }
        else{
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                handler(result,nil)
            }catch let error{
                handler(nil,error)
                print(error.localizedDescription)
            }
        }
    }
}
