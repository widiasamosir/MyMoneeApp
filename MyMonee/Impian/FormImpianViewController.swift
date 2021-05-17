//
//  FormImpianViewController.swift
//  MyMonee
//
//  Created by Macbook on 15/05/21.
//

import UIKit

class FormImpianViewController: UIViewController {

    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var textJudul: UITextField!
    @IBOutlet weak var textTargetCapaian: UITextField!
    
    var wish: Impian!
    var temporaryTarget : String = ""
    
    @IBAction func save(_ sender: Any) {
        if(textJudul.hasText){
            wish.name = textJudul.text!
        }
        if(textTargetCapaian.hasText){
            wish.target = Int(parseDot(price:  textTargetCapaian.text!))
        }
        wish.id = wishLists.count + 1
        wish.reachedTarget = 0
        wish.status = false
        let controller = MainTabController(nibName: String(describing: MainTabController.self), bundle: nil)
        
        let impianController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        controller.viewControllers![1] = UINavigationController(rootViewController: impianController)
        wishLists.append(wish)
        impianController.view.tag = self.view!.tag
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(wishLists) {
         
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "Impian")
            impianController.collectionView.reloadData()
        }
        
        navigationController?.setViewControllers([impianController], animated: true)

        
    }
    
    @IBAction func editedTarget(_ sender: Any) {
        temporaryTarget = parseDot(price: textTargetCapaian.text!)
        textTargetCapaian.text = getStringPrice(price: temporaryTarget)
        print(textTargetCapaian.text!)
    }
    
    func getStringPrice(price: String) -> String {
        let number = String(price)
        let array = Array(number)
        var priceString: String = ""

        var newArray : [String] = []
        for i in 0...array.count-1 {
            let n = array.count-1 - i
            newArray.append(String(array[n]))
            if((i+1)%3 == 0) && ((i+1) != array.count){
                newArray.append(".")
            }
        }
        for num in newArray.reversed() {
            priceString.append(String(num))
        }
        return "\(priceString)"
    }
    
    func parseDot(price: String)-> String{
        let array = price.components(separatedBy: ".")
        var string = ""
        for item in array {
            string.append(item)
        }
        return string
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wish = Impian(name: "", target: 0, reachedTarget: 0, status: false)
        buttonSave.layer.cornerRadius = 20
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
