//
//  Vehicle.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import Foundation

struct VehicleData: Codable {
    
    let id: Int?
    let uid: String?
    let vin: String?
    let make_and_model: String?
    let color: String?
    let transmission: String?
    let drive_type: String?
    let fuel_type: String?
    let car_type: String?
    let car_options: [String]?
    let specs: [String]?
    let doors: Int?
    let mileage: Int?
    let kilometrage: Int?
    let license_plate: String?
    let error: String?
}
