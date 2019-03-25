//
//  WeatherDisplayView.swift
//  Weatherly
//
//  Created by Hoang Luong on 21/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class WeatherDisplayView: UIView {
    

    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 80)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let descriptionIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubviewUsingAutoLayout(locationLabel, temperatureLabel, descriptionLabel, descriptionIconImageView)

        locationLabel.trailingAnchor.constrain(to: self.trailingAnchor)
        locationLabel.topAnchor.constrain(to: self.topAnchor, with: 30)
        locationLabel.widthAnchor.constrain(to: self.widthAnchor)
        locationLabel.heightAnchor.constrain(to: 50)
        
        temperatureLabel.leadingAnchor.constrain(to: self.leadingAnchor, with: 10)
        temperatureLabel.topAnchor.constrain(to: self.topAnchor, with: 80)
        temperatureLabel.widthAnchor.constrain(to: 200)
        temperatureLabel.heightAnchor.constrain(to: 80)
        
        descriptionLabel.centerXAnchor.constrain(to: self.centerXAnchor)
        descriptionLabel.topAnchor.constrain(to: temperatureLabel.bottomAnchor, with: 50)
        descriptionLabel.widthAnchor.constrain(to: self.frame.width)
        descriptionLabel.heightAnchor.constrain(to: 40)
        
        descriptionIconImageView.centerXAnchor.constrain(to: self.centerXAnchor)
        descriptionIconImageView.topAnchor.constrain(to: descriptionLabel.bottomAnchor, with: 10)
        descriptionIconImageView.widthAnchor.constrain(to: 75)
        descriptionIconImageView.heightAnchor.constrain(to: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
