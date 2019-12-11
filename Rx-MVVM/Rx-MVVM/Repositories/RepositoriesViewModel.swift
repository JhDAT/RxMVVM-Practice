//
//  RepositoriesViewModel.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/10.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct RepositoriesViewModel {
  typealias Repositories = API.Response.Repositories
  typealias RepositoriesItemModel = SectionModel<String, API.Response.Repositories.Items>
  private var request = API.Request.Repositories(language: .swift, sort: .stars, order: .desc)
  
  private let errorOB = PublishSubject<Error>()
  
  struct Output {
    public let repositoriesList: Driver<[RepositoriesItemModel]>
  }
  
  init() { }
  
  public func transform() -> Output {
    let initOB = getAPI(request: request)
    
    let repositoriesListDrive = Observable<Repositories>
      .merge(initOB)
      .map(createSectionModel)
      .asDriver(onErrorJustReturn: [])
    
    return Output(repositoriesList: repositoriesListDrive)
  }
  
  private func getAPI(request: API.Request.Repositories) -> Observable<API.Response.Repositories> {
    return API.setAPIRequest(request, responseType: API.Response.Repositories.self).retry(2)
      .catchError { error in
        self.errorOB.onNext(error)
        return .never()
    }
  }
  
  private func createSectionModel(from repositoriesModel: Repositories) -> [RepositoriesItemModel] {
    return [RepositoriesItemModel(model: "", items: repositoriesModel.itemsValue)]
  }
}
