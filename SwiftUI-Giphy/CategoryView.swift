//
//  CategoryView.swift
//  SwiftUI-Giphy
//
//  Created by Sunil Gurung on 16/8/2022.
//

import SwiftUI
import GiphyUISDK

struct CategoryView: View {

    @Binding var contentType: GiphyUISDK.GPHContent
    @Binding var mediaType: GiphyUISDK.GPHMediaType

    var body: some View {
        HStack {
            Button {
                self.contentType = GPHContent.trendingGifs
                self.mediaType = GPHMediaType.gif
            } label: {
                Label("GIF", systemImage: "pencil")
            }
            
            Button {
                self.contentType = GPHContent.trendingStickers
                self.mediaType = GPHMediaType.sticker
            } label: {
                Label("Sticker", systemImage: "pencil")
            }

            
            Button {
                self.contentType = GPHContent.trendingVideo
                self.mediaType = GPHMediaType.video
            } label: {
                Label("Video", systemImage: "pencil")
            }

            
            Button {
                self.contentType = GPHContent.trendingText
                self.mediaType = GPHMediaType.text
            } label: {
                Label("Text", systemImage: "pencil")
            }
        }

    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(contentType: .constant(.trendingGifs),
                     mediaType: .constant(.gif))
    }
}
