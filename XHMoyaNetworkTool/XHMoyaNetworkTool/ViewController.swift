//
//  ViewController.swift
//  XHMoyaNetworkTool
//
//  Created by xh on 2017/4/4.
//  Copyright © 2017年 xh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class ViewController: UIViewController {

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var showResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData(IPModel.self)
            .catchError({ (error) -> Observable<IPModel?> in
                print(error.localizedDescription)
                return Observable.empty()
            })
            .map { $0?.city   }
            .bindTo(self.showResult.rx.text)
            .addDisposableTo(disposeBag)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func testBtn(_ sender: UIButton) {
       
        
    }


}

