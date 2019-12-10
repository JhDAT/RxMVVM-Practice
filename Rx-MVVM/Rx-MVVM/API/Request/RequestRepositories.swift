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
    
    init(param: [String: String?] = [:]) {
      self.path = "search/repositories"
      self.param = param
    }
  }
}
