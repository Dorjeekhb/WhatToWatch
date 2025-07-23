import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        List {
            if favorites.favorites.isEmpty {
                Text("Sin favoritos aún.")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                ForEach(favorites.favorites) { item in
                    NavigationLink(destination: DetailView(item: item)
                                    .environmentObject(favorites)) {
                        HStack(spacing: 8) {
                            AsyncImage(url: item.imageURL) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(4)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(4)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(item.displayName)
                                    .font(.system(size: 14, weight: .bold))
                                    .lineLimit(1)
                                Text(item.formattedDate)
                                    .font(.caption2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("⭐️ Favoritos")
    }
}


