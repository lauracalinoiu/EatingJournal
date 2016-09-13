//
//  ViewController.swift
//  EatingJournal
//
//  Created by Laura Calinoiu on 08/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class CurrentDayViewController: UIViewController {
  
  var currentDate: NSDate? { didSet { updateUI() } }
  var meals: [Meal] = [Meal(type: .Breakfast, rating: .like, hour: NSDate(), pic: NSURL(), description: "O cana de lapte si una de ceai, o paine buna"), Meal(type: .Lunch, rating: .dislike, hour: NSDate(), pic: NSURL(), description: "Cevapi" )]
  
  @IBOutlet weak var datePicker: UIDatePicker!{ didSet { datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), forControlEvents: .ValueChanged)} }
  
  @IBOutlet weak var mealsTableView: UITableView! {
    didSet {
      mealsTableView.delegate = self
      mealsTableView.dataSource = self
      mealsTableView.estimatedRowHeight = mealsTableView.rowHeight
      mealsTableView.rowHeight = UITableViewAutomaticDimension
    } }
  
  private func updateUI(){
    if let unwrappedCurrentDate = currentDate{
      datePicker.date = unwrappedCurrentDate
    }
  }
  
  func handleDatePicker(sender: UIDatePicker){
    currentDate = sender.date
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    currentDate = NSDate()
    updateUI()
  }
}

extension CurrentDayViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIndentifier, forIndexPath: indexPath) as? MealCell
    let meal = meals[indexPath.row]
    
    cell?.populateCellWithMeal(meal)
    return cell!
  }
}

struct Constants{
  static let cellIndentifier = "Meal Cell"
}

extension NSDate {
  func HourFormat() -> String {
    return NSDateFormatter.HourFormat.stringFromDate(self)
  }
}

extension NSDateFormatter {
  private static let HourFormat: NSDateFormatter = {
    let formatter = NSDateFormatter()
    let timeZone = NSTimeZone(name:"UTC")
    formatter.dateFormat = "HH:mm"
    formatter.timeZone = timeZone
    return formatter
  }()
}
