//
//  XHConfig.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import Foundation
import RealmSwift

class XHConfig {
    /// 配置数据库(如果不需要修改默认数据库的，就不调用这个方法)
     func creatDataBase() {
        //获取当前配置
        var config = Realm.Configuration()
        
        // 使用默认的目录，替换默认数据库
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent(cacheDatabaseName)
        
        // 将这个配置应用到默认的 Realm 数据库当中
        Realm.Configuration.defaultConfiguration = config
    }   
}

/// 返回数据成功的状态码(一般为200)
enum XHStatus: String {
    case XHSuccess = "1"//修改此处
    case XHOtherError
}

///定义返回的JSON数据字段
let RESULT_CODE = "status"//状态码
let RESULT_MESSAGE = "Message"//错误消息提示
let RESULT_DATA = "data"//数据包
let RESULT_ERROE = "Errors"//错误包

//缓存数据库名称
let cacheDatabaseName = "XHcache.realm"



/// realm数据库保存的模型(必须保存statusCode字段，因为离线数据要用到状态码来判断是否是一次成功请求)
class ResultModel: Object {
    dynamic var data: Data? = nil
    dynamic var statuCode: Int = 0
    dynamic var key: String = ""
    
    //设置数据库主键
    override static func primaryKey() -> String? {
        return "key"
    }
}
