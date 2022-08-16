//
//  GiphySearchRepresentable.swift
//  SwiftUI-Giphy
//
//  Created by Sunil Gurung on 15/8/2022.
//

import SwiftUI
import GiphyUISDK

struct GiphySearchRepresentable : UIViewControllerRepresentable {
    
   
    public typealias UIViewControllerType = GiphySearchController
    var mediaDetail: (String,String) -> Void

    let view: UIView = UIView()
    let giphSearchVC = GiphySearchController()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<GiphySearchRepresentable>) -> GiphySearchController {
        self.giphSearchVC.delegate = context.coordinator
        self.giphSearchVC.hidesBottomBarWhenPushed = true
        self.giphSearchVC.tabBarItem = .none
        self.giphSearchVC.mediaTypeConfig = []
        return giphSearchVC
    }

    func updateUIViewController(_ uiViewController: GiphySearchController,
                                context: UIViewControllerRepresentableContext<GiphySearchRepresentable>) {
        uiViewController.theme = GPHTheme(type: .automatic)
    }
    
    
    class Coordinator: NSObject, GiphyDelegate, GPHGridDelegate {

        let parent: GiphySearchRepresentable
        
        init(_ parent: GiphySearchRepresentable) {
            self.parent = parent
        }
        
        func didSearch(for term: String) {
            print("Search for: ", term)
            
        }
        
        func didDismiss(controller: GiphyViewController?) {
            // Empty for now
        }
        
        func contentDidUpdate(resultCount: Int, error: Error?) {
            print("Result count: ", resultCount)
        }
        
        func didSelectMedia(media: GPHMedia, cell: UICollectionViewCell) {
            parent.mediaDetail(media.id, media.url)
        }
        
        func didSelectMoreByYou(query: String) {
            print("Search for: ", query)

        }
        
        func didScroll(offset: CGFloat){
            // Empty for now
        }

        
    }
}

