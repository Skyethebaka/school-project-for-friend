import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var accountCreationSuccess: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground() // This references GradientBackground defined in its own file

                VStack(spacing: 20) {
                    HStack {
                        Button("Back") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    .padding()

                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    TextField("Email", text: $email)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)

                    Button("Sign Up") {
                        registerUser(email: email, password: password)
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
                }
            }
        }
    }

    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showingAlert = true
                } else {
                    self.alertMessage = "Account created successfully."
                    self.accountCreationSuccess = true
                    self.showingAlert = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoggedIn: .constant(false))
    }
}
