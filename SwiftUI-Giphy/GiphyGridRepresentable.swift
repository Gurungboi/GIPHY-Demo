//
//  GiphyGridRepresentable.swift
//  SwiftUI-Giphy
//
//  Created by Sunil Gurung on 15/8/2022.
//

import UIKit
import SwiftUI
import GiphyUISDK

struct GiphyGridRepresentable : UIViewControllerRepresentable {
   
    public typealias UIViewControllerType = GiphyGridController
    var giphyVC = GiphyGridController()
    var mediaDetail: (String,String) -> Void
    var apiKey: String
    
    @Binding var searchText: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<GiphyGridRepresentable>) -> GiphyGridController {
        self.giphyVC.setAPIKey(self.apiKey)
        self.giphyVC.delegate = context.coordinator

        self.giphyVC.cellPadding = 8.0
        self.giphyVC.direction = .vertical
        self.giphyVC.numberOfTracks = 2
        self.giphyVC.view.backgroundColor = .white
        self.giphyVC.fixedSizeCells = true
        self.giphyVC.update()
        return giphyVC
    }

    func updateUIViewController(_ uiViewController: GiphyGridController,
                                context: UIViewControllerRepresentableContext<GiphyGridRepresentable>) {
        uiViewController.theme = GPHTheme(type: .automatic)
        if !$searchText.wrappedValue.isEmpty {
            uiViewController.content = GPHContent.search(withQuery: $searchText.wrappedValue, mediaType: .gif, language: .english)
        } else {
            uiViewController.content = GPHContent.trendingGifs
        }
        uiViewController.update()
    }
    
    
    class Coordinator: NSObject, GPHGridDelegate {
        let parent: GiphyGridRepresentable
        
        init(_ parent: GiphyGridRepresentable) {
            self.parent = parent
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

