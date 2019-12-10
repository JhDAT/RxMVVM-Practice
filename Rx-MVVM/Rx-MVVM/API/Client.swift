//
//  Client.swift
//  Rx-MVVM
//
//  Created by Jo JANGHUI on 2019/12/09.
//  Copyright © 2019 Jo JANGHUI. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Protocol
protocol CoreRequest {
  var path: String { get }
  var param: [String: String?] { get }
}

final class API {
  private static var baseURL = "https://api.github.com/"
  private static let jsonDecoder = JSONDecoder()
  
  struct Request { }
  struct Response { }
  
}

// MARK: - APIError
extension API {
  enum APIError: Error {
    case unknownURL
    case undifinedResponse
    case nullData
  }
}

// MARK: - Function
extension API {
  private static var micreSecond: Double {
    return Date.init(timeIntervalSinceNow: 0.0).timeIntervalSince1970 * 1_000_000
  }
  
  static func getRequest<T: Codable>(_ request: CoreRequest, responseType: T.Type = T.self) -> Observable<T> {
    let startTime = API.micreSecond
    let urlstring = String(format: "%@%@", baseURL, request.path)
    var compoent = URLComponents(string: urlstring)
    compoent?.queryItems = request.param.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
    
    return Observable<T>.create { observer in
      guard let url = compoent?.url else {
        observer.onError(APIError.unknownURL)
        return Disposables.create()
      }
      let request = URLRequest(url: url)
      let sessionConfiguration = URLSessionConfiguration.default
      let session = URLSession(configuration: sessionConfiguration)
      let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else { return observer.onError(error ?? APIError.undifinedResponse) }
        guard let data = data else { return observer.onError(APIError.nullData) }
        do {
          let responseObject = try self.jsonDecoder.decode(T.self, from: data)
          print()
          let responseInterval = floor(API.micreSecond - startTime)
          print(String(format: "🚀🚀🚀 RESPONSE %@ (%@ bytes). dealyed in: %@μs 🚀🚀🚀",
                       request.url?.absoluteString ?? "url is invalid",
                       String(data.count),
                       responseInterval.addedCommaString()))
          print()
          observer.onNext(responseObject)
          observer.onCompleted()
        } catch let error {
          print("CODABLE JSON Parsing Error :\n", error)
          observer.onError(error)
        }
      }
      task.resume()
      return Disposables.create {
        task.cancel()
      }
    }
  }
}
