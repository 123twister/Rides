//
//  RidesTests.swift
//  RidesTests
//
//  Created by Jay Kaushal on 2022-12-13.
//

import XCTest
@testable import Rides

class RidesTests: XCTestCase {
    
    var vehicleDataVC: VehicleListViewController!
    var kiloMeterTravelled = 7000.0
    var input = 67
    
    override func setUp() {
        super.setUp()
        vehicleDataVC = VehicleListViewController()
    }
    
    override func tearDown() {
        vehicleDataVC = nil
        super.tearDown()
    }
    
    //MARK: - TESTING FOR VALIDATION OF NUMBER BETWEEN 1 AND 100
    func testInputValid()
    {
        
        if ((input) < 1) || ((input) > 100)
        {
            XCTAssertFalse((input != 0))
        }
    }
    
    //MARK: - TESTING FOR THE CALCULATION OF CARBON EMISSION
    func testCalculateCarbonEmission()
    {
        if kiloMeterTravelled < 5000 {
            kiloMeterTravelled = kiloMeterTravelled * 1
            XCTAssertEqual(kiloMeterTravelled, 30000)
        }
        
        if kiloMeterTravelled > 5000
        {
            kiloMeterTravelled = kiloMeterTravelled - 5000
            kiloMeterTravelled = kiloMeterTravelled * 1.5
            kiloMeterTravelled = kiloMeterTravelled + 5000
            XCTAssertEqual(kiloMeterTravelled, 8000)
        }
 
    }
}
