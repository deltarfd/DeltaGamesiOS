//
//  GameCardView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct GameCardView: View {
  public init(game: GameModel) {
      self.game = game
  }
  
  var game: GameModel
    
  var body: some View {
    VStack(alignment: .leading) {
        HStack {
            Text("⭐️ \(game.rating.formattedRating())")
                .font(Font.caption.weight(.bold))
                .foregroundColor(.primary)
            Spacer()
            Text(game.released ?? "-")
                .font(Font.caption.weight(.bold))
                .foregroundColor(.primary)
        }
        Spacer()
      Text(game.name)
            .font(.title3)
            .fontWeight(.black)
            .foregroundColor(.primary)
            .lineLimit(2)
      Text((game.parentPlatforms ?? []).map { $0.platform.name }.joined(separator: ", "))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(2)
    }.padding()
        .background(
          RemoteImageView(
            url: URL(string: game.imageBackground ?? "https://i.ibb.co/1GcrfqQ/img-error.png"),
            contentMode: .fill
          ) {
            ZStack {
              Color(.systemGray5)
              ProgressView()
            }
          }
          .opacity(0.75))
        .clipped()
        .cornerRadius(24)
        .contentShape(Rectangle())
  }
    
}
