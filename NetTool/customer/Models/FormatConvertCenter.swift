//
//  FormatConvertCenter.swift
//  NetTool
//
//  Created by xj on 2020/4/24.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import SwiftUI
import Combine


class FormatConvertCenter {
    var outputType: TextType = .json
    var inputType: TextType = .json
    
    var inputValue: String = ""
    var outputValue: String = ""
    
    var inputTitle = "输入"
    var outputTitle = "输出"
    
    var cacelable: Cancellable!
    let formatSignal = PassthroughSubject<String, Never>()
    
    init() {
        cacelable = formatSignal.sink { str in
            self.formatOutput()
        }
    }
    
    
    func formatOutput() {
        print("format")
        print("----- \(inputValue)")
        
        switch inputType {
        case .dicSwift:
            break
        case .json:
            jsonPut()
        case .urlEncode:
            break
        }
        
        //        outputValue = inputValue
    }
    
    
    
}

// MARK: - JSON input
extension FormatConvertCenter {
    
    func jsonPut() {
        
        if inputValue.isJsonStr() {
            
            guard inputValue.isJsonDic() else {
                // 不是键值对数据 无法数据格式转换
                return
            }
            switch outputType {
            case .json:
                    outputValue = inputValue.toJsonStr(true)
            case .dicSwift:
                let jsonDic = inputValue.toJsonDic()
                let dicSwift = jsonDic.toSwiftDic()
                outputValue = dicSwift
            case .urlEncode:
                let jsonDic = inputValue.toJsonDic()
                outputValue = jsonDic.toFormatUrlencode()
            }
            
        } else {
            // json str valid failed
        }
    }
}

// MARK: - urlEncode input
extension FormatConvertCenter {}

// MARK: - swift dic input
extension FormatConvertCenter {}
