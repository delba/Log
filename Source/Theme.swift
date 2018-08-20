//
// Theme.swift
//
// Copyright (c) 2015-2016 Damien (http://delba.io)
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

public class Themes {}

public class Theme: Themes {

    /// Style object to hold color and emoji for each level.
    public struct Style {

        /// Color for the syyle.
        public let color: String?
        /// Emoji for the style.
        public let emoji: String

        /**
         Creates and returns a style with the specified color or/and emoji.

         - parameter coloe:   The color for the style.
         - parameter debug:   The emoji for the style.

         - returns: A style with the specified color or/and emoji.
         */
        public init(color: String? = nil, emoji: String? = nil) {

            self.color = color
            if let emoji = emoji {
                self.emoji = emoji + " "
            } else {
                self.emoji = ""
            }
        }
    }

    /// The theme styles.
    private var styles: [Level: Style]

    /**
     Returns style for the specified level.

     - parameter level:   The level for which style needs to be selected.

     - returns: A style for specific level.
     */
    internal func style(for level: Level) -> Style? {
        return styles[level]
    }

    /// The theme textual representation.
    internal var description: String {
        return styles.keys.sorted().map {
            var string = (styles[$0]?.emoji ?? "") + $0.description
            if let color = styles[$0]?.color {
                string = string.withColor(color)
            }
            return string
        }.joined(separator: " ")
    }
    
    /**
     Creates and returns a theme with the specified colors.
     
     - parameter trace:   The color for the trace level.
     - parameter debug:   The color for the debug level.
     - parameter info:    The color for the info level.
     - parameter warning: The color for the warning level.
     - parameter error:   The color for the error level.
     
     - returns: A theme with the specified colors.

     - note: Deprecated. Use `init( trace: Style, debug: Style, info: Style, warning: Style, error: Style)` instead.
     */
    @available(*, deprecated)
    public init(trace: String, debug: String, info: String, warning: String, error: String) {

        self.styles = [
            .trace:   Style(color: Theme.formatHex(trace)),
            .debug:   Style(color: Theme.formatHex(debug)),
            .info:    Style(color: Theme.formatHex(info)),
            .warning: Style(color: Theme.formatHex(warning)),
            .error:   Style(color: Theme.formatHex(error))
        ]
    }

    /**
     Creates and returns a theme with the specified styles.

     - parameter trace:   The style for the trace level.
     - parameter debug:   The style for the debug level.
     - parameter info:    The style for the info level.
     - parameter warning: The style for the warning level.
     - parameter error:   The style for the error level.

     - returns: A theme with the specified styles.
     */
    public init(
        trace: Style,
        debug: Style,
        info: Style,
        warning: Style,
        error: Style
        ) {

        self.styles = [
            .trace: trace,
            .debug: debug,
            .info: info,
            .warning: warning,
            .error: error
        ]
    }

    /**
     Returns a string representation of the hex color.
     
     - parameter hex: The hex color.
     
     - returns: A string representation of the hex color.
     */
    private static func formatHex(_ hex: String) -> String {
        let scanner = Scanner(string: hex)
        var hex: UInt32 = 0
        
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hex)
        
        let r = (hex & 0xFF0000) >> 16
        let g = (hex & 0xFF00) >> 8
        let b = (hex & 0xFF)
        
        return [r, g, b].map({ String($0) }).joined(separator: ",")
    }
}
