//
//  ProfileView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("name") var name: String = "Delta R F D"
    @AppStorage("caption") var caption: String = "\"Hello World\""
    @State var isEditing = false
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
                TextField("Name", text: $name)
                    .disabled(!isEditing)
                    .font(Font.title.weight(.heavy))
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(Color("PrimaryColor"))
                Text("Bergabung sejak 19 Sep 2017")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                TextField("Caption", text: $caption)
                    .disabled(!isEditing)
                    .font(Font.italic(Font.headline.weight(.medium))())
                    .multilineTextAlignment(.center)
                    .padding()
                    .lineSpacing(10)
                Button {
                    if isEditing {
                        UserDefaults.standard.set(self.name, forKey: "name")
                        UserDefaults.standard.set(self.caption, forKey: "caption")
                    } else {
                        self.name = UserDefaults.standard.value(forKey: "name") as? String ?? "Delta R F D"
                        self.caption = UserDefaults.standard.value(forKey: "caption") as? String ?? "\"Hello World\""
                    }
                    self.isEditing.toggle()
                } label: {
                    Text(isEditing ? "Save" : "Edit")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width/2)
                        .padding()
                }
                .background(Color("PrimaryColor"))
                .clipShape(Capsule())
                .padding(.top, 64)
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
