//
//  ProfileView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("bg_profile")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
            VStack(spacing: 15) {
                Image("deltarfd")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: UIScreen.main.bounds.width/2)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding()
                Text("Delta Rahmat Fajar Delviansyah")
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.top, 32)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Bergabung sejak 19 Sep 2017")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text("\"Sebaik-baik manusia adalah yang paling bermanfaat bagi manusia lain\"")
                    .font(Font.italic(.headline)())
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                    .lineSpacing(10)
                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
