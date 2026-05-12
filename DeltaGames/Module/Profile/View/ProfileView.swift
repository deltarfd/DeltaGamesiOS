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
    @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
    @State var isEditing = false

    private var selectedLanguage: AppLanguage {
        get { AppLanguage(rawValue: appLanguageCode) ?? .system }
        set { appLanguageCode = newValue.rawValue }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Language Picker Section - Always visible
            VStack(spacing: 12) {
                Text(L10n.text("profile.language"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    ForEach(AppLanguage.allCases, id: \.self) { language in
                        Button(action: {
                            appLanguageCode = language.rawValue
                        }) {
                            Text(L10n.text(language.displayKey))
                                .font(.system(size: 12, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(selectedLanguage == language ? Color.appPrimary : Color(.systemGray5))
                                .foregroundColor(selectedLanguage == language ? .white : Color(.systemGray2))
                                .cornerRadius(6)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(.systemGray6))
            
            // Profile Content - Scrollable
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Hero Section with Background
                    ZStack(alignment: .bottom) {
                        Image(String.Asset.bgProfile.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.width / 1.2)
                            .clipped()
                        
                        // Avatar overlay
                        Image(String.Asset.deltaRfd.rawValue)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: UIScreen.main.bounds.width / 2.8)
                            .overlay(Circle().stroke(Color.appPrimary, lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.bottom, 20)
                    }
                    .frame(height: UIScreen.main.bounds.width / 1.2)
                    
                    // Profile Info Section
                    VStack(spacing: 20) {
                        // Name
                        VStack(spacing: 6) {
                            TextField(L10n.text("profile.name"), text: $name)
                                .disabled(!isEditing)
                                .font(.system(size: 28, weight: .bold))
                                .multilineTextAlignment(.center)
                                .padding(14)
                                .background(isEditing ? Color(.systemGray6) : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isEditing ? Color.appPrimary : Color.clear, lineWidth: 2)
                                )
                                .foregroundColor(.appPrimary)
                            
                            // Joined Date
                            Text(L10n.text("profile.joined_date"))
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // Caption Section
                        VStack(spacing: 8) {
                            Text(L10n.text("profile.caption"))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField(L10n.text("profile.caption"), text: $caption)
                                .disabled(!isEditing)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .padding(12)
                                .background(isEditing ? Color(.systemGray6) : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isEditing ? Color.appPrimary : Color.clear, lineWidth: 2)
                                )
                                .frame(minHeight: 60)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Edit/Save Button
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
                        HStack(spacing: 8) {
                            Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill")
                                .font(.system(size: 18))
                            Text(isEditing ? L10n.text("common.save") : L10n.text("common.edit"))
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.appPrimary)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    Spacer(minLength: 40)
                }
                .padding(.top, 0)
            }
        }
        .background(Color(.systemGray6))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
