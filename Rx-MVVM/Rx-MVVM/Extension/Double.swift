//
//  Double.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/10.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import Foundation

extension Double {
  public func addedCommaString() -> String {
    return NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
  }
}
