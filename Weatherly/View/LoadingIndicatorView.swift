//
//  LoadingIndicatorView.swift
//  Weatherly
//
//  Created by Hoang Luong on 22/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.style = .gray
        return ai
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Fetching current weather info..."
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubviewUsingAutoLayout(activityIndicator, loadingLabel)
        activityIndicator.heightAnchor.constrain(to: 50)
        activityIndicator.widthAnchor.constrain(to: 50)
        activityIndicator.centerYAnchor.constrain(to: self.centerYAnchor)
        activityIndicator.centerXAnchor.constrain(to: self.centerXAnchor)
        
        loadingLabel.topAnchor.constrain(to: activityIndicator.bottomAnchor)
        loadingLabel.centerXAnchor.constrain(to: self.centerXAnchor)
        loadingLabel.widthAnchor.constrain(to: 250)
        loadingLabel.heightAnchor.constrain(to: 40)
        
        animateLoadingLabelOut()
    }
    
    func animateLoadingLabelOut() {
        UIView.animate(withDuration: 0.8, animations: {
            self.loadingLabel.alpha = 0
        }) { (true) in
            self.animateLoadingLabelIn()
        }
    }
    
    func animateLoadingLabelIn() {
        UIView.animate(withDuration: 0.8, animations: {
            self.loadingLabel.alpha = 1
        }) { (true) in
            self.animateLoadingLabelOut()
        }
    }
    
    func startSpinner() {
        activityIndicator.startAnimating()
    }
    
    func fadeOut(completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }) { (true) in
            self.removeFromSuperview()
            completion(true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
