//
//  MainView.swift
//  NetTool
//
//  Created by xj on 2020/4/25.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {

    @State var outputMenus = textTypes
    @State var inputMenus = inputTypes
    
    @ObservedObject private var dataCenter = FormatConvertCenter()
    
    
    var body: some View {
        VStack {
            Text("数据格式转换")
                .font(.largeTitle)
                .padding()
            
            HSplitView {
                InputView(inputValue: $dataCenter.inputValue, menus: $inputMenus, selectTextType: $dataCenter.inputType, isEditable: Binding.constant(true), title: dataCenter.inputTitle, commitEvent: dataCenter.formatSignal)
                InputView(inputValue: $dataCenter.outputValue, menus: $outputMenus, selectTextType: $dataCenter.outputType, isEditable: Binding.constant(false), title: dataCenter.outputTitle, commitEvent: nil)
                
            }
        }
    }
    
    
}
