//
//  ComicListCell.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import UIKit
import Kingfisher

class ComicListCell: UITableViewCell {

    //MARK: - @IBOutlet's
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var lblNameComic: UILabel!
    @IBOutlet weak var lblAuthorComic: UILabel!
    @IBOutlet weak var lblPriceComic: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgComic.layer.cornerRadius = 15.0
        viewMain.layer.cornerRadius = 15.0
        contentView.setCardView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(model: Result) {
        
        self.imgComic.kf.setImage(with: URL(string: model.thumbnail?.getThumbnail() ?? ""))
        self.lblNameComic.text = model.title ?? ""
        self.lblAuthorComic.text = "By " + (model.creators?.items?.first?.name ?? "Clayton Crain")
        self.lblPriceComic.text = "Price : $\(model.prices?.first?.price ?? 0)"
    }
    
}
