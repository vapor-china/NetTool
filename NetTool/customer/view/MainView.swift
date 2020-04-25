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

    @State var menuTypes = textTypes
    
    @State private var dataCenter = FormatConvertCenter()
    
    
    var body: some View {
        VStack {
            Text("数据格式转换")
                .font(.largeTitle)
                .padding()
            
            HSplitView {
                InputView(inputValue: $dataCenter.inputValue, menus: $menuTypes, selectTextType: $dataCenter.inputType, title: dataCenter.inputTitle, commitEvent: dataCenter.formatSignal)
            
                
            
                InputView(inputValue: $dataCenter.outputValue, menus: $menuTypes, selectTextType: $dataCenter.outputType, title: dataCenter.outputTitle, commitEvent: nil)
                
            }
        }
    }
    
    
}
