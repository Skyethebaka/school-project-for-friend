import Foundation
import Firebase
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var alertMessage: String = ""
    @Published var showingAlert: Bool = false
    
    init() {
        setupAuthenticationListener()
    }
    
    func setupAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.isLoggedIn = user != nil
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    switch error.code {
                    case AuthErrorCode.wrongPassword.rawValue:
                        self?.alertMessage = "Incorrect Username or Password. Please try again."
                    case AuthErrorCode.userNotFound.rawValue:
                        self?.alertMessage = "Incorrect Username or Password. Please try again."
                    default:
                        self?.alertMessage = error.localizedDescription
                    }
                    self?.showingAlert = true
                } else {
                    self?.isLoggedIn = result != nil
                }
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch let error as NSError {
            alertMessage = "Error signing out: \(error.localizedDescription)"
            showingAlert = true
        }
    }

    func updateUserName(_ newName: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = newName
        changeRequest.commitChanges { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.alertMessage = "Failed to update name: \(error.localizedDescription)"
                    self?.showingAlert = true
                } else {
                    self?.alertMessage = "Name updated successfully."
                    self?.showingAlert = true
                }
            }
        }
    }
}
