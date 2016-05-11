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

    var meetup = Meetup()

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
                print(json.debugDescription)
            }
        }
    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
