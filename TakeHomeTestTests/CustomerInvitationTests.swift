//
//  CustomerInvitationTests.swift
//  TakeHomeTestTests
//
//  Created by Abhishek Srivastava on 04/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import XCTest
@testable import TakeHomeTest

class CustomerInvitationTests: XCTestCase {

    var customerInvitationViewModel = CustomerInvitationViewModel()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCustomerInfoListCount() {
        guard let customerInfoListModel = customerInvitationViewModel.getCustomerInfoListModel() else {
            XCTFail("The Data Model for the Customer Info List should not be nil")
            return
        }
        guard let customerInfoList = customerInfoListModel.customerInfoList else {
            XCTFail("The Customer Info List for the Customer Info List should not be nil")
            return
        }
        XCTAssertTrue(customerInfoList.count > 0, "The customerInfoList count should be greater then 0")
        
        XCTAssertTrue(customerInfoList.count == 32, "The customerInfoList count from the test json file should return 32 customers")

    }
    
    func testFilteredCustomerInfoListCount() {
        guard let filteredCustomerInfoList = customerInvitationViewModel.getCustomerListWithinADistance(inKM: kCustomerIn100Km) else {
            XCTFail("The Customer Info List for the Customer Info List should not be nil")
            return
        }
        XCTAssertTrue(filteredCustomerInfoList.count > 0, "The filteredCustomerInfoList count should be greater then 0")
        
        XCTAssertTrue(filteredCustomerInfoList.count == 16, "The filteredCustomerInfoList count from the test json file should return 16 customers")
    }
    
    func testIncorrectFilteredCustomerInfoListCount() {
        
        guard let incorrectFilteredCustomerInfoList = customerInvitationViewModel.getCustomerListWithinADistance(inKM: kWrongDistance) else {
            XCTFail("The Customer Info List for the Customer Info List should not be nil")
            return
        }
        
        guard let filteredCustomerInfoList = customerInvitationViewModel.getCustomerListWithinADistance(inKM: kCustomerIn100Km) else {
            XCTFail("The Customer Info List for the Customer Info List should not be nil")
            return
        }
        
        XCTAssertTrue(filteredCustomerInfoList.count != incorrectFilteredCustomerInfoList.count, "The filteredCustomerInfoList count and incorrectFilteredCustomerInfoList count from the test json file should not match")
    }
    
    func testDistanceBetweenSameSourceAndDestination(){
        let distanceBetweenSameSourceAndDestinationInMts = DistanceCalculator.haversineDinstanceInMeters(
            lat1: kDublinOfficeLat,
            long1: kDublinOfficeLong,
            lat2: kDublinOfficeLat,
            long2: kDublinOfficeLong)
        XCTAssertTrue(distanceBetweenSameSourceAndDestinationInMts == 0, "The Distance in meters between same source and destination should be same")
        
        let distanceBetweenSameSourceAndDestinationInKms = DistanceCalculator.haversineDinstanceInKiloMeters(
            lat1: kDublinOfficeLat,
            long1: kDublinOfficeLong,
            lat2: kDublinOfficeLat,
            long2: kDublinOfficeLong)
        XCTAssertTrue(distanceBetweenSameSourceAndDestinationInKms == 0, "The Distance in Kilometers between same source and destination should be same")
    }
    
    func testDistBtwnDiffSrcAndDestLongDist() {
        let distBtwnDublinToNY = DistanceCalculator.haversineDinstanceInKiloMeters(
            lat1: kDublinOfficeLat,
            long1: kDublinOfficeLong,
            lat2: kNewYorkLat,
            long2: kNewYorkLong)
        
        let deltaDistance = kDistBtwnDublinToNY - distBtwnDublinToNY
        let percentDelta = deltaDistance/kDistBtwnDublinToNY * 100
        
        XCTAssertTrue(percentDelta < 0.2, "The approximate percent difference should be less then 0.2% for long distances")
    }
    
    func testDistBtwnDiffSrcAndDestShortDist() {
        let distBtwnDublinAndLondon = DistanceCalculator.haversineDinstanceInKiloMeters(
            lat1: kDublinOfficeLat,
            long1: kDublinOfficeLong,
            lat2: kLondonLat,
            long2: kLondonLong)
        
        let deltaDistance = kDistBtwnDublinToLondon - distBtwnDublinAndLondon
        let percentDelta = deltaDistance/kDistBtwnDublinToLondon * 100
        
        XCTAssertTrue(percentDelta < 0.2, "The approximate percent difference should be less then 0.2% for short distances")
    }
    
    func testCustomerInvitationAllCustomersTextParsing() {
        let customerInvitationVC = CustomerInvitationViewController()
        customerInvitationVC.loadView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: CustomerInvitationViewController = storyboard.instantiateViewController(withIdentifier: "CustomerInvitationViewController") as? CustomerInvitationViewController else {
            XCTFail("The CustomerInvitationViewController should not be nil")
            return
        }
        _ = vc.view // To call viewDidLoad
        
        vc.getAllCustomersAction(self)
        let parsedTextVal = vc.customerListTextView.text
        let expectedTextVal = "Name: Christina McArdle, UserID: 12 \nName: Alice Cahill, UserID: 1"

        guard let containsText = parsedTextVal?.contains(expectedTextVal) else {
            XCTFail("The containsText should not be nil")
            return
        }
        
        XCTAssertTrue(containsText, "The Parsed text values should contain \(expectedTextVal)")
    }
    
    func testCustomerInvitationFilteredCustomersTextParsing() {
        let customerInvitationVC = CustomerInvitationViewController()
        customerInvitationVC.loadView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: CustomerInvitationViewController = storyboard.instantiateViewController(withIdentifier: "CustomerInvitationViewController") as? CustomerInvitationViewController else {
            XCTFail("The CustomerInvitationViewController should not be nil")
            return
        }
        _ = vc.view // To call viewDidLoad
        
        vc.getCustomersInARangeAction(self)
        let parsedTextVal = vc.customerListTextView.text
        let expectedTextVal = "Name: Ian Kehoe, UserID: 4 \nName: Nora Dempsey, UserID: 5"
        guard let containsText = parsedTextVal?.contains(expectedTextVal) else {
            XCTFail("The containsText should not be nil")
            return
        }
        XCTAssertTrue(containsText, "The Parsed text values should contain \(expectedTextVal)")
    }
}
