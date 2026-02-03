import SwiftUI
import CoreData   

struct ContentView: View {

    @Environment(\.managedObjectContext)
    private var viewContext

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Image("umbrella-3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.blue)

                    Text("Breeze")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Text("Weather App")
                        .foregroundColor(.white)

                    NavigationLink {
                        LocationListView()
                            .environment(
                                \.managedObjectContext,
                                viewContext
                            )
                    } label: {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                    }
                }
            }
        }
    }
}
