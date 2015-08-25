//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 20/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!

    init (title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}
