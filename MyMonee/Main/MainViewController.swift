//
//  MainViewController.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerHello: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewBalance: UIView!
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var uangMasuk: UILabel!
    @IBOutlet weak var uangKeluar: UILabel!
    @IBOutlet weak var uangMasukView: UIView!
    
    @IBOutlet weak var buttonAdd: UIImageView!
    @IBOutlet weak var uangKeluarView: UIView!
    @IBOutlet weak var backgroundTableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackRiwayat: UIStackView!
    var messageLabel = UILabel()
    var buttonNewPenggunaan = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked(_:)))
        tapGesture.numberOfTapsRequired = 1
        buttonAdd.addGestureRecognizer(tapGesture)
        buttonAdd.isUserInteractionEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userName.text = customer.userName
        customer.balance = String( countPriceByStatus(status: false) - countPriceByStatus(status: true))
        balance.text = customer.balance
        viewBalance.layer.cornerRadius = 8
        setHelloLabel()
        setUangMasuk()
        setUangKeluar()
        backgroundTableView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        backgroundTableView.layer.cornerRadius = 20
        stackRiwayat.layer.cornerRadius = 20
        let uiNIb = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(uiNIb, forCellReuseIdentifier: String(describing: MainTableViewCell.self))
        tableView.reloadData()

    }

    @objc func imageClicked(_ sender: UITapGestureRecognizer)   {
        print("tap on button")
        let formViewController = FormPenggunaanViewController(nibName: "FormPenggunaanViewController", bundle: nil)
        self.navigationController?.pushViewController(formViewController, animated: true)
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pengeluaran.count > 0 {
            return pengeluaran.count
            } else {
                let rect = CGRect(origin: CGPoint(x: 0, y :self.backgroundTableView.center.y), size: CGSize(width: self.view.bounds.width - 16, height: 50.0))
                    messageLabel = UILabel(frame: rect)
                    messageLabel.center = self.backgroundTableView.center
                    messageLabel.text = "Wah! Data tidak ditemukan"
                    messageLabel.numberOfLines = 0
                    messageLabel.textColor = UIColor.gray
                    messageLabel.textAlignment = .center
                    messageLabel.font = UIFont(name: "Lato-Regular", size: 17)
                let rectButton = CGRect(origin: CGPoint(x: 30, y :self.backgroundTableView.center.y+30), size: CGSize(width: self.view.bounds.width - 60, height: 43))
                    buttonNewPenggunaan = UILabel(frame: rectButton)
                buttonNewPenggunaan.text = "Tambah Penggunaan"
                buttonNewPenggunaan.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
                buttonNewPenggunaan.font = UIFont(name: "Poppins-SemiBold", size: 14)
                
                buttonNewPenggunaan.textAlignment = .center
                buttonNewPenggunaan.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
                    buttonNewPenggunaan.layer.cornerRadius = 20
                let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked(_:)))
                addGesture.numberOfTapsRequired = 1
                buttonNewPenggunaan.addGestureRecognizer(addGesture)
                buttonNewPenggunaan.isUserInteractionEnabled = true
                    self.view.addSubview(messageLabel)
                    self.view.bringSubviewToFront(messageLabel)
                self.view.addSubview(buttonNewPenggunaan)
                self.view.bringSubviewToFront(buttonNewPenggunaan)
                self.tableView.separatorColor = .clear
                self.tableView.backgroundColor = .clear
                return 0
            }
    }
    
    func setUangMasuk() {
        uangMasukView.layer.cornerRadius = 4
        uangMasuk.text = String(countPriceByStatus(status: false))
    }
    
    func setUangKeluar() {
        uangKeluarView.layer.cornerRadius = 4
        uangKeluar.text = String(countPriceByStatus(status: true))
    }
    func countPriceByStatus(status : Bool) -> Int {
        var priceTotal : Int = 0
        for item in pengeluaran {
            if(item.status == status){
                priceTotal += item.pengeluaranPrice!
            }
        }
        return priceTotal
    }
    func setHelloLabel()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "id_ID")
        let timeNow = dateFormatter.string(from: Date())
        if(Int(timeNow)! < 10){
            headerHello.text = "Selamat Pagi,"
        } else
        if((Int(timeNow)! >= 10) && (Int(timeNow)! < 14)){
            headerHello.text = "Selamat Siang,"
        } else
        if((Int(timeNow)! >= 14) && (Int(timeNow)! < 19)){
            headerHello.text = "Selamat Sore,"
        } else  {
            headerHello.text = "Selamat Malam,"
        }

        print(timeNow)
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = pengeluaran[indexPath.row].pengeluaranName
        cell.priceLabel.text = String( pengeluaran[indexPath.row].pengeluaranPrice!)
        cell.date.text = pengeluaran[indexPath.row].date
        
        if pengeluaran[indexPath.row].status{
            cell.imageStatus.image = UIImage(systemName: "arrow.down")
            cell.imageStatus.tintColor = UIColor.red
            cell.imageBackground.backgroundColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.2)
            cell.imageBackground
                .layer.cornerRadius = 4
        } else {
            cell.imageStatus.image = UIImage(systemName: "arrow.up")
            cell.imageBackground.backgroundColor = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 0.2)
            cell.imageStatus.tintColor = UIColor.systemGreen
            cell.imageBackground.layer.cornerRadius = 4
           
        }
        let cellTapped = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(_:)))
        cellTapped.numberOfTapsRequired = 1
        cell.addGestureRecognizer(cellTapped)
        cellTapped.view?.tag = indexPath.row
        tableView.separatorColor = .clear
        return cell
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer)   {
       
        let riwayatController = RiwayatPenggunaanViewController(nibName: "RiwayatPenggunaanViewController", bundle: nil)
        riwayatController.penggunaan = pengeluaran[sender.view!.tag]
        riwayatController.indexPath =  sender.view!.tag
        self.navigationController?.pushViewController(riwayatController, animated: true)

        
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
