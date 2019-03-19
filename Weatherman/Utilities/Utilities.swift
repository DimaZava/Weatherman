//
//  Utilities.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Foundation
import UIKit

final class Utilities {
}

final class Logger {

    enum LogEvent: String {
        case error = "⚠️"
        case verbose = "💬"
        case important = "🔥"
        case veryImportant = "🔥🔥"
        case critical = "🔥🔥🔥"
        case development = "d"
    }

    class func log(_ something: Any?...,
                   event: LogEvent = .verbose,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {

        #if DEBUG
        if event == logLevel || logLevel == nil {

            if something.count == 1,
                let someString = something.first as? String {
                print("\(now()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(funcName) -> \(someString)")
            } else {
                let description = String(describing: something)
                print("\(now()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(funcName) -> \(description)")
            }
        }
        #endif
    }

    private class func sourceFileName(filePath: String) -> String {
        return (filePath as NSString).lastPathComponent
    }

    static var logLevel: LogEvent? = .verbose
    static var dateFormat = "HH:mm:ssSSS"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    static func now() -> String {
        return dateFormatter.string(from: Date())
    }
}
