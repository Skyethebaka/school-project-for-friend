import SwiftUI
import Firebase

@main
struct FashionRecommendationApp: App {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if viewModel.isLoggedIn {
                    MainUserView(viewModel: viewModel)
                } else {
                    LoginView(viewModel: viewModel)
                }
            }
        }
    }
}
