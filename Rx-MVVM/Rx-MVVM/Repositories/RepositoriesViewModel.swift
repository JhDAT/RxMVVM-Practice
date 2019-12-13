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
  typealias RepositoriesItemModel = AnimatableSectionModel<String, API.Response.Repositories.Items>
  
  enum ButtonType {
    case tapSortedDescButton
    case sortedASCButton
  }
  
  private var request = API.Request.Repositories(language: .swift, sort: nil, order: .desc)
  private let errorOB = PublishSubject<Error>()
  
  public let tapSortedDescButton = PublishSubject<Void>()
  public let tapSortedASCButton = PublishSubject<Void>()
  
  struct Output {
    public let setSectionModel: Driver<[RepositoriesItemModel]>
  }
  
  init() { }
  
  public func transform() -> Output {
    let initOB = getAPI(request: request).share(replay: 2)
    var buttonType: ButtonType?
    
    let buttonTapTypeOB = Observable<ButtonType>
      .merge(tapSortedDescButton.map { ButtonType.tapSortedDescButton },
             tapSortedASCButton.map { ButtonType.sortedASCButton })
      .do(onNext: { buttonType = $0 })
      .withLatestFrom(initOB)
      .map { ($0, buttonType)}
      .map(sorted)
    
    let repositoriesListDrive = Observable<Repositories>
      .merge(initOB, buttonTapTypeOB)
      .map(createSectionModel)
      .asDriver(onErrorJustReturn: [])
    
    return Output(setSectionModel: repositoriesListDrive)
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
  
  private func sorted(from target: (repo: Repositories, type: ButtonType?)) -> Repositories {
    guard let type = target.type else { return target.repo }
    var repo = target.repo
    repo.itemsValue = target.repo.itemsValue.sorted(by: { type == .tapSortedDescButton ?  $0.forksValue > $1.forksValue : $0.forksValue < $1.forksValue })
    return repo
  }
}
