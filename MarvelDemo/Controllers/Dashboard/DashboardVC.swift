//
//  DashboardVC.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import UIKit
import ObjectMapper

class DashboardVC: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    //MARK: - Variables
    var arrComicList = [Result]()
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
   
    //MARK: - Custom Methods
    func intialConfig() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.title = "All Comics"
        applyShadowNavigationBar()
        
        table_View.register(UINib(nibName: "ComicListCell", bundle: nil), forCellReuseIdentifier: "ComicListCell")
        prepareDatasource()
    }
    
    func applyShadowNavigationBar() {
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.7
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        self.navigationController?.navigationBar.layer.shadowRadius = 5
    }
    
    func prepareDatasource() {
        fetchComics()
    }

}

//MARK : UITableViewDataSource,UITableViewDelegate

extension DashboardVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrComicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrComicList.count > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ComicListCell", for: indexPath) as? ComicListCell {
                let model = arrComicList[indexPath.row]
                cell.setCell(model: model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrComicList.count > 0 {
            let model = arrComicList[indexPath.row]
            let VC = ComicDetailVC(nibName: "ComicDetailVC", bundle: nil)
            VC.model = model
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}


//MARK : API Call
extension DashboardVC {
    
    //fetchComics
    func fetchComics() {
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + AppConstants.privateKey + AppConstants.publicKey).md5()
        let url = "ts=\(ts)&apikey=\(AppConstants.publicKey)&hash=\(hash)"
        
        
        NetworkClient.shared.request(AppConstants.serverUrl, command: AppConstants.URL.comics + url, method: .get, parameters: nil, success: { (response, message) in
            
            if let data = response as? [String:Any]{
                let model = Mapper<ComicModel>().map(JSON: data)
                for item in model?.data?.results ?? [] {
                    if item.descriptionField != nil && item.descriptionField != "" {
                        self.arrComicList.append(item)
                    }
                }
            }
            
            if self.arrComicList.count > 0 {
                self.noDataView.isHidden = true
                self.table_View.isHidden = false
                self.table_View.reloadData()
            }else {
                self.noDataView.isHidden = false
                self.table_View.isHidden = true
                self.table_View.reloadData()
            }
            
        }) { (failureMessage, failureCode, failureResponse) in
            self.showAlert(withTitle: "", withMessage: failureMessage)
        }
    }
}
