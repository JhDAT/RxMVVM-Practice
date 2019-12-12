//
//  RepositoriesTableViewCell.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/12.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit

final class RepositoriesTableViewCell: UITableViewCell {
  // MARK: - Property
  
  private let nameLable: UILabel = {
    let nameLable = UILabel()
    nameLable.font = .systemFont(ofSize: Constant.fontSize)
    return nameLable
  }()
  private let descriptionLabel: UILabel = {
    let descriptionLabel = UILabel()
    descriptionLabel.font = .systemFont(ofSize: Constant.fontSize)
    descriptionLabel.numberOfLines = 0
    return descriptionLabel
  }()
  private let forkLabel: UILabel = {
    let forkLabel = UILabel()
    forkLabel.font = .systemFont(ofSize: Constant.fontSize)
    return forkLabel
  }()
  
  // MARK: - UIConstant
  
  struct Constant {
    static let fontSize: CGFloat = 12
  }
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SET
  
  private func setupUI() {
    [nameLable, descriptionLabel, forkLabel].forEach { self.contentView.addSubview($0) }
    
    nameLable
      .topAnchor(equalTo: self.contentView, constant: 5)
      .leadingAnchor(equalTo: self.contentView, constant: 10)
      .activeAnchor()
    
    descriptionLabel
      .topAnchor(equalTo: nameLable.bottomAnchor, constant: 10)
      .leadingAnchor(equalTo: nameLable)
      .trailingAnchor(equalTo: self.contentView, constant: 10)
      .bottomAnchor(equalTo: self.contentView, constant: 10)
      .activeAnchor()
    
    forkLabel
      .topAnchor(equalTo: nameLable)
      .trailingAnchor(equalTo: self.contentView, constant: 10)
      .activeAnchor()
  }
}

// MARK: - Function

extension RepositoriesTableViewCell {
  public func configuration(item: API.Response.Repositories.Items) {
    nameLable.text = item.fullNameValue
    descriptionLabel.text = item.descriptionValue
    forkLabel.text = String(format: "fork : %d", item.forksValue)
  }
}
