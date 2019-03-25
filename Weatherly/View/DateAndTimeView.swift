//
//  DateAndTimeView.swift
//  Weatherly
//
//  Created by Hoang Luong on 21/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class DateAndTimeView: UIView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let timelabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubviewUsingAutoLayout(dateLabel, timelabel)
        
        timelabel.topAnchor.constrain(to: self.topAnchor, with: self.frame.height/2)
        timelabel.widthAnchor.constrain(to: self.frame.width)
        timelabel.heightAnchor.constrain(to: 50)
        timelabel.centerXAnchor.constrain(to: self.centerXAnchor)
        
        dateLabel.bottomAnchor.constrain(to: timelabel.topAnchor)
        dateLabel.widthAnchor.constrain(to: self.frame.width)
        dateLabel.heightAnchor.constrain(to: 50)
        dateLabel.centerXAnchor.constrain(to: self.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
