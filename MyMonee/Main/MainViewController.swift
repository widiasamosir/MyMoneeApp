//
//  MainViewController.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import UIKit

protocol MainDelegate {
    func sendBalance(price: Int)
}

struct ProgressDialog {
    static var alert = UIAlertController()
    static var progressView = UIProgressView()
    static var progressPoint : Float = 0{
        didSet{
            if(progressPoint == 1){
                ProgressDialog.alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

class MainViewController: UIViewController {

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
    var delegate: MainDelegate?
    var service: GetPenggunaanService = GetPenggunaanService()
    var pengeluaranList: [Pengeluaran] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    
    enum TimeString : String{
        case pagi  = "Selamat Pagi,"
        case siang = "Selamat Siang,"
        case sore = "Selamat Sore,"
        case malam = "Selamat Malam,"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "Customer") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedPerson = try? decoder.decode(Customer.self, from: savedPerson) {
                customer = loadedPerson
                
            }
           
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked(_:)))
        tapGesture.numberOfTapsRequired = 1
        buttonAdd.addGestureRecognizer(tapGesture)
        buttonAdd.isUserInteractionEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userName.text = customer.userName
        
                                          
        
        viewBalance.layer.cornerRadius = 8
        setHelloLabel()
        
        backgroundTableView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        backgroundTableView.layer.cornerRadius = 20
        stackRiwayat.layer.cornerRadius = 20
        let uiNIb = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(uiNIb, forCellReuseIdentifier: String(describing: MainTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: EmptyHandlingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EmptyHandlingTableViewCell.self))
    }

    @objc func imageClicked(_ sender: UITapGestureRecognizer)   {
        print("tap on button")
        let formViewController = FormPenggunaanViewController(nibName: "FormPenggunaanViewController", bundle: nil)
        formViewController.balance = countPriceByStatus(status: false) - countPriceByStatus(status: true)
        delegate?.sendBalance(price: formViewController.balance ?? 0)
        self.navigationController?.pushViewController(formViewController, animated: true)
 
    }
    
    func loadData(completion: () -> ())  {
        service.loadPengeluaran{ response in
            
            
            DispatchQueue.main.async { [self] in
                
                self.pengeluaranList = response
                self.pengeluaranList.sort( by: { (data1: Pengeluaran, data2: Pengeluaran) -> Bool in
                                return data1.date ?? "" > data2.date ?? ""
                            })
                customer.balance = getStringPrice(price: ( self.countPriceByStatus(status: false) - self.countPriceByStatus(status: true)))
                balance.text = customer.balance
                self.setUangMasuk()
                self.setUangKeluar()
                self.LoadingStop()
                
            }
           
        }
        completion()
        
    }
   
    func getStringPrice(price: Int) -> String {
        let number = String(price)
        let array = number.utf8.map{Int(($0 as UInt8)) - 48}
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
        return "Rp \(priceString)"
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer)   {
       
        let riwayatController = RiwayatPenggunaanViewController(nibName: "RiwayatPenggunaanViewController", bundle: nil)
        riwayatController.penggunaan = pengeluaranList[sender.view!.tag]
        riwayatController.indexPath =  sender.view!.tag
        self.navigationController?.pushViewController(riwayatController, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData{
            if(pengeluaranList.count == 0){
            self.LoadingStart()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.LoadingStop()
            }
            }
            
        }
        print("pengeluaran",pengeluaranList.count)
        if(pengeluaranList.count > 0){
        self.viewDidLoad()
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pengeluaranList.count > 0 {
           
            return pengeluaranList.count
            
            } else {
                self.tableView.separatorColor = .clear
                self.tableView.backgroundColor = .clear
                
                return 1
            }
    }
    
    func setUangMasuk() {
        uangMasukView.layer.cornerRadius = 4
        uangMasuk.text = getStringPrice(price: countPriceByStatus(status: false))
    }
    
    func setUangKeluar() {
        uangKeluarView.layer.cornerRadius = 4
        uangKeluar.text = getStringPrice(price: countPriceByStatus(status: true))
    }
    
    func countPriceByStatus(status : Bool) -> Int {
        var priceTotal : Int = 0
        
        for item in pengeluaranList {
            if(item.status == status){
                priceTotal += item.pengeluaranPrice!
                print("price", item.pengeluaranPrice!)
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
            headerHello.text = TimeString.pagi.rawValue
        } else
        if((Int(timeNow)! >= 10) && (Int(timeNow)! < 14)){
            headerHello.text = TimeString.siang.rawValue
        } else
        if((Int(timeNow)! >= 14) && (Int(timeNow)! < 19)){
            headerHello.text = TimeString.sore.rawValue
        } else  {
            headerHello.text = TimeString.malam.rawValue
        }

        print(timeNow)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(pengeluaranList.count == 0){
            self.LoadingStop()
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmptyHandlingTableViewCell.self), for: indexPath) as! EmptyHandlingTableViewCell
            let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked(_:)))
            addGesture.numberOfTapsRequired = 1
            cell.button.addGestureRecognizer(addGesture)
            cell.button.isUserInteractionEnabled = true
            return cell
           
        }
//        pengeluaranList.sort { (data1: Pengeluaran, data2: Pengeluaran) -> Bool in
//            return data1.date ?? "" > data2.date ?? ""
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = pengeluaranList[indexPath.row].pengeluaranName
        
        cell.date.text = pengeluaranList[indexPath.row].date
        
        if pengeluaranList[indexPath.row].status{
            cell.imageStatus.image = UIImage(systemName: "arrow.down")
            cell.imageStatus.tintColor = UIColor.red
            cell.imageBackground.backgroundColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.2)
            cell.imageBackground
                .layer.cornerRadius = 4
            cell.priceLabel.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            cell.priceLabel.text = "- \(getStringPrice(price:  pengeluaranList[indexPath.row].pengeluaranPrice!))"
        } else {
            cell.imageStatus.image = UIImage(systemName: "arrow.up")
            cell.imageBackground.backgroundColor = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 0.2)
            cell.imageStatus.tintColor = UIColor.systemGreen
            cell.imageBackground.layer.cornerRadius = 4
            cell.priceLabel.text = "+ \(getStringPrice(price:  pengeluaranList[indexPath.row].pengeluaranPrice!))"
            cell.priceLabel.textColor = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)
           
        }
        let cellTapped = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(_:)))
        cellTapped.numberOfTapsRequired = 1
        cell.addGestureRecognizer(cellTapped)
        cellTapped.view?.tag = indexPath.row
        tableView.separatorColor = .clear
        return cell
    }
}

extension MainViewController{
   func LoadingStart(){
        ProgressDialog.alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.medium
    loadingIndicator.startAnimating();

    ProgressDialog.alert.view.addSubview(loadingIndicator)
    present(ProgressDialog.alert, animated: true, completion: nil)
  }

  func LoadingStop(){
    ProgressDialog.alert.dismiss(animated: true, completion: nil)
  }
}
