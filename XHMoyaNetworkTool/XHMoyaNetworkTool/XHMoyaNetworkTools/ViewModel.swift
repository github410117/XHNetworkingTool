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
        .debug()
        .distinctUntilChanged()
        .mapResponseToObj(T.self)
    }
}
