

import UIKit

class ImpianViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonAdd: UIImageView!
    var messageLabel = UILabel()
    var buttonNewPenggunaan = UILabel()
    var wish : Impian!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        let defaults = UserDefaults.standard
        if let savedWish = defaults.object(forKey: "Impian") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedWish = try? decoder.decode([Impian].self, from: savedWish) {
                wishLists = loadedWish
                collectionView.reloadData()
            }
        }
        
        
        self.collectionView.register(UINib.init(nibName: "ImpianCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImpian(_:)))
        addGesture.numberOfTapsRequired = 1
        buttonAdd.addGestureRecognizer(addGesture)
        buttonAdd.isUserInteractionEnabled = true
        collectionView.reloadData()
    }
    
    func isAvailable(wish: Impian)  {
        var available: Bool = false
        for impian in wishLists {
            if(impian.name == wish.name){
             
                available = true
            }
        }
        if(available == false){
            wishLists.append(wish)
        }
      
    }

    @objc func addImpian(_ sender: UITapGestureRecognizer){
        let formImpianController = FormImpianViewController(nibName: "FormImpianViewController", bundle: nil)
        self.navigationController?.pushViewController(formImpianController, animated: true)
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
        return "\(priceString)"
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer)   {
       
        let detailController =  DetailImpianViewController(nibName: "DetailImpianViewController", bundle: nil)
        detailController.wish = wishLists[sender.view!.tag]
        detailController.indexPath = sender.view!.tag
        self.navigationController?.pushViewController(detailController, animated: true)

        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   
}


extension ImpianViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if wishLists.count > 0 {
            return wishLists.count
            } else {
                let rect = CGRect(origin: CGPoint(x: 0, y :self.collectionView.center.y), size: CGSize(width: self.view.bounds.width - 16, height: 50.0))
                    messageLabel = UILabel(frame: rect)
                    messageLabel.center = self.collectionView.center
                    messageLabel.text = "Data kamu kosong, Yuk buat impian kamu!"
                    messageLabel.numberOfLines = 0
                    messageLabel.textColor = UIColor.gray
                    messageLabel.textAlignment = .center
                    messageLabel.font = UIFont(name: "Lato-Regular", size: 17)
                let rectButton = CGRect(origin: CGPoint(x: 30, y :self.collectionView.center.y+30), size: CGSize(width: self.view.bounds.width - 60, height: 43))
                    buttonNewPenggunaan = UILabel(frame: rectButton)
                buttonNewPenggunaan.text = "Tambah Impian"
                buttonNewPenggunaan.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
                buttonNewPenggunaan.font = UIFont(name: "Poppins-SemiBold", size: 14)
                
                buttonNewPenggunaan.textAlignment = .center
                buttonNewPenggunaan.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
                    buttonNewPenggunaan.layer.cornerRadius = 20
                let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImpian(_:)))
                addGesture.numberOfTapsRequired = 1
                buttonNewPenggunaan.addGestureRecognizer(addGesture)
                buttonNewPenggunaan.isUserInteractionEnabled = true
                    self.view.addSubview(messageLabel)
                    self.view.bringSubviewToFront(messageLabel)
                self.view.addSubview(buttonNewPenggunaan)
                self.view.bringSubviewToFront(buttonNewPenggunaan)
              
                return 0
            }
    }
    
    func setProgress(target: Int, reached: Int) -> Float {
        var progress : Float!
        
        
        progress = Float(Float(reached)/Float(target))
        
        return progress
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        wishLists.sort { (data1: Impian, data2: Impian) -> Bool in
            return data1.id ?? 0 > data2.id ?? 00
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! ImpianCollectionViewCell
        cell.judulImpian.text = wishLists[indexPath.row].name
        cell.progessImpian.progress = setProgress(target: wishLists[indexPath.row].target!, reached: wishLists[indexPath.row].reachedTarget!)
        cell.targetImpian.text = "IDR \(getStringPrice(price: wishLists[indexPath.row].reachedTarget!)) / \(getStringPrice(price: wishLists[indexPath.row].target!)) "
        let cellTapped = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(_:)))
        if(cell.progessImpian.progress == 1){
            cell.iconConfirmed.tintColor = UIColor(red: 0.153, green: 0.682, blue: 0.376, alpha: 1)
        } else {
            cell.iconConfirmed.tintColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            
        }
        cellTapped.numberOfTapsRequired = 1
        cell.addGestureRecognizer(cellTapped)
        cellTapped.view?.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space)
        return CGSize(width: size, height: 80)
    }
}
