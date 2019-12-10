//
//  RepositoriesViewController.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/11/07.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class RepositoriesViewController: UIViewController {
  // MARK: - Property
  private let tableView: UITableView = {
    let tableView = UITableView()
    
    return tableView
  }()
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

  }
}

// MARK: - setupUI
extension RepositoriesViewController {
  private func setupUI() {
    [tableView].forEach { self.view.addSubview($0) }
    
    tableView
      .topAnchor(equalTo: view)
      .bottomAnchor(equalTo: view)
      .leadingAnchor(equalTo: view)
      .trailingAnchor(equalTo: view)
      .activeAnchor()
  }
}
