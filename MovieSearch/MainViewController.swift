//
//  ViewController.swift
//  MovieSearch
//
//  Created by Nathan Chen on 6/19/17.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit
import AlamofireImage
import CCBottomRefreshControl
class MainViewController: UIViewController,UISearchControllerDelegate,UISearchBarDelegate{
    @IBOutlet weak var placeHolderLabel: UILabel!

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var searchController:UISearchController!
    var searchBar:UISearchBar!
    var movieItems = [MovieItem]()
    var refreshControl = UIRefreshControl()
    var currentPage = 1
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout()
        searchBarSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setCollectionViewLayout(){
        let layout = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.frame.width/2 - 20, height:200)
        refreshControl.addTarget(self, action: #selector(loadMoreDate), for: .valueChanged)
        moviesCollectionView.bottomRefreshControl = refreshControl
    }
    func loadMoreDate(){
        loadData()
    }
    func searchBarSetup(){
        self.searchController=UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater=self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.definesPresentationContext = true
        searchBar = searchController.searchBar
        searchBarView.addSubview(searchBar)
        searchBar.delegate = self
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
extension MainViewController:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        placeHolderLabel.isHidden = movieItems.count == 0 ? false:true
        return movieItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieItemCollectionViewCell", for: indexPath) as! MovieItemCollectionViewCell
        let currentMovie = movieItems[indexPath.row]
        cell.movieLabel.text = currentMovie.title
        
        if let posterPath = currentMovie.poster_path, let imageURL = APIHandler.getImageURL(imagePath:posterPath) {
            cell.movieImageView.af_setImage(
                withURL: imageURL,
                imageTransition: .crossDissolve(0.2)
            )
        }
        return cell
    }
}
extension MainViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            self.searchController.dismiss(animated: false, completion: nil)
            print(indexPath.row)
            detailVC.movie = movieItems[indexPath.row]
            backButtonSetup()
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func backButtonSetup(){
        self.navigationItem.backBarButtonItem?.title = "Back"
        self.navigationItem.leftBarButtonItem = nil
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
}

extension MainViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
           }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !(searchBar.text?.isEmpty)!{
            self.navigationItem.title = "Searching: " + searchBar.text!
            self.searchText = searchBar.text!
        }
        else{
            self.navigationItem.title = "Movies"
        }
        
        movieItems.removeAll()
        self.moviesCollectionView.reloadData()
        self.currentPage = 1
        loadData()
        

    }
    func loadData(){
    
            APIHandler.searchMovie(query: self.searchText, page: currentPage, comletion: { (movies) in
                print(movies)
                self.movieItems += movies
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            })
        }
    
}

