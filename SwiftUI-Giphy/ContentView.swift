//
//  ContentView.swift
//  SwiftUI-Giphy
//
//  Created by Sunil Gurung on 5/8/2022.
//

import Foundation
import SwiftUI
import UIKit
import GiphyUISDK

struct ContentView: View {

    @State private var searchText = ""
    @State private var contentType: GiphyUISDK.GPHContent = .trendingGifs
    @State private var mediaType: GiphyUISDK.GPHMediaType = .gif

    var body: some View {
        CustomSearchBar(text: $searchText)
        CategoryView(contentType: $contentType, mediaType: $mediaType)
//        GiphySearchRepresentable(mediaDetail: { mediaID, mediaURL in
//            print("You have media id is \(mediaID) and its url is \(mediaURL)")
//        })
//        GiphyTemplateRepresentable(mediaDetail: { mediaID, mediaURL in
//            print("You have media id is \(mediaID) and its url is \(mediaURL)")
//        }, apiKey: "Enter your API KEY")

        GiphyGridRepresentable(apiKey: "Enter your API KEY",
                               numberOfTrack: 2,
                               searchText: $searchText,
                               contentType: $contentType,
                               mediaType: $mediaType,
                               mediaDetail: {mediaID, mediaURL in
            print("You have media id is \(mediaID) and its url is \(mediaURL)")
        })
        .padding(.horizontal,8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
