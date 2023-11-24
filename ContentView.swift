

import SwiftUI

struct ContentView: View {
    @State private var newText = ""
    @State private var savedTexts = [String]()

    @ObservedObject var notificationHelper = NotificationHelper()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter text", text: $newText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    self.saveText(text: self.newText)
                    self.newText = ""
                    self.notificationHelper.scheduleNotification(at: Date(), withText: self.savedTexts.randomElement() ?? "No texts saved yet.")
                }) {
                    Text("Save and Schedule Notification")
                        .font(.headline)
                        .padding()
                }

                List(savedTexts, id: \.self) { text in
                    Text(text)
                }
            }
            .navigationBarTitle("Text Saver")
        }
        .onAppear {
            self.loadTexts()
            self.notificationHelper.requestPermission()
        }
    }

    private func saveText(text: String) {
        if text.isEmpty { return }
        savedTexts.append(text)
        UserDefaults.standard.set(savedTexts, forKey: "SavedTexts")
    }

    private func loadTexts() {
        if let savedTexts = UserDefaults.standard.array(forKey: "SavedTexts") as? [String] {
            self.savedTexts = savedTexts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
