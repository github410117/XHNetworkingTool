//
//  XHApiManager.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import Foundation
import Moya
import RxSwift


/// 建立请求
enum ApiManager {
    case github
}

// MARK: - 实现Moya基本参数
extension ApiManager: TargetType {
    
    /// 基类API
    var baseURL: URL {
        return URL.init(string: "http://ditu.amap.com")!
    }
    
    /// 拼接请求路径
    var path: String {
        switch self {
        case .github:
            return "/service/regeo"
        }
    }
    
    /// 设置请求方式
    var method: Moya.Method {
        switch self {
        case .github:
            return .get
        }
    }
    
    /// 设置传参
    var parameters: [String: Any]? {
        switch self {
        case .github:
            return ["longitude" : "121.04925573429551", "latitude" : "31.315590522490712"]
        }
    }
    
    /// 设置编码方式
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// 这个用于测试,对此不太熟悉!
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// 设置任务的请求方式(可以改成上传upload、下载download)
    var task: Task {
        return .request
    }
    
    /// Alamofire中的验证，默认是false
    var validate: Bool {
        return false
    }
    
}
