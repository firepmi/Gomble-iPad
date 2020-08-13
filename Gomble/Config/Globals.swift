//
//  Globals.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

struct Globals {
    public static func alert(context: UIViewController, title: String, message: String, delayed: Bool = true) {
        if(delayed) {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (_) in

                }))
                context.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (_) in

            }))
            context.present(alert, animated: true, completion: nil)
        }
    }
}
