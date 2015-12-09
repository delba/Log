//
// Logger.swift
//
// Copyright (c) 2015 Damien (http://delba.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

public enum Level {
    case Trace, Debug, Info, Warning, Error
    
    var description: String {
        return String(self).uppercaseString
    }
}

extension Level: Comparable {}

public func ==(x: Level, y: Level) -> Bool {
    return x.hashValue == y.hashValue
}

public func <(x: Level, y: Level) -> Bool {
    return x.hashValue < y.hashValue
}

public class Logger {
    /// The logger state.
    public var enabled: Bool = true
    
    /// The logger formatter.
    public var formatter: Formatter {
        didSet { formatter.logger = self }
    }
    
    /// The logger theme.
    public var theme: Theme?
    
    /// The minimum level of severity.
    public var minLevel: Level
    
    /// The logger format.
    public var format: String {
        return formatter.description
    }
    
    /// The logger colors
    public var colors: String {
        return theme?.description ?? ""
    }
    
    /// The queue used for logging.
    private let queue = dispatch_queue_create("delba.log", DISPATCH_QUEUE_SERIAL)
    
    /**
     Creates and returns a new logger.
     
     - parameter formatter: The formatter.
     - parameter theme:     The theme.
     - parameter minLevel:  The minimum level of severity.
     
     - returns: A newly created logger.
     */
    public init(formatter: Formatter, theme: Theme? = nil, minLevel: Level = .Trace) {
        self.formatter = formatter
        self.theme = theme
        self.minLevel = minLevel
        
        formatter.logger = self
    }
    
    /**
     Logs a message with a trace severity level.
     
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    public func trace(items: Any..., separator: String = " ", terminator: String = "\n", file: String = __FILE__, line: Int = __LINE__, column: Int = __COLUMN__, function: String = __FUNCTION__) {
        log(.Trace, items, separator, terminator, file, line, column, function)
    }
    
    /**
     Logs a message with a debug severity level.
     
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    public func debug(items: Any..., separator: String = " ", terminator: String = "\n", file: String = __FILE__, line: Int = __LINE__, column: Int = __COLUMN__, function: String = __FUNCTION__) {
        log(.Debug, items, separator, terminator, file, line, column, function)
    }
    
    /**
     Logs a message with an info severity level.
     
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    public func info(items: Any..., separator: String = " ", terminator: String = "\n", file: String = __FILE__, line: Int = __LINE__, column: Int = __COLUMN__, function: String = __FUNCTION__) {
        log(.Info, items, separator, terminator, file, line, column, function)
    }
    
    /**
     Logs a message with a warning severity level.
     
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    public func warning(items: Any..., separator: String = " ", terminator: String = "\n", file: String = __FILE__, line: Int = __LINE__, column: Int = __COLUMN__, function: String = __FUNCTION__) {
        log(.Warning, items, separator, terminator, file, line, column, function)
    }
    
    /**
     Logs a message with an error severity level.
     
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    public func error(items: Any..., separator: String = " ", terminator: String = "\n", file: String = __FILE__, line: Int = __LINE__, column: Int = __COLUMN__, function: String = __FUNCTION__) {
        log(.Error, items, separator, terminator, file, line, column, function)
    }

    /**
     Logs a message.
     
     - parameter level:      The severity level.
     - parameter items:      The items to log.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the log message.
     - parameter file:       The file in which the log happens.
     - parameter line:       The line at which the log happens.
     - parameter column:     The column at which the log happens.
     - parameter function:   The function in which the log happens.
     */
    private func log(level: Level, _ items: [Any], _ separator: String, _ terminator: String, _ file: String, _ line: Int, _ column: Int, _ function: String) {
        guard enabled && level >= minLevel else { return }
        
        let date = NSDate()
        
        let result = formatter.format(
            level: level,
            items: items,
            separator: separator,
            terminator: terminator,
            file: file,
            line: line,
            column: column,
            function: function,
            date: date
        )
        
        dispatch_async(queue) {
            Swift.print(result, separator: "", terminator: "")
        }
    }
}

public let Log = Logger(formatter: .Default, theme: .Default)