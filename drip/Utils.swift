//
//  Utils.swift
//  drip
//
//  Created by Mateusz Francik on 29/04/2022.
//

import Foundation

class Utils {
    static func checkPESEL(_ pesel: String) -> Bool {
        let range = NSRange(location: 0, length: pesel.count)
        let regex = try! NSRegularExpression(pattern: "^(?<year>[0-9]{2})(?<month>[13579][0-2]|[02468][0-9])(?<day>[0-2][0-9]|3[01])[0-9]{4}(?<checksum>[0-9])$")
        let matches = regex.matches(in: pesel, range: range)
        
        let match = matches.first
        
        if (match != nil) {
            var data: [String: String] = [:]
            for name in ["month", "day", "checksum", "year"] {
                let matchRange = match!.range(withName: name)
                
                if let substringRange = Range(matchRange, in: pesel) {
                    let capture = String(pesel[substringRange])
                    data[name] = capture
                }
            }
            
            let numbers = Array(pesel)
            let weights = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]
            var sum = 0
            for (number, weight) in zip(numbers, weights) {
                sum += number.wholeNumberValue! * weight
            }
        
            print(sum)
            if Int(data["checksum"]!) != (10 - sum%10) % 10 {
                return false
            }
            let day = data["day"]!
            let dayDigits = day[day.index(day.startIndex, offsetBy: 1)].wholeNumberValue!
            switch (day[day.index(day.startIndex, offsetBy: 0)]) {
                case "2":
                    print("case 2")
                    if Int(data["month"]!)! % 20 == 2 {
                        if Int(data["year"]!)! % 4 != 0 {
                            if dayDigits == 9 {
                                return false
                            }
                        }
                    }
                    break
                case "3":
                    print("case 3")
                    if Int(data["month"]!)! % 20 == 2 {
                        return false
                    } else {
                        if Int(data["month"]!)! < 8 {
                            if Int(data["month"]!)! % 2 != 0 {
                                if dayDigits != 0 {
                                    return false
                                }
                            }
                        } else {
                            if Int(data["month"]!)! % 2 == 0 {
                                if dayDigits != 0 {
                                    return false
                                }
                            }
                        }
                    }
                    break
                default:
                    break
            }
            return true
        }
        return false
    }
}
