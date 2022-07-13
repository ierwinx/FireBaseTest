import UIKit
import Firebase
import FirebaseRemoteConfig

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("init_app", parameters: nil)
        getRemoteConfig()
    }
    
    private func getRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60
        
        let config = RemoteConfig.remoteConfig()
        config.configSettings = settings
        config.setDefaults(["bandera1" : NSNumber(false)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.setUserProperty("Erwin", forName: "nombre")
        
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "Dashboard",
            AnalyticsParameterSource: "Canal"
        ])
    }

    @IBAction func clicAction(_ sender: Any) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterScreenName: "Dashboard",
            AnalyticsParameterSource: "Canal"
        ])
    }
    
}
