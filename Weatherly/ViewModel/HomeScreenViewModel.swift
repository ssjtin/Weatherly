//
//  UserLocationViewModel.swift
//  Weatherly
//
//  Created by Hoang Luong on 20/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import RxCocoa
import RxSwift

class HomeScreenViewModel  {
    
    //Services
    let userLocationManager = UserLocationManager()
    let weatherAPIManager = WeatherAPIManager()
    
    //Date and time properties
    var timer: Timer!
    var dateString = BehaviorRelay<String?>(value: nil)
    var timeString = BehaviorRelay<String?>(value: nil)

    //Location properties
    var locationString = BehaviorRelay<String?>(value: nil)
    
    //Weather data properties
    var weatherBackgroundImage = BehaviorRelay<UIImage?>(value: nil)
    var weatherDescription = BehaviorRelay<String?>(value: nil)
    var weatherDescriptionIcon = BehaviorRelay<UIImage?>(value: nil)
    var temperature = BehaviorRelay<String?>(value: nil)
    
    var isFetchingWeatherData = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    //Init
    init() {
        userLocationManager.delegate = self
        userLocationManager.getLocation()
        configureTimer()
    }
    
    deinit {
        timer.invalidate()
    }
    
    func fetchWeatherData(city: String, countryCode: String) {
        
        isFetchingWeatherData.accept(true)
        weatherAPIManager.fetchCurrentWeatherData(city: city, countryIsoCode: countryCode) { [unowned self](data) in
            guard let weatherData = data else { return }
            
            self.weatherBackgroundImage.accept(UIImage(named: "\(weatherData.main.lowercased())Background"))
            self.weatherDescription.accept(weatherData.description)
            self.temperature.accept("\(String(weatherData.temp))\u{00b0}C")
            
            ImageDownloadManager.requestImageDownload(with: weatherData.iconUrl, completion: { (image) in
                self.weatherDescriptionIcon.accept(image)
            })
        }
    }
    
    private func configureTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDateAndTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateDateAndTime() {
        
        let date = Date()
        let dateAsString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        let timeAsString = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: DateFormatter.Style.medium)
        
        print(dateAsString)
        print(timeAsString)
        
        if self.dateString.value != dateAsString {
            self.dateString.accept(dateAsString)
        }
        
        if self.timeString.value != timeAsString {
            self.timeString.accept(timeAsString)
        }
    }
    
}

extension HomeScreenViewModel: UserLocationManagerProtocol {
    
    func updateLocation(city: String, countryIsoCode: String) {
        print(city)
        locationString.accept("\(city), \(countryIsoCode)")
        fetchWeatherData(city: city, countryCode: countryIsoCode)
    }
}
