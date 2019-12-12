//
//  Repositories.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/09.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit
import RxDataSources

extension API.Response {
  struct Repositories: Codable {
    private let totalCount: Int?
    private let incompleteResults: Bool?
    private let items: [Items]?
    
    public var totalCountValue: Int { return self.totalCount ?? 0 }
    public var incompleteResultsValue: Bool { return self.incompleteResults ?? false }
    public var itemsValue: [Items] { return self.items ?? [] }
  }
}

extension API.Response.Repositories {
  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case incompleteResults = "incomplete_results"
    case items
  }
}

extension API.Response.Repositories {
  struct Items: Codable, Equatable {
    private let nodeId: String?
    private let name: String?
    private let fullName: String?
    private let isPrivate: Bool?
    private let description: String?
    private let forks: Int?
    
    public let idValue: Int?
    public var nodeIdValue: String { return self.nodeId ?? "" }
    public var nameValue: String { return self.name ?? "" }
    public var fullNameValue: String { return self.fullName ?? "" }
    public var isPrivateValue: Bool { return self.isPrivate ?? false }
    public var descriptionValue: String { return self.description ?? "" }
    public var forksValue: Int { return self.forks ?? 0 }
  }
}

extension API.Response.Repositories.Items: IdentifiableType {
  var identity: Int {
    return self.idValue ?? 0
  }
}

extension API.Response.Repositories.Items {
  enum CodingKeys: String, CodingKey {
    case idValue = "id"
    case name, description, forks
    case nodeId = "node_id"
    case fullName = "full_name"
    case isPrivate = "private"
  }
}
