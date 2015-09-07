//
//  APIManager+Me.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/29.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func uploadMyImage(index: Int, image: UIImage) -> BFTask {

        var data = UIImageJPEGRepresentation(image, 0.98)
        var parameters: [String: AnyObject] = [
            "index": index
        ]
        return upload("/v1/me/image/", data: data, name: "image", fileName: "image.jpg", mimeType: "image/jpeg", parameters: parameters).APIErrorHandler()
    }
}
