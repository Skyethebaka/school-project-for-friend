import SwiftUI

struct FashionStyleView: View {
    let styles = ["Casual", "Elegant", "Sporty", "Business", "Boho", "Vintage"]
    @State private var selectedStyle: String?
    
    var body: some View {
        NavigationView {
            List(styles, id: \.self) { style in
                NavigationLink(destination: ImageUploadView()) {
                    Text(style)
                }
            }
            .navigationTitle("Select Your Style")
        }
    }
}
