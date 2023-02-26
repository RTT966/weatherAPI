//
//  ViewController.swift
//  weatherApp
//
//  Created by Рустам Т on 2/22/23.
//

import UIKit

extension ViewController{
    func createAlert (title: String, message: String?, style: UIAlertController.Style, complitionHandler: @escaping (String)-> Void ){
        let alertC = UIAlertController(title: title, message: message, preferredStyle: style)
        alertC.addTextField{ tf in
            let citys = ["Moscow", "Chikago", " New York"]
            let city = citys.randomElement()
            tf.placeholder = city
            //self.cityLabel.text = city
        }
        
        
        let search = UIAlertAction(title: "search", style: .default) {action in
            let textField = alertC.textFields?.first
            guard let cityName = textField?.text  else { return }
            if cityName != ""{
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complitionHandler(city)
            }
            else{
               self.createAlerts(tittle: "Ошибка", message: "Не корректный город", style: .alert)
          
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertC.addAction(search)
        alertC.addAction(cancel)
        present(alertC, animated: true)
    }
    
    
    
    
    
    func createAlerts( tittle: String, message: String, style: UIAlertController.Style){
        let controller = UIAlertController(title: tittle, message: message, preferredStyle: style)
        
        let aclion = UIAlertAction(title: "Ok", style: .default)
        
        controller.addAction(aclion)
        present(controller, animated: true)
        
    }
    
    
}
