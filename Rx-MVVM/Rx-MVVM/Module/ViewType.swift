//
//  ViewModelType.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/10.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewType: class {
  associatedtype ViewModelType
  var viewModel: ViewModelType! { get set }
  var disposedBag: DisposeBag! { get set }
  func setupUI()
  func setupEventBinding()
  func setupUIBinding()
}

extension ViewType where Self: UIViewController {
  static func create(to viewModel: ViewModelType) -> Self {
    let `self` = Self()
    self.viewModel = viewModel
    self.disposedBag = DisposeBag()
    self.loadViewIfNeeded()
    self.setupUI()
    self.setupEventBinding()
    self.setupUIBinding()
    return self
  }
}
