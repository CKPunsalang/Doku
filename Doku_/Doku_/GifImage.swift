//
//  GifImage.swift
//  Doku_
//
//  Created by Calla Punsalang on 11/15/24.
//
//  This Swift code was written based on a Swift Tutorial by "Swift and Tips"
//  https://www.youtube.com/watch?v=9fz8EW-dX-I&t=332s 

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    
    init (_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")
        let data = try! Data(contentsOf: url!)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url!.deletingLastPathComponent()
        )
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

#Preview {
    GifImage("congrats")
}
