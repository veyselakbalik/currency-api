//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Veysel Akbalık on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var cadLabel: UILabel!
    @IBOutlet var jpyLabel: UILabel!
    @IBOutlet var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getDataTapped(_ sender: Any) {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response , error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else {
                if data != nil {
                    
                    do {
                      let jsonResponse = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(String(usd))"
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(String(cad))"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(String(jpy))"
                                }
                                if let turk = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(String(turk))"
                                }
                            }
                        }
                        
                        
                    } catch {
                        print("error")
                    }
                    
                }
            }
        }
        
        task.resume()
        
    }
    
}

