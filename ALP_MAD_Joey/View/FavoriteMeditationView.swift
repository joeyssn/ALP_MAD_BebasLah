import SwiftUI
import SwiftData

struct FavoriteMeditationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Query(filter: #Predicate<MeditationCardModel> { $0.isFavorite == true })
    var favoriteCards: [MeditationCardModel]

    var body: some View {
        NavigationView {
            ZStack {
                Image("Login")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                        }

                        Spacer()

                        Text("Favorite List")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    .padding(.bottom, 30)

                    if favoriteCards.isEmpty {
                        Text("No favorite sessions yet.")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(favoriteCards) { card in
//                                    NavigationLink(destination: SessionStartView(card: card)) {
//                                        FavMeditationCardView(card: card)
//                                    }
//                                    .padding(.horizontal, 16)
                                }
                            }
                        }
                    }

                    Spacer()
                }
                .navigationBarHidden(true)
            }
        }
    }
}
