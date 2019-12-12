//
//  RepositoriesViewController.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/11/07.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class RepositoriesViewController: UIViewController, ViewType {
  // MARK: - Property
  var viewModel: RepositoriesViewModel!
  var disposedBag: DisposeBag!
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: "RepositoriesTableViewCell")
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()
  
  let dataSource = RxTableViewSectionedAnimatedDataSource<RepositoriesViewModel.RepositoriesItemModel>(
    configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
      let describingCell = String(describing: RepositoriesTableViewCell.self)
      let dequcell = tableView.dequeueReusableCell(withIdentifier: describingCell, for: indexPath)
      guard let cell = dequcell as? RepositoriesTableViewCell else { return UITableViewCell() }
      cell.configuration(item: item)
      return cell
  }
  )
}

// MARK: - setupUI
extension RepositoriesViewController {
  func setupUI() {
    [tableView].forEach { self.view.addSubview($0) }
    
    tableView
      .topAnchor(equalTo: view)
      .bottomAnchor(equalTo: view)
      .leadingAnchor(equalTo: view)
      .trailingAnchor(equalTo: view)
      .activeAnchor()
  }
  
  func setupEventBinding() {
    
  }
  
  func setupUIBinding() {
    let output = viewModel.transform()
    output.repositoriesList
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposedBag)
  }
}
