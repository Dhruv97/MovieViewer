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


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    
   
    @IBOutlet var errorView: UILabel!
   
    @IBOutlet weak var searchBar: UISearchBar!
       
    var refresher: UIRefreshControl!
    
    var filteredData: [NSDictionary]?

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var movies: [NSDictionary]?

    var selectedMovie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()*/
        
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        
        refresh()

        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
       
        
               let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
                let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        
 EZLoadingActivity.show("Loading...", disableUI: true)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        
       
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            NSLog("response: \(responseDictionary)")
                            
                            
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            
                            self.filteredData = self.movies
                            
                            EZLoadingActivity.hide(success: true, animated: true)

                            self.tableView.reloadData()
                                          
                            
                            
                            
                    }
                }
            
            
        });

        
       
task.resume()
        
    
    }

    
   func refresh() {
    
        
        self.tableView.reloadData()
        
        self.refresher.endRefreshing()
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let filteredMovies = filteredData {
            return filteredMovies.count
        } else {
            return 0
        }    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let rating = movie["vote_average"] as! Double
        
        if  let posterPath = movie["poster_path"] as? String {
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        
        let imageURL = NSURL(string: baseURL + posterPath)
        
            cell.posterView.setImageWithURL(imageURL!)
             cell.posterView.alpha = 0
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
                cell.posterView.alpha = 1
                }, completion: nil)
        
        } else {
            cell.posterView.image = nil
        }
        
        cell.titleLabel.text = title
        
        cell.overviewCell.text = overview
        
       
        
        cell.ratingLabel.text = String(rating)
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedMovie = filteredData![indexPath.row]
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
    
   
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      
        filteredData = searchText.isEmpty ? movies : movies!.filter({(movie: NSDictionary) -> Bool in
            if let title = movie["title"] as? String {
                return title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            }
            return false
        })
        
        tableView.reloadData()
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    

}
