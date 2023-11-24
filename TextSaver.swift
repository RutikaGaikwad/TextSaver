

import SwiftUI
import UserNotifications

class NotificationHelper: NSObject, ObservableObject {
    let center = UNUserNotificationCenter.current()

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }

    func scheduleNotification(at date: Date, withText text: String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = text

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request) { error in
            if error != nil {
                print("Notification scheduling failed")
            } else {
                print("Notification scheduled")
            }
        }
    }
}

@main
struct OmioAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
