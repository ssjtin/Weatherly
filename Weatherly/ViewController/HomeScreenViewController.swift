//
//  MainViewController
//  Weatherly
//
//  Created by Hoang Luong on 20/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeScreenViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var weatherDisplayView: WeatherDisplayView!
    var dateAndTimeView: DateAndTimeView!
    
    let viewModel = HomeScreenViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.white
        
        view.addSubviewUsingAutoLayout(backgroundImageView)
        backgroundImageView.topAnchor.constrain(to: view.topAnchor)
        backgroundImageView.leadingAnchor.constrain(to: view.leadingAnchor)
        backgroundImageView.trailingAnchor.constrain(to: view.trailingAnchor)
        backgroundImageView.bottomAnchor.constrain(to: view.bottomAnchor)
        
        weatherDisplayView = WeatherDisplayView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.frame.width, height: 500)))
        view.addSubview(weatherDisplayView)
        
        dateAndTimeView = DateAndTimeView(frame: CGRect(origin: CGPoint(x: view.frame.midX - 125, y: 500), size: CGSize(width: 250, height: 150)))
        view.addSubview(dateAndTimeView)
    }
    
    private func bindViewModel() {
        
        viewModel.weatherBackgroundImage.asObservable().subscribe(onNext: {
            image in
            self.backgroundImageView.image = image
        }).disposed(by: disposeBag)
        
        viewModel.locationString.asObservable().subscribe(onNext: {
            location in
            self.weatherDisplayView.locationLabel.text = location
        }).disposed(by: disposeBag)
        
        viewModel.weatherDescription.asObservable().subscribe(onNext: {
            description in
            self.weatherDisplayView.descriptionLabel.text = description
        }).disposed(by: disposeBag)
        
        viewModel.weatherDescriptionIcon.asObservable().subscribe(onNext: {
            icon in
            self.weatherDisplayView.descriptionIconImageView.image = icon
        }).disposed(by: disposeBag)
        
        viewModel.temperature.asObservable().subscribe(onNext: {
            temp in
            self.weatherDisplayView.temperatureLabel.text = temp
        }).disposed(by: disposeBag)
        
        viewModel.dateString.asObservable().subscribe(onNext: {
            date in
            self.dateAndTimeView.dateLabel.text = date
        }).disposed(by: disposeBag)
        
        viewModel.timeString.asObservable().subscribe(onNext: {
            time in
            self.dateAndTimeView.timelabel.text = time
        }).disposed(by: disposeBag)
        
    }
    
}
