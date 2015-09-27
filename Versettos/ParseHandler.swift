//
//  ParseHandler.swift
//  Versettos
//
//  Created by Christian Soler on 9/25/15.
//  Copyright © 2015 Christian Soler & Eduardo Matos. All rights reserved.
//

import Foundation
import Parse

class ParseHandler {
    
    func getVersiculosFromParse(completion: (result: [PFObject]) -> Void) {
        let query = PFQuery(className:"Versiculo")
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if (error == nil && objects != nil){
                completion(result: objects!);
            }
        }
    }
}