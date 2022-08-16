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

    var body: some View {
        CustomSearchBar(text: $searchText)

//        GiphySearchRepresentable(mediaDetail: { mediaID, mediaURL in
//            print("You have media id is \(mediaID) and its url is \(mediaURL)")
//        })
//        GiphyTemplateRepresentable(mediaDetail: { mediaID, mediaURL in
//            print("You have media id is \(mediaID) and its url is \(mediaURL)")
//        }, apiKey: "Enter your API KEY")

        GiphyGridRepresentable(mediaDetail: { mediaID, mediaURL in
            print("You have media id is \(mediaID) and its url is \(mediaURL)")
        }, apiKey: "Enter your API KEY", searchText: $searchText)
        .padding(.horizontal,8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
