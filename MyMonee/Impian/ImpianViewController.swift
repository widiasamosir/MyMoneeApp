

import UIKit

class ImpianViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonAdd: UIImageView!
    var messageLabel = UILabel()
    var buttonNewPenggunaan = UILabel()
    var wish : Impian!
    var serviceGet: GetImpianService = GetImpianService()
    
    var wishLists: [Impian] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.layoutSubviews()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataImpian {}
        collectionView.reloadData()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ImpianCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        collectionView.register(UINib(nibName: String(describing: EmptyHandlingCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EmptyHandlingCollectionViewCell.self))
   
        let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImpian(_:)))
        addGesture.numberOfTapsRequired = 1
        buttonAdd.addGestureRecognizer(addGesture)
        buttonAdd.isUserInteractionEnabled = true
        
        
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
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
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


extension ImpianViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if wishLists.count > 0 {
            
            return wishLists.count
            } else {
               
             
//                let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImpian(_:)))
//                addGesture.numberOfTapsRequired = 1
//                buttonNewPenggunaan.addGestureRecognizer(addGesture)
//                buttonNewPenggunaan.isUserInteractionEnabled = true
                
                return 1
            }
    }
    
    func setProgress(target: Int, reached: Int) -> Float {
        var progress : Float!
        
        
        progress = Float(Float(reached)/Float(target))
        
        return progress
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        wishLists.sort { (data1: Impian, data2: Impian) -> Bool in
//            return data1.id ?? 0 > data2.id ?? 00
//        }
   
        
        if(wishLists.count == 0){
            self.LoadingStop()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyHandlingCollectionViewCell.self), for: indexPath) as! EmptyHandlingCollectionViewCell
            let addGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImpian(_:)))
            addGesture.numberOfTapsRequired = 1
            cell.buttonAddImpian.addGestureRecognizer(addGesture)
            cell.buttonAddImpian.isUserInteractionEnabled = true
      
        return cell
       
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
        cell.deleteButton.accessibilityIdentifier = wishLists[indexPath.row].id
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space)
        let height:CGFloat = (collectionView.frame.size.height - space)
        if(wishLists.count == 0){
        return CGSize(width: size, height: height)
        } else{
            return CGSize(width: size, height: 80)
        }
    }
}

extension ImpianViewController {
    func loadDataImpian(completion: () -> ()){
        serviceGet.loadImpian{response in
            DispatchQueue.main.async {
                [self] in
                self.wishLists = response
                self.collectionView.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.layoutSubviews()
                
        }
        }
    }
}
