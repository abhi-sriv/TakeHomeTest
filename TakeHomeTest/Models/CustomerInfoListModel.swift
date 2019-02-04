//
//  DataModels.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import Foundation


struct CustomerInfoListModel: Codable {
    let customerInfoList : [CustomerInfo]?
    
    enum CodingKeys: String, CodingKey {
        case customerInfoList = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerInfoList = try values.decodeIfPresent([CustomerInfo].self, forKey: .customerInfoList)
    }
}

struct CustomerInfo : Codable {
    let latitude : String?
    let user_id : Int?
    let name : String?
    let longitude : String?
    
    enum CodingKeys: String, CodingKey {
        case latitude   = "latitude"
        case user_id    = "user_id"
        case name       = "name"
        case longitude  = "longitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
    }
    
}
