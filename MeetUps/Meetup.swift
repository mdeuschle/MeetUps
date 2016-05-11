//
//  Meetup.swift
//  MeetUps
//
//  Created by Matt Deuschle on 5/10/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Meetup {

    var descrip = ""
    var eventUrl = ""
    var name = ""
    var who = ""
    var rsvp = ""

    func meetupProperties(json: JSON) {

        self.descrip = json["description"].stringValue
        self.eventUrl = json["event_url"].stringValue
        self.name = json["name"].stringValue
        self.who = json["group"]["who"].stringValue
        self.rsvp = String(json["yes_rsvp_count"].intValue)
    }
}




