//
//  DetailViewController.swift
//  MovieSearch
//
//  Created by Nathan Chen on 6/19/17.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit
import AlamofireImage
class DetailViewController: UIViewController {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: TopAlignLabel!
    @IBOutlet weak var contentVIew: UIView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var movieImageView: UIImageView!
    var movie:MovieItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let imageStr = self.movie?.poster_path,let imageURl = APIHandler.getImageURL(imagePath: imageStr) {
            movieImageView.af_setImage(
                withURL: imageURl,
                imageTransition: .crossDissolve(0.2)
            )
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func setUI(){
        detailScrollView.alwaysBounceVertical = true
        self.contentVIew.autoresizingMask = .flexibleHeight
        self.contentVIew.autoresizesSubviews = true
        self.view.setNeedsLayout()
        if let movieItem = self.movie{
            self.navigationItem.title = movieItem.title
            if let imageStr = movieItem.poster_path, let imageURl = APIHandler.getImageURL(imagePath: imageStr) {
                movieImageView.af_setImage(
                    withURL: imageURl,
                    imageTransition: .crossDissolve(0.2)
                )

                
            }
           self.titleLabel.text = movieItem.title
            self.releaseDateLabel.text = "Release Date:" + (movieItem.release_date ?? "Not Available")
            self.descriptionLabel.text = movieItem.overview ?? "No Description"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController:UIScrollViewDelegate{
    
}

