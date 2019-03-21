//
//  ImageDownloadManager.swift
//  Weatherly
//
//  Created by Hoang Luong on 21/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import Alamofire

class ImageDownloadManager: UIView {
    
    static func requestImageDownload(with url: String, completion: @escaping (UIImage?) -> ()) {
        
        AF.request(url).validate().responseData { (response) in
            guard response.result.isSuccess, let data = response.data else { return }
            
            completion(UIImage(data: data))
        }
        
    }
}
