//
//  MovieDetailsViewController.swift
//  MovieViewer
//
//  Created by Dhruv Upadhyay on 1/10/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    
    var movie: NSDictionary!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.size.height)

        titleLabel.text = movie["title"] as! String
        overviewLabel.text = movie["overview"] as! String
  let rating =  movie["vote_average"] as! Double
        
        overviewLabel.sizeToFit()
        
        ratingLabel.text = String(rating)
        
        let posterPath = movie["poster_path"] as! String
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        
        let imageURL = NSURL(string: baseURL + posterPath)
        
        imageView.setImageWithURL(imageURL!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
