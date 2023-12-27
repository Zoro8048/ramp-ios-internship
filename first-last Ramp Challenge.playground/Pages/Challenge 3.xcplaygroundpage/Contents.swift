/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 2](@previous)
//: #### Challenge 3
//: Get the prompt from Challenge 2 and paste it below.
//: Solve the challenge, and take a screenshot of the rendered view.
//: Include the screenshot of the view in your submission!

import Foundation
import SwiftUI
import PlaygroundSupport

let prompt = """
Solve challenge 2 to get the prompt and paste it here.
"""

// Show your work here! When you are done take a screenshot
// of the end result and follow the submission instructions above.
// Include the screenshot of the view in your submission!


PlaygroundPage.current
    .needsIndefiniteExecution = true
PlaygroundPage.current
    .setLiveView(ContentView())

struct AnimatedArc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.radians, endAngle.radians) }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

struct ContentView: View {
    @State private var bgFrame: CGFloat = 0
    @State private var leftEye: Bool = false
    @State private var rightEye: Bool = false
    @State private var degrees: CGFloat = 0
    var body: some View {
        ZStack {
         Circle()
                .fill(Color.yellow)
                .frame(width: bgFrame, height: bgFrame)
                .zIndex(0)
        Circle()
                .fill(Color.black)
                .frame(width: 5, height: 5)
                .zIndex(1)
                .opacity(leftEye ? 1.0 : 0.0)
                .offset(x: -20, y: -20)
        Circle()
                .fill(Color.black)
                .frame(width: 5, height: 5)
                .zIndex(1)
                .opacity(rightEye ? 1.0 : 0.0)
                .offset(x: 20, y: -20)
        AnimatedArc(startAngle: .degrees(0), endAngle: .degrees(degrees))
                .stroke(Color.black, lineWidth: 1)
                .frame(width: 50, height: 50)
        }
        .frame(width: 100, height: 100)
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 0.5)
            ) {
                bgFrame = 100
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    leftEye = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    rightEye = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    degrees = 180
                }
            }
        }
    }
}
