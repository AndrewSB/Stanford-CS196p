//
//  StringExtension.swift
//  Calculator
//
//  Created by Andrew Breckenridge on 5/19/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}