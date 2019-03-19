//
//  APIService.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation

final class APIService {

    // MARK: - Properties
    static let sharedInstance = APIService()
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
                        encoding: ParameterEncoding = JSONEncoding.default,
                        success: @escaping (_ result: Any) -> Void,
                        failure: @escaping ( _ error: Error) -> Void) {

        request(url: String(format: "%@%@", APIEndpoints.baseURL, resource),
                method: .post,
                parameters: parameters,
                headers: headers,
                encoding: encoding) { result in
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
                     encoding: ParameterEncoding = JSONEncoding.default,
                     success: @escaping (_ result: Any) -> Void,
                     failure: @escaping ( _ error: Error) -> Void) {

        request(url: String(format: "%@%@", APIEndpoints.baseURL, resource),
                method: .get,
                parameters: parameters,
                headers: headers,
                encoding: encoding) { result in
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
                         encoding: ParameterEncoding = JSONEncoding.default,
                         result: @escaping (Result<Any>) -> Void) {

        #if DEBUG
        do {
            let originalRequest = try URLRequest(url: url, method: method, headers: headers)
            let encodedURLRequest = try encoding.encode(originalRequest, with: parameters)
            Logger.log(encodedURLRequest.curlString)
        } catch { }
        #endif

        sessionManager.request(url,
                               method: method,
                               parameters: parameters,
                               encoding: encoding,
                               headers: headers).responseJSON { response in
                                result(response.result)
        }
    }

    // MARK: - API functions
    func obtainCurrentWeather(for location: CLLocation,
                              success: @escaping ([String: Any]) -> Void,
                              failure: @escaping (Error) -> Void) {

        let lattitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let parameters = [
            "lat": lattitude,
            "lon": longitude,
            "appid": WeatherService.sharedInstance.apiKey
        ] as [String: Any]
        getResource(resource: APIEndpoints.currentWeatherURL,
                    parameters: parameters,
                    headers: nil,
                    encoding: URLEncoding.queryString,
                    success: { result in
                        Logger.log(result)
                        if let dict = result as? [String: Any] {
                            success(dict)
                        }
        }, failure: { error in
            failure(error)
        })
    }
}
