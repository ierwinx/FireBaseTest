import UIKit
import FirebaseFirestore

class FirestoreViewController: UIViewController {

    @IBOutlet weak var txfNombre: UITextField!
    @IBOutlet weak var txfEdad: UITextField!
    @IBOutlet weak var swichEdad: UISwitch!
    
    private var db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func consultaAction(_ sender: Any) {
        db.collection("usuarios").document("q28aIahwY6HK8aoNUqtz").getDocument { documento, error in
            if error == nil, let document = documento {
                if let nombre = document.get("nombre") as? String,
                let edad = document.get("edad") as? Int,
                   let trabaja = document.get("trabaja") as? Bool {
                    self.txfNombre.text = nombre
                    self.txfEdad.text = edad.description
                    self.swichEdad.isOn = trabaja
                }
            }
        }
        view.endEditing(true)
    }

    @IBAction func insertAction(_ sender: Any) {
        db.collection("usuarios").document("q28aIahwY6HK8aoNUqtz").setData(
            [
                "nombre" : txfNombre.text ?? "",
                "edad": Int(txfEdad.text ?? "0") ?? 0,
                "trabaja": self.swichEdad.isOn
            ]
        )
        view.endEditing(true)
    }

    @IBAction func eliminarAction(_ sender: Any) {
        db.collection("usuarios").document("q28aIahwY6HK8aoNUqtz").delete()
        view.endEditing(true)
    }

}
