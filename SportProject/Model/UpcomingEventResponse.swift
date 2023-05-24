//
//  UpcomingEventResponse.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation

class UpcomingEventResponse : Decodable{
    var success:Int?
    var result:[UpcomingEvent]?
    init(success: Int? = nil, result: [UpcomingEvent]? = nil) {
        self.success = success
        self.result = result
    }
}
