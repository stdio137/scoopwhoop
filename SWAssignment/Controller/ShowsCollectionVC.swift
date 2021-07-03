//
//  ShowsCollectionVC.swift
//  SWAssignment
//
//  Created by Shubham Tandon on 03/07/21.
//

import UIKit

class ShowsCollectionVC: UICollectionViewController {
    
    var shows = [Show]()
    var showDetailURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllShows(from: constants.URL_ALL_SHOWS)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCell", for: indexPath) as! ShowCollectionViewCell
        
        cell.showLabel.text = shows[indexPath.row].name
        cell.showImage.downloaded(from: shows[indexPath.row].showimageURL)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailURL = constants.URL_SHOW_VIDEOS_LISTING + shows[indexPath.row].nameSlug
        performSegue(withIdentifier: "showDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ShowsDetailVC
        destVC.showDetailURL = showDetailURL    }
    
    func fetchAllShows(from url: String ) -> Void {
        API.getAllShows(from: url, completion: reloadUI)
    }
    
    func reloadUI(shows: [Show]) -> Void {
        self.shows = shows
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ShowsCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 5, height: 300)
    }
}

