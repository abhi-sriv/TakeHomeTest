//
//  CustomerInvitationViewModel.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit

class CustomerInvitationViewModel: NSObject {

    private var customerListModel: CustomerListModel?
    
    required override init() {
        super.init()
        self.getCustomerList()
    }
    
    private func getCustomerList() {
        if let jsonData = Utilities.getDataFromJSONFile(forResource: "test", ofType: "json") {
            let jsonDecoder = JSONDecoder()
            do
            {
                self.customerListModel = try jsonDecoder.decode(CustomerListModel.self, from: jsonData)
                Utilities.debugPrint(self.customerListModel as Any)
            } catch {
                Utilities.debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getCustomerListModel() -> CustomerListModel? {
        return self.customerListModel
    }
    
}
