//
//  OpenWeatherService.swift
//  Weatherly
//
//  Created by Hoang Luong on 20/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    
    let API_KEY = "b41b82226c7f41fca9f216684bda70cd"
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q="
    let TRIGGER_URL = "http://api.openweathermap.org/data/3.0/triggers"
    let ICON_BASE_URL = "http://openweathermap.org/img/w/"
    
    func fetchCurrentWeatherData(city: String, countryIsoCode: String, completion: @escaping (WeatherData?) ->()) {
        
        let url = BASE_URL + city + "," + countryIsoCode + "&appid=" + API_KEY + "&units=Metric"
        
        let request = AF.request(url, method: .get).validate().responseJSON { (response) in
            guard response.result.isSuccess, let value = response.result.value else { completion(nil); return }
            
            let json = JSON(value)
            guard let main = json["weather"][0]["main"].string,
                let description = json["weather"][0]["description"].string,
                let temp = json["main"]["temp"].int,
                let iconString = json["weather"][0]["icon"].string
                else { completion(nil); return }
            
            let weatherData = WeatherData(main: main, description: description, temp: temp, iconUrl: self.ICON_BASE_URL+iconString+".png")
            completion(weatherData)
        }
        request.resume()
    }
    
    func createTrigger(using jsonData: Data) {
        
        let url = TRIGGER_URL + "?appid=" + API_KEY
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = jsonData

        
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let value = JSON(value)
                print(value)
            case .failure(let error):
                print("Alamofire response return\(error.localizedDescription)")
            }
        }
    
        
        
    }
}
