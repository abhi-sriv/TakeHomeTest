//
//  Utilities.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    class func getDataFromJSONFile(forResource name: String?, ofType ext: String?) ->  Data? {
        if let path = Bundle.main.path(forResource: name, ofType: ext) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
//                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            } catch {
                // handle error
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func debugPrint(_ data: Any) {
        if isDevelopement { print(data) }
    }
}
