//
//  Archieves.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class Archive {
    
    var title = ""
    var imageArchive: UIImage
    
    init(title: String, imageArchive: UIImage) {
        self.title = title
        self.imageArchive = imageArchive
    }
    
    static func FetchArchives () -> [Archive]{
        
        return [ Archive(title: "Archive ", imageArchive: UIImage(named: "Archive" )!) ,
                 Archive(title: " Archive", imageArchive: UIImage(named: "Archive" )!),
                 Archive(title: "Archive ", imageArchive: UIImage(named: "Archive" )!) ,
                 Archive(title: "Archive", imageArchive: UIImage(named: "Archive" )!)
                 
        ]
        
    }
}
