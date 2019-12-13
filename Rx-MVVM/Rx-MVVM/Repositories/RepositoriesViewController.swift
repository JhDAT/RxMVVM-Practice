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
  
  private let sortedDescButton: UIButton = {
    let sortedButton = UIButton()
    sortedButton.setTitle("fork.Desc", for: .normal)
    sortedButton.setTitleColor(.black, for: .normal)
    sortedButton.backgroundColor = UIColor.black.withAlphaComponent(0.25)
    return sortedButton
  }()
  
  private let sortedASCButton: UIButton = {
    let sortedButton = UIButton()
    sortedButton.setTitle("fork.ASC", for: .normal)
    sortedButton.setTitleColor(.black, for: .normal)
    sortedButton.backgroundColor = UIColor.black.withAlphaComponent(0.25)
    return sortedButton
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
    [tableView, sortedDescButton, sortedASCButton].forEach { self.view.addSubview($0) }
    
    sortedDescButton
      .topAnchor(equalTo: view)
      .leadingAnchor(equalTo: view, constant: 10)
      .heightAnchor(equalTConstant: 30)
      .activeAnchor()
    
    sortedASCButton
      .topAnchor(equalTo: sortedDescButton)
      .leadingAnchor(equalTo: sortedDescButton.trailingAnchor, constant: 10)
      .bottomAnchor(equalTo: sortedDescButton)
      .activeAnchor()
    
    tableView
      .topAnchor(equalTo: sortedDescButton.bottomAnchor, constant: 10)
      .bottomAnchor(equalTo: view)
      .leadingAnchor(equalTo: view)
      .trailingAnchor(equalTo: view)
      .activeAnchor()
  }
  
  func setupEventBinding() {
    sortedDescButton.rx.tap
      .bind(to: viewModel.tapSortedDescButton)
      .disposed(by: disposedBag)
    
    sortedASCButton.rx.tap
      .bind(to: viewModel.tapSortedASCButton)
      .disposed(by: disposedBag)
  }
  
  func setupUIBinding() {
    let output = viewModel.transform()
    output.setSectionModel
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposedBag)
  }
}
