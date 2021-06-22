//
//  DragDropImageView.swift
//  OCRCode
//
//  Created by Ege Kaan Gürkan on 16.06.2021.
//

import SwiftUI

struct DragDropImageView: View {
    @State var image = NSImage(named: "")
    @Binding var recognizedStrings: [String]
    @State private var dragOver = false
    
    var ocr = OCRUtil()

    var body: some View {
        VStack (spacing: 10) {
            ZStack {
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            Text("Drop an Image")
                .font(.title2)
                .bold()
        }
        .cornerRadius(3.0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hexString: "#FFFFFF08"))
        .onDrop(of: ["public.file-url"], isTargeted: $dragOver) { providers -> Bool in
            providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                if let data = data, let path = NSString(data: data, encoding: 4), let url = URL(string: path as String) {
                    let image = NSImage(contentsOf: url)
                    DispatchQueue.main.async {
                        self.image = image
                        self.recognizedStrings = ocr.getStrings(image: image!)
                    }
                }
            })
            return true
        }
        .onDrag {
            let data = self.image?.tiffRepresentation
            let provider = NSItemProvider(item: data as NSSecureCoding?, typeIdentifier: kUTTypeTIFF as String)
            provider.previewImageHandler = { (handler, _, _) -> Void in
                handler?(data as NSSecureCoding?, nil)
            }
            return provider
        }
        .cornerRadius(10.0)
        .overlay(dragOver ? RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color(hexString: "#FFFFFF0F")) : nil)
        
    }
}

struct DragDropImageView_Previews: PreviewProvider {
    static var previews: some View {
        DragDropImageView(recognizedStrings: .constant(["asasdfd"]))
    }
}
