//
//  ShowsDetailVC.swift
//  SWAssignment
//
//  Created by Shubham Tandon on 03/07/21.
//

import Foundation
import UIKit

class ShowsDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var showDetailURL: String?
    var showDetail = ShowDetail()
    var flagEnd = false
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailscollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailscollectionView.dataSource = self
        detailscollectionView.delegate = self
        if let showDetailURL = showDetailURL {
            API.getShowDetails(from: showDetailURL, and: nil, completion: reloadUI)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showDetail.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ShowDetailCollectionViewCell
        cell.videoLabel.preferredMaxLayoutWidth = self.view.frame.width/2 - 15
        cell.videoLabel.text = showDetail.titles[indexPath.row]
        cell.videoImageView.downloaded(from: showDetail.thumbnails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == showDetail.titles.count-1 {
            print("offset \(showDetail.nextOffset)\n indexPath \(indexPath)\n row \(indexPath.row)\n)")//\n titles \(showDetail.titles)
            if let showDetailURL = showDetailURL {
                if !flagEnd {
                    if showDetail.nextOffset == -1 {
                        flagEnd = true
                    }
                    API.getShowDetails(from: showDetailURL, and: showDetail.nextOffset, completion: reloadUI)
                }
            }
        }
    }
    
    func reloadUI(showDetail: ShowDetail) -> Void {
        self.showDetail.titles += showDetail.titles
        self.showDetail.thumbnails += showDetail.thumbnails
        self.showDetail.featureImageLand = showDetail.featureImageLand
        self.showDetail.desc = showDetail.desc
        self.showDetail.featureImg = showDetail.featureImg
        self.showDetail.name = showDetail.name
        self.showDetail.nextOffset = showDetail.nextOffset
        
        DispatchQueue.main.async {
            self.imageView.downloaded(from: showDetail.featureImageLand)
            self.descriptionTextView.text = showDetail.desc
            self.title = showDetail.name
            self.titleLabel.text = showDetail.name
            self.detailscollectionView.reloadData()
        }
    }
    
}

extension ShowsDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 5, height: 300)
    }
}

