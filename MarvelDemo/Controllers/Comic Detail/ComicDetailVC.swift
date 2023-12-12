//
//  ComicDetailVC.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import UIKit
import SafariServices

class ComicDetailVC: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var lblComicTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblComicDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    
    //MARK: - Variables
    var model = Result()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - Custom Methods
    func intialConfig() {
        
        self.imgComic.layer.cornerRadius = 15.0
        self.btnReadMore.layer.cornerRadius = 20.0
        self.imgComic.kf.setImage(with: URL(string: model.thumbnail?.getThumbnail() ?? ""))
        self.lblComicTitle.text = model.title ?? ""
        self.lblAuthor.text = "By " + (model.creators?.items?.first?.name ?? "Clayton Crain")
        self.lblComicDescription.text = model.descriptionField ?? ""
        self.lblPrice.text = "Price : $\(model.prices?.first?.price ?? 0)"
    }
    
    func clickReadMore(urlStr: String) {
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }


    //MARK: - @IBOutlets
    @IBAction func btnBack_Click(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnReadMore_Click(_ sender: UIButton) {
        clickReadMore(urlStr: model.urls?.first?.url ?? "")
    }
}

extension ComicDetailVC: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
