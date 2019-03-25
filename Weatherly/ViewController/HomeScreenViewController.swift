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
        iv.backgroundColor = UIColor.red
        return iv
    }()
    
    var weatherDisplayView: WeatherDisplayView!
    var dateAndTimeView: DateAndTimeView!
    var loadingIndicatorView: LoadingIndicatorView?
    
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
        
        dateAndTimeView = DateAndTimeView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 250, height: 150)))
        dateAndTimeView.center.x = view.frame.midX
        dateAndTimeView.center.y = view.frame.maxY - 150
        view.addSubview(dateAndTimeView)
    }
    
    private func toggleDataIsLoading(to isloading: Bool) {
        
        if isloading == true {
            loadingIndicatorView = LoadingIndicatorView(frame: view.frame)
            loadingIndicatorView?.startSpinner()
            view.addSubview(loadingIndicatorView!)
        } else {
            
            loadingIndicatorView?.fadeOut(completion: { (_) in
                self.loadingIndicatorView = nil
            })
        
        }
        
    }
    
    private func bindViewModel() {
        
        viewModel.weatherBackgroundImage.asObservable().bind(to: backgroundImageView.rx.image).disposed(by: disposeBag)
        viewModel.locationString.asObservable().bind(to: weatherDisplayView.locationLabel.rx.text).disposed(by: disposeBag)
        viewModel.weatherDescription.asObservable().bind(to: weatherDisplayView.descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.weatherDescriptionIcon.asObservable().bind(to: weatherDisplayView.descriptionIconImageView.rx.image).disposed(by: disposeBag)
        viewModel.temperature.asObservable().bind(to: weatherDisplayView.temperatureLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.dateString.asObservable().bind(to: dateAndTimeView.dateLabel.rx.text).disposed(by: disposeBag)
        viewModel.timeString.asObservable().bind(to: dateAndTimeView.timelabel.rx.text).disposed(by: disposeBag)

        viewModel.isFetchingWeatherData.asObservable().subscribe(onNext: {
            loadingStatus in
            self.toggleDataIsLoading(to: loadingStatus)
        }).disposed(by: disposeBag)
        
    }
    
}
