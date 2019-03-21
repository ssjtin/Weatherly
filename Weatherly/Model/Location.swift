//
//  Location.swift
//  Weatherly
//
//  Created by Hoang Luong on 20/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.city == rhs.city && lhs.countryCode == rhs.countryCode
    }
    
    let city: String
    let countryCode: String
    
    init(city: String, countryCode: String) {
        self.city = city
        self.countryCode = countryCode
    }
}
