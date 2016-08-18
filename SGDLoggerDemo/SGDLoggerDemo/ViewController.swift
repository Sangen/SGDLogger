//
//  ViewController.swift
//  SGDLoggerDemo
//
//  Created by Sangen on 1/22/16.
//  Copyright © 2016 Sangen. All rights reserved.
//

import UIKit
import SGDLogger

class ViewController: UIViewController {

    enum CustomError: ErrorType {
        case Timeout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let error = NSError(domain: "jp.co.sangendokei.SGDLogger", code: 1, userInfo: [NSLocalizedDescriptionKey: "Something error messages."])

        SGDLogger.verbose("verbose log")  // verbose not active. Default outputLogLevel is Debug
        SGDLogger.debug("debug log")
        SGDLogger.info("info log")
        SGDLogger.warning("warning log")
        SGDLogger.error("error log")
        print("")

        SGDLogger.defaultLogger.dateFormat = "MM-dd HH:mm:ss.SSS"
        SGDLogger.defaultLogger.outputLogLevel = .Verbose
        SGDLogger.defaultLogger.showDate = false
        SGDLogger.defaultLogger.showLogLevel = true
        SGDLogger.defaultLogger.showFileInfo = false
        SGDLogger.defaultLogger.showFunctionName = false

        SGDLogger.verbose("verbose log")
        SGDLogger.debug("debug log")
        SGDLogger.info("info log")
        SGDLogger.warning("warning log")
        SGDLogger.error("error log")
        print("")

        SGDLogger.verbose("verbose log", error: nil)
        SGDLogger.verbose("verbose log", error: error)
        SGDLogger.verbose("verbose log", error: nil, errorLevel: .Warning)
        SGDLogger.verbose("verbose log", error: error, errorLevel: .Warning)
        SGDLogger.debug("debug log", error: nil)
        SGDLogger.debug("debug log", error: error)
        SGDLogger.debug("debug log", error: nil, errorLevel: .Info)
        SGDLogger.debug("debug log", error: error, errorLevel: .Info)
        SGDLogger.info("info log", error: nil)
        SGDLogger.info("info log", error: error)
        SGDLogger.info("info log", error: nil, errorLevel: .Warning)
        SGDLogger.info("info log", error: error, errorLevel: .Warning)
        SGDLogger.warning("warning log", error: nil)
        SGDLogger.warning("warning log", error: error)
        SGDLogger.warning("warning log", error: nil, errorLevel: .Verbose)
        SGDLogger.warning("warning log", error: error, errorLevel: .Verbose)
        SGDLogger.error("error log", error: nil)
        SGDLogger.error("error log", error: error)
        SGDLogger.error("error log", error: CustomError.Timeout)
        print("")

        SGDLogger.defaultLogger.logger = { msg in print(msg) }
        SGDLogger.defaultLogger.outputLogLevel = .Warning
        SGDLogger.defaultLogger.showDate(true, logLevel: false, fileInfo: false, functionName: true)

        SGDLogger.verbose("verbose log")
        SGDLogger.debug("debug log")
        SGDLogger.info("info log")
        SGDLogger.warning("warning log")
        SGDLogger.error("error log")
        print("")

        SGDLogger.defaultLogger.showColor = false

        SGDLogger.verbose("verbose log")
        SGDLogger.debug("debug log")
        SGDLogger.info("info log")
        SGDLogger.warning("warning log")
        SGDLogger.error("error log")
        print("")

        SGDLogger.defaultLogger.outputLogLevel = .Debug
        // contained color=true
        SGDLogger.defaultLogger.showDate(true, logLevel: true, fileInfo: false, functionName: true)

        SGDLogger.verbose("verbose log")
        SGDLogger.debug("debug log")
        SGDLogger.info("info log")
        SGDLogger.warning("warning log")
        SGDLogger.error("error log")
        print("")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
