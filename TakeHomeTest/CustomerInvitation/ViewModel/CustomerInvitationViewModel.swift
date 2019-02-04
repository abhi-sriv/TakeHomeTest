//
//  CustomerInvitationViewModel.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit

class CustomerInvitationViewModel: NSObject {
    
    private var customerListModel: CustomerInfoListModel?
    
    required override init() {
        super.init()
        self.getCustomerList()
    }
    
    private func getCustomerList() {
        if let jsonData = Utilities.getDataFromJSONFile(forResource: "test", ofType: "json") {
            let jsonDecoder = JSONDecoder()
            do {
                self.customerListModel = try jsonDecoder.decode(CustomerInfoListModel.self, from: jsonData)
                Utilities.debugPrint(self.customerListModel as Any)
            } catch {
                Utilities.debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getCustomerInfoListModel() -> CustomerInfoListModel? {
        return self.customerListModel
    }
    
    func getCustomerListWithinADistance(inKM: Double) -> [CustomerInfo]? {
        if let customerList: CustomerInfoListModel = self.getCustomerInfoListModel() {
            Utilities.debugPrint(customerList as Any)
            let filteredList = customerList.customerInfoList?.filter({
                if let latStr = $0.latitude, let longStr = $0.longitude, let lat2 = Double(latStr), let long2 = Double(longStr)  {
                    return DistanceCalculator.haversineDinstanceInKiloMeters(lat1: kDublinOfficeLat, long1: kDublinOfficeLong, lat2: lat2, long2: long2) <= inKM
                }
                return false
            }).sorted(by: { (customer1, customer2) -> Bool in
                
                // SORTING logic can be passed as a parameter in the getCustomerListWithinADistance function if required
                
                if let userID1 = customer1.user_id, let userID2 = customer2.user_id {
                    return userID1 < userID2
                }
                return false
            })
            Utilities.debugPrint(filteredList as Any)
            return ((filteredList?.count ?? 0) > 0) ? filteredList : nil
        }
        return nil
    }
    
}
