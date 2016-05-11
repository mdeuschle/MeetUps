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
            })
        }.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetups.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MeetupTableViewCell
        let meet = meetups[indexPath.row]
        cell.labelOne.text = meet.name
        cell.labelTwo.text = meet.eventUrl
        return cell
    }
}
