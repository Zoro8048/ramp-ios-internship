/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 1](@previous)
//: #### Challenge 2
//: Get the prompt from Challenge 1 and paste it below.
//: Solve the challenge to get the prompt for Challenge 3.

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let prompt = """
Solve challenge 1 to get the prompt and paste it here.
"""

// Show your work here! When you are done move on to Challenge 3
// URL for the JSON file
let urlString = "https://api.jsonbin.io/v3/b/646bed328e4aa6225ea22a79"

// X-ACCESS-KEY for authorization
let accessKey = "$2b$10$Ke1iwieFO7/7qsSKU.GYU.oYXZMW1EeHrwd4xx9ylboJik5mstZk6"

// Set up the URL request
var request = URLRequest(url: URL(string: urlString)!)
request.setValue(accessKey, forHTTPHeaderField: "X-Access-Key")

// Perform the request
let semaphore = DispatchSemaphore(value: 0)
var responseData: Data?

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    defer {
        semaphore.signal()
    }

    if let error = error {
        print("Error: \(error)")
        return
    }

    if let data = data {
        responseData = data
    }
}

task.resume()
semaphore.wait()

// Decode JSON
if let jsonData = responseData {
    do {
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        if let jsonObject = json as? [String: Any], let record = jsonObject["record"] as? [String: Any], let dataArray = record["data"] as? [[String: Any]] {

            // Sort the 'data' array by 'bar' key
            let sortedArray = dataArray.sorted { (first, second) -> Bool in
                if let firstBar = first["bar"] as? Int, let secondBar = second["bar"] as? Int {
                    return firstBar < secondBar
                }
                return false
            }
            
            // Filter elements where 'baz' is divisible by 3
            let filteredArray = sortedArray.filter { (element) -> Bool in
            if let baz = element["baz"] as? Int {
                return baz % 3 == 0
                }
                return false
            }

            // Concatenate 'foo' values
            let concatenatedFoo = filteredArray.map { (element) -> String in
                return element["foo"] as? String ?? ""
            }.joined()

            // Print the sorted 'data' array
            print("\(concatenatedFoo)")
        }
    } catch {
        print("Error decoding JSON: \(error)")
    }
}
//: [Challenge 3](@next)
