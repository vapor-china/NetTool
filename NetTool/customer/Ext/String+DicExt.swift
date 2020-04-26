//
//  String+DicExt.swift
//  NetTool
//
//  Created by xj on 2020/4/26.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    func toSwiftDic() -> String {
        var dicSwift = "[\n"
        for (key, value) in self {
            dicSwift += "\(key): \(value) \n"
        }
        dicSwift += "]"
        return dicSwift
    }
    
    func toFormatUrlencode() -> String {
        
        var paramstr = ""
        for (key, value) in self {
            paramstr += "\(key)=\(value)&"
        }
        let char = paramstr.dropLast()
        return String(char)
    }
}
