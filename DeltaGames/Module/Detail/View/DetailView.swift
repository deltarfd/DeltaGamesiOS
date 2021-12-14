//
//  DetailView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter

  var body: some View {
    
    if presenter.loadingState {
      ProgressView()
    } else if presenter.errorMessage != "" {
      Text(presenter.errorMessage)
    } else {
      detailView
    }
  }
}

extension DetailView {
    var detailView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                  WebImage(url: URL(string: presenter.game.imageBackground != nil ? presenter.game.imageBackground ?? "" : "https://i.ibb.co/1GcrfqQ/img-error.png"))
                    .resizable()
                    .indicator(Indicator {_, _ in ProgressView()})
                    .opacity(0.75)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    Button {
                        if presenter.isFav {
                          presenter.delFavGame(from: "\(presenter.game.id)")
                        } else {
                          presenter.addFavGame(from: GameModel(id: presenter.game.id,
                                                               slug: presenter.game.slug,
                                                               name: presenter.game.name,
                                                               description: presenter.game.description,
                                                               released: presenter.game.released ?? "-",
                                                               imageBackground: presenter.game.imageBackground != nil ? presenter.game.imageBackground ?? "" : "https://i.ibb.co/1GcrfqQ/img-error.png",
                                                               rating: presenter.game.rating!,
                                                               ratingTop: presenter.game.ratingTop!,
                                                               ratingsCount: presenter.game.ratingsCount!,
                                                               genres: presenter.game.genres,
                                                               parentPlatforms: presenter.game.parentPlatforms,
                                                               tags: presenter.game.tags
                                                          ))
                        }
                    } label: {
                      Image(systemName: presenter.isFav ? "heart.circle.fill" : "heart.circle").font(.system(size: 36))
                            .foregroundColor(presenter.isFav ? .pink : .white)
                            .padding()
                    }
                }
                HStack {
                    Text(presenter.game.name)
                        .padding()
                        .font(Font.title2.weight(.bold))
                        .lineLimit(2)
                    Spacer(minLength: 10)
                    Label("\(String(format: "%.2f", presenter.game.rating ?? 0.0))/5", systemImage: "star.fill")
                        .padding(.horizontal)
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                }
                Text("Released: \(presenter.game.released ?? "-")")
                    .padding(.horizontal)
                    .font(.caption)
                    .foregroundColor(Color("PrimaryColor"))
              Text(presenter.game.parentPlatforms!.reduce("", { $0 + "\($1.platform.name), " }))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                    .foregroundColor(Color.gray)
                Text(presenter.game.genres!.reduce("", { $0 + "\($1.name), " }))
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Tags: " + presenter.game.tags!.reduce("", { $0 + "\($1.name), " }))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                Text("Description")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                Text(removeHTML(string: presenter.game.description!))
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
