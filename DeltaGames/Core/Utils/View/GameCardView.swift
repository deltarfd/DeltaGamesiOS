//
//  GameCardView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCardView: View {
  public init(game: GameModel) {
      self.game = game
  }
  
  var game: GameModel
    
  var body: some View {
    VStack(alignment: .leading) {
        HStack {
            Text("⭐️ \(String(format: "%.2f", game.rating ?? 0.0))/5")
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
      Text(game.parentPlatforms != nil ? game.parentPlatforms!.reduce("", { $0 + "\($1.platform.name), " }) : "")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(2)
    }.padding()
        .background(
          WebImage(url: URL(string: game.imageBackground != nil ? game.imageBackground! : "https://i.ibb.co/1GcrfqQ/img-error.png"))
                .resizable()
                .indicator(Indicator {_, _ in ProgressView()})
                .scaledToFill()
                .opacity(0.75))
        .cornerRadius(24)
  }
    
}
