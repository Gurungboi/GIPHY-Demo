//
//  GiphyTemplateRepresentable.swift
//  SwiftUI-Giphy
//
//  Created by Sunil Gurung on 15/8/2022.
//

import SwiftUI
import GiphyUISDK

struct GiphyTemplateRepresentable : UIViewControllerRepresentable {
    public typealias UIViewControllerType = GiphyViewController
    
    var mediaDetail: (String,String) -> Void
//    var onShouldDismissGifPicker: () -> Void
    var apiKey: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<GiphyTemplateRepresentable>) -> GiphyViewController {
        let giphyVC = GiphyViewController()
        giphyVC.setAPIKey(self.apiKey)
        giphyVC.delegate = context.coordinator
        giphyVC.mediaTypeConfig = [.gifs, .stickers, .text, .emoji, .recents]
        giphyVC.theme = CustomGiphyTheme()
        GiphyViewController.trayHeightMultiplier = 1.0
        giphyVC.swiftUIEnabled = true
        return giphyVC
    }
    
    public func updateUIViewController(_ giphyViewController: GiphyViewController, context: UIViewControllerRepresentableContext<GiphyTemplateRepresentable>) {
        // TODO:
    }
    
    class Coordinator: NSObject, GiphyDelegate {
        let parent: GiphyTemplateRepresentable
        init(_ parent: GiphyTemplateRepresentable) {
            self.parent = parent
        }
        
        func didSearch(for term: String) {
            print("Search for: ", term)
        }
        
        func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
            self.parent.mediaDetail(media.id, media.url)
        }
        
        func didDismiss(controller: GiphyViewController?) {
//            self.parent.onShouldDismissGifPicker()
        }
    }
}

public class CustomGiphyTheme: GPHTheme {
    public override init() {
        super.init()
        self.type = .darkBlur
    }
    
    public override var textFieldFont: UIFont? {
        return UIFont(name: "Futura-Medium", size: 15)
    }

    public override var textColor: UIColor {
        return .white
    }
}
