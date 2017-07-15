//
//  SearchViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Oh on 7/14/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var searchActive: Bool = false
    var messages = [String]()
    var imageFiles = [PFFile]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.done
        
        var searchKey = searchBar.text as? String
        search(searchText: searchKey)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func search(searchText: String? = nil){
        
        let query = PFQuery(className: "Posts")
        
        if(searchText != nil){
            
            query.whereKey("title", contains: searchText)
            
        }
        
        query.findObjectsInBackground { (objects, error) in
            
            if let posts = objects {
                
                self.imageFiles.removeAll()
                self.messages.removeAll()
                
                for object in posts {
                    
                    if let post = object as? PFObject {
                        
                        self.imageFiles.append(post["imageFile"] as! PFFile)
                        self.messages.append(post["message"] as! String)
                        
                        //print(self.messages.count)
                        
                        self.searchCollectionView.reloadData()
                        
                    }
                    
                }
                
            }
            
            
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionCell", for: indexPath) as! SearchCollectionViewCell
        
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let downloadedImage = UIImage(data: imageData) {
                    
                    cell.searchImageView.image = downloadedImage
                    
                }
                
            }
            
        }
        
        cell.searchImageView.image = UIImage(named: "My-Story-Book-Maker-Icon.png")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is", indexPath.row)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //print("Searching again")
        search(searchText: searchText)
    }
    
}
