//
//  String+FormUrl.swift
//  NetTool
//
//  Created by xj on 2020/4/28.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

extension String {
    
    func isFormUrl() -> Bool {
        if contains("&") || contains("%26") {
            return true
        }
            return false
    }
    
    func formDic() -> [String: Any] {
        var kVarray = self.components(separatedBy: "&")
        if kVarray.isEmpty {
            kVarray = self.components(separatedBy: "%26")
        }
        
        var dic = [String: Any]()
        for value in kVarray {
           let valueArr = value.components(separatedBy: "=")
            if valueArr.count == 2 {
                dic[valueArr[0]] = valueArr[1]
            }
        }
        
        return dic
    }
}
