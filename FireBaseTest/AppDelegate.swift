import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Init Firebase
        FirebaseApp.configure()
        
        //MARK: - Notificaciones
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
        
        //este es opcional pero podemos suscribir a una persona a un grupo de notificaciones
        Messaging.messaging().subscribe(toTopic: "topicoTutoriales")
        
        // con este sabemos el identificador unico de cada persona pero no es nesesario, solo si queremos enviar notificaciones a una persona target
        Messaging.messaging().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

//MARK: - Notificaciones Protocolo
extension AppDelegate: UNUserNotificationCenterDelegate {

    //Permite mostrar las notificaciones aunque la app este en primer plano
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

}

//MARK: - Notificaciones Protocolo Usuario Target
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("TOKEN: \(fcmToken ?? "")")
    }
}
