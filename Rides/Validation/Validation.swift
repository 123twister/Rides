//
//  Validation.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-17.
//

import Foundation
import UIKit

extension String {
    var isNumberValid: Bool {
        
        //1. FIRST PART RESPONDS TO THE NUMBER 1 TO 9
        //2. SECOND PART RESPONDS TO THE NUMBER 11 TO 99
        //3. THIRD PART RESPONDS TO 100
        let numberRegEx = "([1-9]|[1-9][0-9]|100)"
        
        // EVALUATING THE LOGICAL EXPRESSION
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        return numberTest.evaluate(with: self)
    }
}
