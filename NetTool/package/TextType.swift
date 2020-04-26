//
//  TextType.swift
//  NetTool
//
//  Created by xj on 2020/4/18.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

enum TextType {
    
    case json
    case urlEncode
//    case dic
    case dicSwift
    
    var showText: String {
        switch self {
//        case .dic: return "Dictionary"
        case .dicSwift: return "Swift Dictionary"
        case .json: return "JSON"
        case .urlEncode: return "x-www-form-urlencoded"
        }
    }
}

let textTypes = [
    TextType.json,  .urlEncode, .dicSwift
]
