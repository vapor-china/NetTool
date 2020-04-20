//
//  ContentView.swift
//  NetTool
//
//  Created by xj on 2020/4/17.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import SwiftUI
import Combine

class FormatConvertCenter {

    
    
//    var inputType = CurrentValueSubject<TextType, Error>(.json
//    )
    @State var outputType: TextType = .json
    @State var inputType: TextType = .json
    
    @State var inputValue: String = "" {
        didSet {
            formatOutput()
        }
    }
    @State var outputValue: String = ""
    
    @State var inputTitle = "输入"
    @State var outputTitle = "输出"
    
    var cacelable: Cancellable!
    let formatSignal = PassthroughSubject<String, Never>()
    
    init() {
        
        
       cacelable = formatSignal.sink { str in
//            self.formatOutput()
        self.inputValue = str
        }
//        cacelable = cancel1

        
        
    }

    
    func formatOutput() {
        print("format")
        print("----- \(inputValue)")
    }
    
//    init(inputType: TextType, inputValue: String, )
}

struct ContentView: View {

    @State var menuTypes = textTypes
    
    private var dataCenter = FormatConvertCenter()
    
    
    var body: some View {
        VStack {
            Text("数据格式转换")
                .font(.largeTitle)
                .padding()
            
            HSplitView {
                InputView(inputValue: dataCenter.$inputValue, menus: $menuTypes, selectTextType: dataCenter.inputType, title: dataCenter.inputTitle, commitEvent: dataCenter.formatSignal)
                
            
                InputView(inputValue: dataCenter.$outputValue, menus: $menuTypes, selectTextType: dataCenter.outputType, title: dataCenter.outputTitle, commitEvent: nil)
                
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
