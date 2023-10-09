import SwiftUI
import Firebase

struct UserProfileView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var showingLogoutAlert = false
    @Environment(\.presentationMode) var presentationMode // Used for the back button

    // Retrieve the current user's email from Firebase
    var userEmail: String {
        Auth.auth().currentUser?.email ?? "user@example.com" // Placeholder email
    }

    var body: some View {
        ZStack {
            GradientBackground()

            ScrollView {
                VStack {
                    // Add some padding to ensure content starts below the dynamic island and status bar
                    Spacer(minLength: 50)

                    // User Details Section
                    Text("Name: User") // Replace "User" with the actual user name if available
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)

                    Text("Email: \(userEmail)") // Use the dynamic email
                        .foregroundColor(.white)
                        .font(.body)
                        .padding(.bottom, 20)

                    // Favourites and Settings Buttons
                    NavigationLink(destination: FavouritesView()) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                            Text("Favourites")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                            Text("Settings")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    // Logout Button
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("Logout")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Confirm Logout"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Logout")) {
                    viewModel.logOut()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Back")
            }
            .foregroundColor(.white)
        })
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: AuthenticationViewModel())
    }
}
