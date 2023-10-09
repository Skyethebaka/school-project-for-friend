import SwiftUI
import Firebase

struct SettingsView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode // Used for the back button
    
    // State properties for account settings
    @State private var newName: String = ""
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    @State private var showingChangeAlert = false
    @State private var changeAlertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    TextField("Change name", text: $newName)
                    TextField("Change email", text: $newEmail)
                    SecureField("Change password", text: $newPassword)
                    Button("Update Account") {
                        updateAccount()
                    }
                }
                
                // Additional sections for Appearance, Privacy & Security, etc.
            }
            .navigationBarTitle("Settings")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
                .foregroundColor(.blue) // Change this to the desired color for your back button
            })
            .alert(isPresented: $showingChangeAlert) {
                Alert(title: Text("Update Status"), message: Text(changeAlertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func updateAccount() {
        // Perform name update
        if !newName.isEmpty {
            // This is where you'd update the name in your database or user model
            viewModel.updateUserName(newName)
        }
        
        // Perform email update
        if !newEmail.isEmpty, newEmail.contains("@"), newEmail.contains(".") {
            Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
                if let error = error {
                    self.changeAlertMessage = "Failed to change email: \(error.localizedDescription)"
                    self.showingChangeAlert = true
                } else {
                    self.changeAlertMessage = "Email updated successfully."
                    self.showingChangeAlert = true
                }
            }
        }
        
        // Perform password update
        if !newPassword.isEmpty {
            Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                if let error = error {
                    self.changeAlertMessage = "Failed to change password: \(error.localizedDescription)"
                    self.showingChangeAlert = true
                } else {
                    self.changeAlertMessage = "Password updated successfully."
                    self.showingChangeAlert = true
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: AuthenticationViewModel())
    }
}
