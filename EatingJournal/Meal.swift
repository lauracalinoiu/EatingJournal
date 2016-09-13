//
//  Meal.swift
//  EatingJournal
//
//  Created by Laura Calinoiu on 08/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import Foundation

enum MealType: String{
  case Breakfast
  case Lunch
  case Dinner
  case Snack
}

enum Likeness: String{
  case like
  case dislike
  case neutral
}

struct Meal{
  var type: MealType
  var rating: Likeness
  var hour: NSDate
  var pic: NSURL
  var description: String
}
