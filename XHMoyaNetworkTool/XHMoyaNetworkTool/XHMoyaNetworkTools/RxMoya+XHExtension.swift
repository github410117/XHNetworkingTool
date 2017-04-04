//
//  RxMoya+XHExtension.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RealmSwift

extension RxMoyaProvider {
    func XHOffLineCacheRequest(token: Target) -> Observable<Moya.Response> {
        return Observable.create({[weak self] (observer) -> Disposable in
            //拼接成为数据库的key
            let key = token.baseURL.absoluteString + token.path + (self?.toJSONString(dict: token.parameters))!
            
            //建立Realm
            let realm = try! Realm()
            print(realm.configuration.fileURL)
            //设置过滤条件
            let pre = NSPredicate(format: "key = %@",key)
            
            //过滤出来的数据(为数组)
            let ewresponse = realm.objects(ResultModel.self).filter(pre)
            
            //先看有无缓存的话，如果有数据，数组即不为0
            if ewresponse.count != 0 {
                //因为设置了过滤条件，只会出现一个数据,直接取
                let filterResult = ewresponse[0]
                //重新创建成Response发送出去
                let creatResponse = Response(statusCode: filterResult.statuCode, data: filterResult.data!)
                observer.onNext(creatResponse)
            }
            
            
            //进行正常的网络请求
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                    //建立数据库模型并赋值
                    let model = ResultModel()
                    model.data = response.data
                    model.key = key
                    model.statuCode = response.statusCode
                    //写入数据库(注意:update参数,如果在设置模型的时候没有设置主键的话，这里是不能使用update参数的,update参数可以保证如果有相同主键的数据就直接更新数据而不是新建)
                    try! realm.write {
                        realm.add(model, update: true)
                    }
                case let .failure(error):
                    observer.onError(error)
                }
                
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
            
        })
    }
    
    
    /// 字典转JSON字符串(用于设置数据库key的唯一性)
    func toJSONString(dict:Dictionary<String, Any>?)->String{
        
        let data = try? JSONSerialization.data(withJSONObject: dict!, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        return strJson! as String
        
    }
}
