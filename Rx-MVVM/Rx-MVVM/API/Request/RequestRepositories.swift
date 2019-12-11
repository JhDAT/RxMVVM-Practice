//
//  Repositories.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/09.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit

extension API.Request {
  struct Repositories: CoreRequest {
    var path: String
    var param: [String: String?]
    
    init(language: API.LanguageList, sort: API.SortStatus? = nil, order: API.Order? = nil) {
      self.path = "search/repositories"
      self.param = ["q": language.rawValue]
      if let sort = sort {
        self.param.updateValue(sort.rawValue, forKey: "sort")
      }
      if let order = order {
        self.param.updateValue(order.rawValue, forKey: "order")
      }
    }
  }
}
