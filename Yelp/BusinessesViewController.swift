//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        var searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
            
        Business.searchWithTerm("Restaurants", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        })
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var searchTerm = ""
        if searchText == "" {
            searchTerm = "Restaurants"
        }else {
            searchTerm = searchText
        }
        
        Business.searchWithTerm(searchTerm) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            return businesses.count
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BussinessCell
        if let businesses = businesses {
            let business = businesses[indexPath.row]
            cell.business = business
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nc = segue.destinationViewController as! UINavigationController
        let vc = nc.topViewController as! FiltersViewController
        
        vc.delegate = self        
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdate filters: [String : AnyObject]) {
        var categories = filters["categories"] as! [String]
        var deals = filters["deals"] as! Bool
        var sortIndex = filters["sort"] as! Int
        var sort = getSort(sortIndex)
        var radius = filters["radius"] as! Int
        println("filters is \(filters)")
        Business.searchWithTerm("Restaurant", sort: sort, categories: categories, deals: deals, radius:radius) { (businesses:[Business]!, err: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    private func getSort(sortIndex: Int) -> YelpSortMode {
        switch sortIndex{
        case 0: return YelpSortMode.BestMatched
        case 1: return YelpSortMode.Distance
        case 2: return YelpSortMode.HighestRated
        default: return YelpSortMode.BestMatched
        }
    }


}
