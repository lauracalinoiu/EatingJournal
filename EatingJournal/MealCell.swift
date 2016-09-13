//
//  MealCell.swift
//  EatingJournal
//
//  Created by Laura Calinoiu on 08/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class MealCell: UITableViewCell {
  
  @IBOutlet weak var type: UILabel!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var content: UILabel! { didSet{ content.sizeToFit() }}
  @IBOutlet weak var feedback: UILabel!
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func populateCellWithMeal(meal: Meal){
    type.text = meal.type.rawValue
    date.text = meal.hour.HourFormat()
    content.text = meal.description
    switch meal.rating {
    case .like: feedback.text = "❤︎"
    case .dislike: feedback.text = "✘"
    default: break
    }
    
  }
}
