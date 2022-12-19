//
//  VehicleViewModel.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import Foundation

struct VehicleViewModel: Codable {
    
    let vin: String?
    let make_and_model: String?
    let color: String?
    let car_type: String?
    let error: String?
    let kilometrage: Double?
}
