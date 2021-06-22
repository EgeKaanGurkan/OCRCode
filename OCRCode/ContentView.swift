//
//  ContentView.swift
//  OCRCode
//
//  Created by Ege Kaan Gürkan on 16.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var recognizedStrings: [String] = []
    
    var body: some View {
        
        if (recognizedStrings.isEmpty) {
            DragDropImageView(recognizedStrings: $recognizedStrings)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.all)
                .onChange(of: recognizedStrings, perform: { value in
                    print(value)
                })
        } else {
            VStack {
                TextEditor(text: .constant(recognizedStrings.joined(separator: "\n")))
                    .padding()
                    .font(.system(.body, design: .monospaced))
                
                HStack {
                    Button(action: {
                        recognizedStrings = []
                    }, label: {
                        Text("Try Another")
                    })
                    .padding()
                    Spacer()
                    Button(action: {
                        let pasteBoard = NSPasteboard.general
                        pasteBoard.clearContents()
                        pasteBoard.setString(recognizedStrings.joined(separator: "\n"), forType: .string)
                    }, label: {
                        Text("Copy")
                    })
                    .padding()
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
