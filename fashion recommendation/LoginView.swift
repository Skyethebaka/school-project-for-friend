import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPasswordInput: Bool = false

    let gradient = LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)

    var body: some View {
        ZStack {
            gradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Welcome, please log in or sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .onChange(of: email) { newValue in
                        showPasswordInput = !newValue.isEmpty
                    }

                if showPasswordInput {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                }

                Button("Login") {
                    viewModel.login(email: email, password: password)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .disabled(email.isEmpty)

                Spacer()
                
                NavigationLink("Sign Up", destination: SignUpView(isLoggedIn: $viewModel.isLoggedIn))
                    .foregroundColor(.white)
                    .padding()
            }
            .padding(.horizontal, 32)
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Login Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
