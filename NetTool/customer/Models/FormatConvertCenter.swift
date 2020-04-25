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
        case .dic:
            break
        case .dicSwift:
            break
        case .json:
            jsonPut()
        case .urlEncode:
            break
        }
        
        //        outputValue = inputValue
    }
    
    func jsonPut() {
        
        if inputValue.isJsonStr() {
            
            guard inputValue.isJsonDic() else {
                // 不是键值对数据 无法数据格式转换
                return
            }
            
            switch outputType {
            case .json:
                
                let jsonDic = inputValue.toJsonDic()
                print(jsonDic)
                if outputType == .json {
                    outputValue = inputValue.toJsonStr(true)
                }
                
            case .dicSwift:
                
                let jsonDic = inputValue.toJsonDic()
                print(jsonDic)
                if outputType == .json {
                    outputValue = inputValue.toJsonStr(true)
                }
                
            case .dic:
                let jsonDic = inputValue.toJsonDic()
                print(jsonDic)
                if outputType == .json {
                    outputValue = inputValue.toJsonStr(true)
                }
            case .urlEncode:
                let jsonDic = inputValue.toJsonDic()
                print(jsonDic)
                if outputType == .json {
                    outputValue = inputValue.toJsonStr(true)
                }
            }
            
        } else {
            // json str valid failed
        }
    }
    
    
}



