//
//  WeatherTriggerPost.swift
//  Weatherly
//
//  Created by Hoang Luong on 25/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//
struct TimeParameter: Codable {
    let expression: String
    let amount: Int
}

struct Condition: Codable {
    let name: String
    let expression: String
    let amount: Int
}

struct Area: Codable {
    let type: String
    let coordinates: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}

struct WeatherTriggerPost : Codable {
    
    let timePeriod: [String: TimeParameter]
    let conditions: [Condition]
    let area: [Area]
    
    private enum CodingKeys : String, CodingKey {
        case timePeriod = "time_period"
        case conditions
        case area 
    }
    
}
