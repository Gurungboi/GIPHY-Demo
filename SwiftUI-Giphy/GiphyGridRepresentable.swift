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
    var apiKey: String
    var cellPadding: CGFloat
    var direction: UICollectionView.ScrollDirection
    var numberOfTrack: Int
    var backgroundColor: UIColor
    var fixedSizeCell: Bool
    var mediaDetail: (String,String) -> Void

    @Binding var searchText: String
    @Binding var contentType: GiphyUISDK.GPHContent
    @Binding var mediaType: GiphyUISDK.GPHMediaType

    init(apiKey: String,
         cellPadding: CGFloat = 8.0,
         direction: UICollectionView.ScrollDirection = .vertical,
         numberOfTrack: Int = 3,
         backgroundColor: UIColor = UIColor.white,
         fixedSizeCell: Bool =  true,
         searchText: Binding<String>,
         contentType: Binding<GiphyUISDK.GPHContent>,
         mediaType: Binding<GiphyUISDK.GPHMediaType>,
         mediaDetail: @escaping (String, String) -> Void) {
        self.apiKey = apiKey
        self.cellPadding = cellPadding
        self.direction = direction
        self.numberOfTrack = numberOfTrack
        self.backgroundColor = backgroundColor
        self.fixedSizeCell = fixedSizeCell
        self._searchText = searchText
        self._contentType = contentType
        self._mediaType = mediaType
        self.mediaDetail = mediaDetail
    }


    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<GiphyGridRepresentable>) -> GiphyGridController {
        self.giphyVC.setAPIKey(self.apiKey)
        self.giphyVC.delegate = context.coordinator

        self.giphyVC.cellPadding = self.cellPadding
        self.giphyVC.direction = self.direction
        self.giphyVC.numberOfTracks = self.numberOfTrack
        self.giphyVC.view.backgroundColor = self.backgroundColor
        self.giphyVC.fixedSizeCells = self.fixedSizeCell
        self.giphyVC.update()
        return giphyVC
    }

    func updateUIViewController(_ uiViewController: GiphyGridController,
                                context: UIViewControllerRepresentableContext<GiphyGridRepresentable>) {
        uiViewController.theme = GPHTheme(type: .automatic)
        if $searchText.wrappedValue.isEmpty {
            uiViewController.content = $contentType.wrappedValue
        } else {
            uiViewController.content = GPHContent.search(withQuery: $searchText.wrappedValue, mediaType: $mediaType.wrappedValue, language: .english)
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

