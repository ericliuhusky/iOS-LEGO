//
//  LargeImageDownsizingApp.swift
//  LargeImage
//
//  Created by lzh on 2022/6/17.
//

import SwiftUI

@main
struct LargeImageDownsizingApp: App {
    var body: some Scene {
        WindowGroup {
            UIKitViewController()
        }
    }
}

struct UIKitViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = LargeImageDownsizingViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
