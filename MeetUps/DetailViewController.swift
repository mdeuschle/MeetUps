//
//  DetailViewController.swift
//  MeetUps
//
//  Created by Matt Deuschle on 5/10/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meetup: Meetup!

    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    @IBOutlet var labelThree: UILabel!
    @IBOutlet var meetupImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = meetup.name
        labelOne.text = meetup.descrip
        labelTwo.text = meetup.who
        labelThree.text = meetup.rsvp

    }


}
