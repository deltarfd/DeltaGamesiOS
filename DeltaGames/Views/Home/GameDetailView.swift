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
                    detailViewModel.gameFavorite(id: id)
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
                    .opacity(0.75)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    Button {
                        if detailViewModel.isFavorite {
                            detailViewModel.deleteGame(id: id)
                        } else {
                            detailViewModel.favoritedGame(id: detailViewModel.detailGame!.id,
                                                          name: detailViewModel.detailGame!.name,
                                                          backgroundImage: detailViewModel.detailGame?.backgroundImage != nil ? detailViewModel.detailGame?.backgroundImage ?? "" : "https://i.ibb.co/1GcrfqQ/img-error.png",
                                                          rating: detailViewModel.detailGame!.rating!,
                                                          released: detailViewModel.detailGame!.released ?? "-",
                                                          genres: detailViewModel.detailGame!.genres!.reduce("", { $0 + "\($1.name), " }))
                        }
                    } label: {
                        Image(systemName: detailViewModel.isFavorite ? "heart.circle.fill" : "heart.circle").font(.system(size: 36))
                            .foregroundColor(detailViewModel.isFavorite ? .pink : .white)
                            .padding()
                    }
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
                Text("Released: \(detailViewModel.detailGame!.released ?? "-")")
                    .padding(.horizontal)
                    .font(.caption)
                    .foregroundColor(Color("PrimaryColor"))
                Text(detailViewModel.detailGame!.parentPlatforms!.reduce("", { $0 + "\($1.platform.name), " }))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                    .foregroundColor(Color.gray)
                Text(detailViewModel.detailGame!.genres!.reduce("", { $0 + "\($1.name), " }))
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Tags: " + detailViewModel.detailGame!.tags!.reduce("", { $0 + "\($1.name), " }))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                Text("Description")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text(removeHTML(string: detailViewModel.detailGame!.description!))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                Spacer()
            }
        }
    }
    func removeHTML(string: String) -> String {
        return (string.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
