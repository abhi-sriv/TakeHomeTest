//
//  CustomerInvitationViewController.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit
import CoreLocation

class CustomerInvitationViewController: UIViewController {

    let customerInvitationViewModel: CustomerInvitationViewModel = CustomerInvitationViewModel()
    
    @IBOutlet var customerListTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func getAllCustomersAction(_ sender: Any) {
        if let customersModel = customerInvitationViewModel.getCustomerInfoListModel(), let customersList = customersModel.customerInfoList {
            customerListTextView.text = ""
            for customerInfo in customersList {
                customerListTextView.text = customerListTextView.text + String("Name: \(customerInfo.name ?? "Unknown"), UserID: \(String(customerInfo.user_id ?? 0)) \n")
            }
        }
    }
    
    @IBAction func getCustomersInARangeAction(_ sender: Any) {
        if let customersList = customerInvitationViewModel.getCustomerListWithinADistance(inKM: kCustomerIn100Km) {
            customerListTextView.text = ""
            for customerInfo in customersList {
                customerListTextView.text = customerListTextView.text + String("Name: \(customerInfo.name ?? "Unknown"), UserID: \(String(customerInfo.user_id ?? 0)) \n")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

