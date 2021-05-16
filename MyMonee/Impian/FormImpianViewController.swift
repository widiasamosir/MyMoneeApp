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
    @IBAction func save(_ sender: Any) {
        if(textJudul.hasText){
            wish.name = textJudul.text!
        }
        if(textTargetCapaian.hasText){
            wish.target = Int(textTargetCapaian.text!)
        }
        wish.reachedTarget = 0
        wish.status = false
        var controller = MainTabController(nibName: String(describing: MainTabController.self), bundle: nil)
        
        let impianController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        controller.viewControllers![1] = UINavigationController(rootViewController: impianController)
        wishLists.append(wish)
        impianController.view.tag = self.view!.tag
        navigationController?.setViewControllers([impianController], animated: true)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wish = Impian(name: "", target: 0, reachedTarget: 0, status: false)
        buttonSave.layer.cornerRadius = 20
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
