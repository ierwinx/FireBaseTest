import UIKit
import FirebaseRemoteConfig

class CrashViewController: UIViewController {

    @IBOutlet weak var imageRemoteConfig: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { status, error in
            if status != .error {
                
                DispatchQueue.main.async {
                    let bShowImage = remoteConfig.configValue(forKey: "bandera1").boolValue
                    
                    self.imageRemoteConfig.isHidden = !bShowImage
                    self.imageRemoteConfig.image = UIImage(named: "doom-eternal")
                }
                
            }
        }
        
    }
    
    @IBAction func errorAction(_ sender: Any) {
        fatalError()
    }
    
}
