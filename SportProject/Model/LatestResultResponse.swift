//
//  LatestResultResponse.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation
class LatestResultResponse:Decodable{
    var success:Int?
    var result:[LatestResult]?
}
