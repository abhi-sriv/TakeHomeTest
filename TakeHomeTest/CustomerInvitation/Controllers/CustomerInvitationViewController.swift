//
//  CustomerInvitationViewController.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit

class CustomerInvitationViewController: UIViewController {

    let customerInvitationViewModel: CustomerInvitationViewModel = CustomerInvitationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let customerList = customerInvitationViewModel.getCustomerListModel() {
            Utilities.debugPrint(customerList as Any)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

