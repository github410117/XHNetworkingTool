//
//  ViewModel.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class ViewModel {
    private let provider = RxMoyaProvider<ApiManager>()
   
    func loadData<T: Mapable>(_ model: T.Type) -> Observable<T?> {
        return provider.XHOffLineCacheRequest(token: .github)
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
        .observeOn(MainScheduler.instance)
        .debug()
        .distinctUntilChanged()
        .catchError({ (error) -> Observable<Response> in
                //捕获错误，不然离线访问会导致Binding error to UI，可以再此显示HUD等操作
                print(error.localizedDescription)
                return Observable.empty()
        })
        .mapResponseToObj(T.self)
    }
}
