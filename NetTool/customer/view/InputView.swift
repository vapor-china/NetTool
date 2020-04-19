//
//  InputView.swift
//  NetTool
//
//  Created by xj on 2020/4/17.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import SwiftUI
import AppKit

struct InputView: View {
    
    @State var inputValue: String
    @Binding var menus: [TextType]
    @State var selectTextType: TextType
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.title)
                .padding()
            
            MenuButton(label: Text(selectTextType.showText)) {
                ForEach(menus, id: \.self) { item in
                    Button(action: {
                        self.selectTextType = item
                    }) {
                        Text(item.showText)
                    }
                }
            }.frame(minWidth: 50, maxWidth: 200)
                .padding()
            
            MacEditorTextView(text: $inputValue, onEditingChanged: {
                print("editing - " + self.inputValue)
            }, onCommit: {
                print("commit - " + self.inputValue)
            }) { (textChange) in
                print("chagned - " + textChange)
            }.padding().frame(minWidth: 300,
            maxWidth: .infinity,
            minHeight: 300,
            maxHeight: .infinity)
                
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    
    @State static var text = ""
    @State static var menus = [TextType.dic]
    @State static var selType  = TextType.dic
    @State static var title = ""
    
    static var previews: some View {
        InputView(inputValue: text, menus: $menus, selectTextType: selType, title: title)
    }
}
