//
// Formatter.swift
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

public enum Component {
    case Date(String)
    case Message
    case Level
    case File(fullPath: Bool, fileExtension: Bool)
    case Line
    case Column
    case Function
    case Location
    case Block(() -> Any?)
}

public class Formatters {}

public class Formatter: Formatters {
    /// The formatter format.
    private var format: String
    
    /// The formatter components.
    private var components: [Component]
    
    /// The date formatter.
    private let dateFormatter = NSDateFormatter()
    
    /// The formatter logger.
    internal weak var logger: Logger!
    
    /// The formatter textual representation.
    internal var description: String {
        return String(format: format, arguments: components.map { (component: Component) -> CVarArgType in
            return String(component).uppercaseString
        })
    }
    
    /**
     Creates and returns a new formatter with the specified format and components.
     
     - parameter format:     The formatter format.
     - parameter components: The formatter components.
     
     - returns: A newly created formatter.
     */
    public convenience init(_ format: String, _ components: Component...) {
        self.init(format, components)
    }
    
    /**
     Creates and returns a new formatter with the specified format and components.
     
     - parameter format:     The formatter format.
     - parameter components: The formatter components.
     
     - returns: A newly created formatter.
     */
    public init(_ format: String, _ components: [Component]) {
        self.format = format
        self.components = components
    }
    
    /**
     Formats a string with the formatter format and components.
     
     - parameter level:      The severity level.
     - parameter items:      The items to format.
     - parameter separator:  The separator between the items.
     - parameter terminator: The terminator of the formatted string.
     - parameter file:       The log file path.
     - parameter line:       The log line number.
     - parameter column:     The log column number.
     - parameter function:   The log function.
     - parameter date:       The log date.
     
     - returns: A formatted string.
     */
    internal func format(level level: Level, items: [Any], separator: String, terminator: String, file: String, line: Int, column: Int, function: String, date: NSDate) -> String {
        let arguments = components.map { (component: Component) -> CVarArgType in
            switch component {
            case .Date(let dateFormat):
                return format(date: date, dateFormat: dateFormat)
            case .File(let fullPath, let fileExtension):
                return format(file: file, fullPath: fullPath, fileExtension: fileExtension)
            case .Function:
                return String(function)
            case .Line:
                return String(line)
            case .Column:
                return String(column)
            case .Level:
                return format(level: level)
            case .Message:
                return items.map({ String($0) }).joinWithSeparator(separator)
            case .Location:
                return format(file: file, line: line)
            case .Block(let block):
                return block().flatMap({ String($0) }) ?? ""
            }
        }
        
        return String(format: format, arguments: arguments) + terminator
    }
}

private extension Formatter {
    /**
     Formats a date with the specified date format.
     
     - parameter date:       The date.
     - parameter dateFormat: The date format.
     
     - returns: A formatted date.
     */
    func format(date date: NSDate, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(date)
    }
    
    /**
     Formats a file path with the specified parameters.
     
     - parameter file:          The file path.
     - parameter fullPath:      Whether the full path should be included.
     - parameter fileExtension: Whether the file extension should be included.
     
     - returns: A formatted file path.
     */
    func format(file file: String, fullPath: Bool, fileExtension: Bool) -> String {
        var file = file
        
        if !fullPath      { file = file.lastPathComponent }
        if !fileExtension { file = file.stringByDeletingPathExtension }
        
        return file
    }
    
    /**
     Formats a Location component with a specified file path and line number.
     
     - parameter file: The file path.
     - parameter line: The line number.
     
     - returns: A formatted Location component.
     */
    func format(file file: String, line: Int) -> String {
        return [
            format(file: file, fullPath: false, fileExtension: true),
            String(line)
        ].joinWithSeparator(":")
    }
    
    /**
     Formats a Level component.
     
     - parameter level: The Level component.
     
     - returns: A formatted Level component.
     */
    func format(level level: Level) -> String {
        let text = level.description
        
        if let color = logger.theme?.colors[level] {
            return text.withColor(color)
        }
        
        return text
    }
}

internal extension String {
    /// The last path component of the receiver.
    var lastPathComponent: String {
        return NSString(string: self).lastPathComponent
    }
    
    /// A new string made by deleting the extension from the receiver.
    var stringByDeletingPathExtension: String {
        return NSString(string: self).stringByDeletingPathExtension
    }
    
    /**
     Returns a string colored with the specified color.
     
     - parameter color: The string representation of the color.
     
     - returns: A string colored with the specified color.
     */
    func withColor(color: String) -> String {
        return "\u{001b}[fg\(color);\(self)\u{001b}[;"
    }
}