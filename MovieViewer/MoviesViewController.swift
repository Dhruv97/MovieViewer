//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Dhruv Upadhyay on 1/8/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit
import EZLoadingActivity  //EZLoadingActivity.show("Loading...", disableUI: true) Not sure where to put this line of code...
import AFNetworking


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
   
    
    var refresher: UIRefreshControl!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        
        refresh()*/

        tableView.dataSource = self
        tableView.delegate = self
        
       
      EZLoadingActivity.show("Loading...", disableUI: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
      
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                      EZLoadingActivity.hide(success: true, animated: true) 
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            NSLog("response: \(responseDictionary)")
                            
                            
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            
                            self.tableView.reloadData()
                           
                            
                            
                            
                    }
                }
                
                

        });

        
       
task.resume()
       
        
    }
/*
    
  /  func refresh() {
    
        
        self.tableView.reloadData()
        
        self.refresher.endRefreshing()
        
    }*/
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movies {
            return movies.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        
        let imageURL = NSURL(string: baseURL + posterPath)
        
        
        cell.titleLabel.text = title
        
        cell.overviewCell.text = overview
        
        cell.posterView.setImageWithURL(imageURL!)
        
      
        return cell
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        
        let movie = movies![indexPath.row]
        
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
        
    }
    

}
