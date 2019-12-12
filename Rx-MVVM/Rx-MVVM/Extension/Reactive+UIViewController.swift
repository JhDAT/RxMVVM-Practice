//
//  Reactive+UIViewController.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/12.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
  var viewWillAppear: ControlEvent<Void> {
    let source = methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
    return ControlEvent(events: source)
  }
}
