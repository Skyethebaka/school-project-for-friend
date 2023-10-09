import SwiftUI

struct MainUserView: View {
    @ObservedObject var viewModel: AuthenticationViewModel

    var body: some View {
        ZStack {
            GradientBackground()
            
            VStack(spacing: 30) {
                Text("Welcome to Your Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Using custom button styles for a more modern look
                NavigationLink(destination: StyleAndRecommendationsView()) {
                    Text("Styles and Recommendations")
                        .customButton()
                }

                NavigationLink(destination: FavouritesView()) {
                    Text("My Favourites")
                        .customButton()
                }

                NavigationLink(destination: UserProfileView(viewModel: viewModel)) {
                    Text("User Profile")
                        .customButton()
                }

                Spacer()
            }
            .padding()
        }
    }
}

// Define a custom button modifier for reuse
extension View {
    func customButton() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.3)))
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}

struct MainUserView_Previews: PreviewProvider {
    static var previews: some View {
        MainUserView(viewModel: AuthenticationViewModel())
    }
}
