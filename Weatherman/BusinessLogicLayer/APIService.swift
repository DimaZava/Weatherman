//
//  APIService.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Alamofire
import Foundation

final class APIService {

    // MARK: - Properties
    static let sharedManager = APIService()
    let sessionManager: Alamofire.SessionManager

    // MARK: - Lifecycle
    private init() {
        let sessionConfiguration = URLSessionConfiguration.default
        //sessionConfiguration.timeoutIntervalForRequest = 60 * 2
        //sessionConfiguration.timeoutIntervalForResource = 60 * 2
        sessionManager = Alamofire.SessionManager(configuration: sessionConfiguration)
    }

    func invalidateAndCancelSession() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }

    // MARK: - Base Functions
    func postAtResource(resource: String,
                        parameters: [String: Any]?,
                        headers: HTTPHeaders?,
                        success: @escaping (_ result: Any) -> Void,
                        failure: @escaping ( _ error: Error) -> Void) {

        request(url: String(format: "%@%@", APIEndpoints.baseURL, resource),
                method: .post,
                parameters: parameters,
                headers: headers) { result in
                    switch result {
                    case .success(let value):
                        success(value)
                    case .failure(let error):
                        failure(error)
                    }
        }
    }

    func getResource(resource: String,
                     parameters: [String: Any]?,
                     headers: HTTPHeaders?,
                     success: @escaping (_ result: Any) -> Void,
                     failure: @escaping ( _ error: Error) -> Void) {

        request(url: String(format: "%@%@", APIEndpoints.baseURL, resource),
                method: .get,
                parameters: parameters,
                headers: headers) { result in
                    switch result {
                    case .success(let value):
                        success(value)
                    case .failure(let error):
                        failure(error)
                    }
        }
    }

    private func request(url: String,
                         method: HTTPMethod,
                         parameters: Parameters?,
                         headers: HTTPHeaders?,
                         result: @escaping (Result<Any>) -> Void) {

        #if DEBUG
        do {
            let originalRequest = try URLRequest(url: url, method: method, headers: headers)
            let encodedURLRequest = try JSONEncoding.default.encode(originalRequest, with: parameters)
            Logger.log(encodedURLRequest.curlString)
        } catch { }
        #endif

        sessionManager.request(url,
                               method: method,
                               parameters: parameters,
                               encoding: JSONEncoding.default,
                               headers: headers).responseJSON { response in
                                result(response.result)
        }
    }

    // MARK: - API functions
}
