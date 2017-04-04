//
//  IPModel.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct IPModel: Mapable {
    let city: String?
    
    init?(jsonData: JSON) {
        self.city = jsonData["city"].string
    }
    
}
