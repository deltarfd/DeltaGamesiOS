//
//  GameDetailView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    @ObservedObject var detailViewModel: DetailViewModel
    let id: Int
    var body: some View {
        switch detailViewModel.state {
        case .loading:
            ProgressView()
                .onAppear {
                    detailViewModel.getDetailGame(id: id)
                }
        case .onSuccess:
            detailView
        case .onFailed(let message):
            Text(message)
        }
    }
}
extension GameDetailView {
    var detailView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: detailViewModel.detailGame?.backgroundImage != nil ? detailViewModel.detailGame?.backgroundImage ?? "" : "https://i.ibb.co/1GcrfqQ/img-error.png")!)
                    .resizable()
                    .indicator(Indicator {_, _ in ProgressView()})
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    Image(systemName: "heart.circle.fill").font(.system(size: 36))
                        .foregroundColor(Color.white)
                        .padding()
                }
                HStack {
                    Text(detailViewModel.detailGame!.name)
                        .padding()
                        .font(Font.title2.weight(.bold))
                        .lineLimit(2)
                    Spacer(minLength: 10)
                    Label("\(String(format: "%.2f", detailViewModel.detailGame!.rating ?? 0.0))/5", systemImage: "star.fill")
                        .padding(.horizontal)
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                }
                Text(detailViewModel.detailGame!.parentPlatforms!.reduce("", { $0 + "\($1.platform.name), " }))
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color.gray)
                Text(detailViewModel.detailGame!.genres!.reduce("", { $0 + "\($1.name), " }))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Tags: " + detailViewModel.detailGame!.tags!.reduce("", { $0 + "\($1.name), " }))
                    .padding(.horizontal)
                    .font(.headline)
                Text("Description")
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text(removeHTML(string: detailViewModel.detailGame!.description!))
                    .padding(.horizontal)
                    .font(.headline)
                Spacer()
            }
        }
    }
    func removeHTML(string: String) -> String {
        return (string.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
