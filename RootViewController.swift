//
//  RootViewController.swift
//  MeetUps
//
//  Created by Matt Deuschle on 5/10/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var meetupTableView: UITableView!

    var meetups = [Meetup]()
    var filteredMeetups = [Meetup]()
    var meetupsArray = [JSON]()
    var meet: Meetup!
    var searchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        meetupTableView.delegate = self
        meetupTableView.dataSource = self
        searchBar.delegate = self

        downloadApi { 

        }
    }

    func downloadApi(downloadComplete: DownloadComplete) {

        let urlString = baseUrl + apiKey
        let url = NSURL(string: urlString)!
        Alamofire.request(.GET, url).responseJSON { response  in

            if let value = response.result.value {

                let json = JSON(value)
                self.meetupsArray = json["results"].arrayValue

                for dic in self.meetupsArray {

                    let meetupObject = Meetup(json: dic)
                    self.meetups.append(meetupObject)
                }
            }
            dispatch_async(dispatch_get_main_queue(), { 
               self.meetupTableView.reloadData()
                self.meetups.sortInPlace({ $0.0.name < $0.1.name
                })
            })
        }.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searchMode {
            return self.filteredMeetups.count
        } else {
            return self.meetups.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MeetupTableViewCell

        if searchMode {

            let meet = filteredMeetups[indexPath.row]
            cell.labelOne.text = meet.name
            cell.labelTwo.text = meet.eventUrl

        } else {

            let filteredMeet = meetups[indexPath.row]
            cell.labelOne.text = filteredMeet.name
            cell.labelTwo.text = filteredMeet.eventUrl
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! DetailViewController

        if searchMode {
            let meet: Meetup!
            meet = filteredMeetups[meetupTableView.indexPathForSelectedRow!.row]
            dvc.meetup = meet

        } else {

            let filteredMeet: Meetup!
            filteredMeet = meetups[meetupTableView.indexPathForSelectedRow!.row]
            dvc.meetup = filteredMeet
        }
    }

    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == "" {

            searchMode = false
            view.endEditing(true)
            meetupTableView.reloadData()

        } else {

            searchMode = true
            let searchText = searchBar.text!
            filteredMeetups = meetups.filter({ $0.name.rangeOfString(searchText) != nil })
            meetupTableView.reloadData()
        }
    }








}
