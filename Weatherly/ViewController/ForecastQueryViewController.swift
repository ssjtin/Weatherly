//
//  ForecastQueryViewController.swift
//  Weatherly
//
//  Created by Hoang Luong on 25/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class ForecastQueryViewController: UIViewController {
    
    let apiManager = WeatherAPIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let post = createWeatherTriggerPost()
        let triggerJson = try! convertPostToJsonData(object: post)
        
        apiManager.createTrigger(using: triggerJson)
    }
    
    func convertPostToJsonData(object: Encodable) throws -> Data  {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(object as! WeatherTriggerPost)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
            return jsonData
        } catch let error {
            throw(error)
        }
        
    }
    
    func createWeatherTriggerPost() -> WeatherTriggerPost {
        let start = getCurrentTimestamp()
        let end = start + (60 * 60)
        let startParameter = TimeParameter(expression: "after", amount: start)
        let endParameter = TimeParameter(expression: "after", amount: end)
        
        let condition = Condition(name: "temp", expression: "$gt", amount: 25)
        let area = Area(type: "Point", coordinates: [27, 153])
        
        let trigger = WeatherTriggerPost(timePeriod: ["start": startParameter, "end": endParameter],
                                         conditions: [condition],
                                         area: [area])
        
        return trigger
        
    }
    
    func getCurrentTimestamp() -> Int {
        let timeInterval = Date().timeIntervalSince1970
        return Int(timeInterval)
    }
    
}
