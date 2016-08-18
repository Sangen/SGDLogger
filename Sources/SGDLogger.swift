//
//  SGDLogger.swift
//  SGDLogger
//
//  Created by Sangen on 9/8/15.
//  Copyright (c) 2015 Sangen. All rights reserved.
//

import Foundation

/**
* SGDLogger
*
* use : XcodeColoers plug-in
* desc: Show logs with colors.
*/
public class SGDLogger {

    public enum LogLevel: Int {
        case Verbose = 1
        case Debug
        case Info
        case Warning
        case Error
        case None

        public func description() -> String {
            switch self {
            case .Verbose: return "Vrb"
            case .Debug:   return "Dbg"
            case .Info:    return "Inf"
            case .Warning: return "Wrn"
            case .Error:   return "Err"
            case .None:    return "Non"
            }
        }
    }

    public static let defaultLogger = SGDLogger()

    public var logger: (logText: String) -> Void = { logText in
        print(logText)
    }
    public var outputLogLevel: LogLevel = .Debug

    public var dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

    public var showDate = true
    public var showLogLevel = true
    public var showFileInfo = true
    public var showFunctionName = true
    public var showColor = true

    public var verboseColor = Color.gray
    public var debugColor = Color.blue
    public var infoColor = Color.cyan
    public var warningColor = Color.yellow
    public var errorColor = Color.red
    public var subInfoColor = Color.gray

    public func showDate(showDate: Bool, logLevel showLogLevel: Bool, fileInfo showFileInfo: Bool, functionName showFunctionName: Bool, color showColor: Bool=true) {
        self.showDate = showDate
        self.showLogLevel = showLogLevel
        self.showFileInfo = showFileInfo
        self.showFunctionName = showFunctionName
        self.showColor = showColor
    }

    public func logln(msg: String, logLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {

        if self.isEnabledForLogLevel(logLevel) {
            var logLevelStr = ""
            var fileInfoStr = ""
            var functionNameStr = ""
            var dateTimeStr = ""
            var infoSpacer = ""
            var output = ""

            if self.showLogLevel {
                logLevelStr = "[" + logLevel.description() + "] "
            }

            if self.showFileInfo {
                fileInfoStr = "[" + (file.stringValue as NSString).lastPathComponent + ":" + String(line) + "] "
            }

            if self.showFunctionName {
                functionNameStr = function.stringValue + " "
            }

            if self.showDate {
                let now = NSDate()
                let dateFormatter = self.dynamicType.dateFormatter
                dateFormatter.dateFormat = self.dateFormat
                dateTimeStr = dateFormatter.stringFromDate(now)
            }

            if self.showFileInfo || self.showFunctionName || self.showDate {
                infoSpacer = "  "
            }

            if self.showColor {
                switch logLevel {
                case .Verbose:
                    output += Color.str(logLevelStr + msg, color: self.verboseColor)
                case .Debug:
                    output += Color.str(logLevelStr + msg, color: self.debugColor)
                case .Info:
                    output += Color.str(logLevelStr + msg, color: self.infoColor)
                case .Warning:
                    output += Color.str(logLevelStr + msg, color: self.warningColor)
                case .Error:
                    output += Color.str(logLevelStr + msg, color: self.errorColor)
                default:
                    output += logLevelStr + msg
                }
                output += infoSpacer + Color.str(fileInfoStr + functionNameStr + dateTimeStr, color: self.subInfoColor)
            } else {
                output += logLevelStr + msg + infoSpacer + fileInfoStr + functionNameStr + dateTimeStr
            }

            self.logger(logText: output)
        }
    }

    public func logln(msg: String, logLevel: LogLevel, error: ErrorType?, errorLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        if let error = error {
            let errMsg = "\(msg) - error: \(toString(error))"
            self.logln(errMsg, logLevel: errorLevel, file: file, function: function, line: line)
        } else {
            self.logln(msg, logLevel: logLevel, file: file, function: function, line: line)
        }
    }

    public func toString(error: ErrorType) -> String {
        let nsError = (error as NSError)
        if nsError.userInfo.isEmpty {
            return "\(error)"
        } else {
            return "\(nsError.localizedDescription) (code: \(nsError.code))"
        }
    }

    public class func verbose(msg: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Verbose, file: file, function: function, line: line)
    }
    public class func verbose(msg: String, error: ErrorType?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Verbose, error: error, errorLevel: .Error, file: file, function: function, line: line)
    }
    public class func verbose(msg: String, error: ErrorType?, errorLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Verbose, error: error, errorLevel: errorLevel, file: file, function: function, line: line)
    }

    public class func info(msg: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Info, file: file, function: function, line: line)
    }
    public class func info(msg: String, error: ErrorType?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Info, error: error, errorLevel: .Error, file: file, function: function, line: line)
    }
    public class func info(msg: String, error: ErrorType?, errorLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Info, error: error, errorLevel: errorLevel, file: file, function: function, line: line)
    }

    public class func debug(msg: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Debug, file: file, function: function, line: line)
    }
    public class func debug(msg: String, error: ErrorType?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Debug, error: error, errorLevel: .Error, file: file, function: function, line: line)
    }
    public class func debug(msg: String, error: ErrorType?, errorLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Debug, error: error, errorLevel: errorLevel, file: file, function: function, line: line)
    }

    public class func warning(msg: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Warning, file: file, function: function, line: line)
    }
    public class func warning(msg: String, error: ErrorType?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Warning, error: error, errorLevel: .Error, file: file, function: function, line: line)
    }
    public class func warning(msg: String, error: ErrorType?, errorLevel: LogLevel, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Warning, error: error, errorLevel: errorLevel, file: file, function: function, line: line)
    }

    public class func error(msg: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Error, file: file, function: function, line: line)
    }
    public class func error(msg: String, error: ErrorType?, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.defaultLogger.logln(msg, logLevel: .Error, error: error, errorLevel: .Error, file: file, function: function, line: line)
    }

    static var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter
        }()


    func isEnabledForLogLevel(logLevel: SGDLogger.LogLevel) -> Bool {
        return logLevel.rawValue >= self.outputLogLevel.rawValue
    }

    struct Color {
        static let escape = "\u{001b}["
        static let reset  = escape + ";"   // Clear any foreground or background color

        static let red    = "220,50,47"
        static let cyan   = "42,161,152"
        static let blue   = "38,139,210"
        static let yellow = "181,137,0"
        static let gray   = "88,110,117"

        static func str(str: String, color: String) -> String {
            return "\(escape)fg\(color);\(str)\(reset)"
        }
    }
}

