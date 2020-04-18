//
//  ContentView.swift
//  NetTool
//
//  Created by xj on 2020/4/17.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import SwiftUI

struct FormatConvertCenter {
    
}

struct ContentView: View {
    
    @State var leftInputValue: String = "left"
    @State var rightInputValue: String = "right"
    @State var types = textTypes
    
    @State var inputValue = ""
    @State var outputValue = ""
    
    @State var menuTypes = textTypes
    @State var inputType = TextType.dic
    @State var outputType = TextType.dic
    
    
    var body: some View {
        VStack {
            Text("数据格式转换")
                .font(.largeTitle)
                .padding()
            
            HSplitView {
                InputView(inputValue: $inputValue, menus: $menuTypes, selectTextType: $inputType, title: "输入")
                
                InputView(inputValue: $outputValue, menus: $menuTypes, selectTextType: $outputType, title: "输出")
                
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
