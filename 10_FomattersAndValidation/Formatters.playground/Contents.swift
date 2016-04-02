
import Foundation

////////////////////////////////////////////////////////////////////////////////
// NSDateFormatter

let dateFormatter = NSDateFormatter()

dateFormatter.dateStyle = .MediumStyle
dateFormatter.timeStyle = .ShortStyle
dateFormatter.stringFromDate(NSDate())

let dateString = "Apr 2, 2016, 4:01 PM"
if let date = dateFormatter.dateFromString(dateString) {
  print(dateFormatter.stringFromDate(date))
}


////////////////////////////////////////////////////////////////////////////////
// NSNumberFormatter

let num = 1_000_000.0

let numberFormatter = NSNumberFormatter()

numberFormatter.numberStyle = .CurrencyStyle
numberFormatter.stringFromNumber(num)

numberFormatter.maximumFractionDigits = 0
numberFormatter.stringFromNumber(num)
