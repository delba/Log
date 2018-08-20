//
// Themes.swift
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

extension Themes {
    public static let `default` = Theme(
        trace:   Theme.Style(color: "#C8C8C8"),
        debug:   Theme.Style(color: "#0000FF"),
        info:    Theme.Style(color: "#00FF00"),
        warning: Theme.Style(color: "#FFFB00"),
        error:   Theme.Style(color: "#FF0000")
    )
    
    public static let dusk = Theme(
        trace:   Theme.Style(color: "#FFFFFF"),
        debug:   Theme.Style(color: "#526EDA"),
        info:    Theme.Style(color: "#93C96A"),
        warning: Theme.Style(color: "#D28F5A"),
        error:   Theme.Style(color: "#E44347")
    )
    
    public static let midnight = Theme(
        trace:   Theme.Style(color: "#FFFFFF"),
        debug:   Theme.Style(color: "#527EFF"),
        info:    Theme.Style(color: "#08FA95"),
        warning: Theme.Style(color: "#EB905A"),
        error:   Theme.Style(color: "#FF4647")
    )
    
    public static let tomorrow = Theme(
        trace:   Theme.Style(color: "#4D4D4C"),
        debug:   Theme.Style(color: "#4271AE"),
        info:    Theme.Style(color: "#718C00"),
        warning: Theme.Style(color: "#EAB700"),
        error:   Theme.Style(color: "#C82829")
    )
    
    public static let tomorrowNight = Theme(
        trace:   Theme.Style(color: "#C5C8C6"),
        debug:   Theme.Style(color: "#81A2BE"),
        info:    Theme.Style(color: "#B5BD68"),
        warning: Theme.Style(color: "#F0C674"),
        error:   Theme.Style(color: "#CC6666")
    )
    
    public static let tomorrowNightEighties = Theme(
        trace:   Theme.Style(color: "#CCCCCC"),
        debug:   Theme.Style(color: "#6699CC"),
        info:    Theme.Style(color: "#99CC99"),
        warning: Theme.Style(color: "#FFCC66"),
        error:   Theme.Style(color: "#F2777A")
    )
    
    public static let tomorrowNightBright = Theme(
        trace:   Theme.Style(color: "#EAEAEA"),
        debug:   Theme.Style(color: "#7AA6DA"),
        info:    Theme.Style(color: "#B9CA4A"),
        warning: Theme.Style(color: "#E7C547"),
        error:   Theme.Style(color: "#D54E53")
    )

    public static let emojiHearts = Theme(
        trace: Theme.Style(emoji: "💚"),
        debug: Theme.Style(emoji: "🖤"),
        info: Theme.Style(emoji: "💙"),
        warning: Theme.Style(emoji: "💛"),
        error: Theme.Style(emoji: "❤️")
    )
}
