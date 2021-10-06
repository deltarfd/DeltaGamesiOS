//
//  GameCardView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCardView: View {
    
    var game: Game
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("⭐️ \(String(format: "%.2f", game.rating ?? 0.0))/5")
                    .font(Font.subheadline.weight(.bold))
                    .foregroundColor(.primary)
                Spacer()
                Button {
                    print("Button tapped")
                } label: {
                    Image(systemName: "heart.circle.fill").font(.system(size: 36))
                        .foregroundColor(Color.white)
                }
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
                WebImage(url: URL(string: game.backgroundImage != nil ? game.backgroundImage! : "https://i.ibb.co/1GcrfqQ/img-error.png"))
                    .resizable()
                    .indicator(Indicator {_, _ in ProgressView()})
                    .scaledToFill()
                    .opacity(0.75))
            .cornerRadius(24)
    }
    
}
