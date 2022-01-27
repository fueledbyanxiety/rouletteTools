//
//  ContentView.swift
//  RouletteTools 4
//
//  Created by Ben Allen on 9/23/21.
//

import SwiftUI
import Foundation
import MessageUI

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailHelper()
    private override init() {
        //
    }
    
    func sendEmail(subject:String, body:String, to:String){
        if !MFMailComposeViewController.canSendMail() {
            // Utilities.showErrorBanner(title: "No mail account found", subtitle: "Please setup a mail account")
            return //EXIT
        }
        
        let picker = MFMailComposeViewController()
        
        picker.setSubject("App Feedback")
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients(["ben.roulettetools@gmail.com"])
        picker.mailComposeDelegate = self
        
        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController

         // OR If you use SwiftUI 2.0 based WindowGroup try this one
         // UIApplication.shared.windows.first?.rootViewController
    }
}

let screenSize:CGFloat = UIScreen.main.bounds.width
let safeHeight:CGFloat = UIScreen.main.bounds.height * 0.7


let divider:CGFloat = 17
let spacer: CGFloat = ((UIScreen.main.bounds.width / divider) / 13) * 1.4

enum RouletteSquare: String {
    
    // numeric buttons
    case zero, one, two, three, four, five, six
    case seven, eight, nine, ten, eleven, twelve
    case thirteen, fourteen, fifteen, sixteen, seventeen
    case eighteen, nineteen, twenty, twentyone, twentytwo
    case twentythree, twentyfour, twentyfive, twentysix, twentyseven
    case twentyeight, twentynine, thirty, thirtyone, thirtytwo
    case thirtythree, thirtyfour, thirtyfive, thirtysix, doublezero
    // zero barrier buttons
    case zeroOneTwoThree, zeroOneTwo, zeroTwoThree, zeroOne, zeroTwo, zeroThree
    // streets
    case streetOne, streetFour, streetSeven, streetTen, streetThirteen, streetSixteen, streetNineteen, streetTwentyTwo, streetTwentyFive, streetTwentyEight, streetThirtyOne, streetThirtyFour
    // double streets
    case streetOneFour, streetFourSeven, streetSevenTen, streetTenThirteen, streetThirteenSixteen, streetSixteenNineteen, streetNineteenTwentyTwo, streetTwentyTwoTwentyFive, streetTwentyFiveTwentyEight, streetTwentyEightThirtyOne, streetThirtyOneThirtyFour
    // vertical splits
    case oneTwo, twoThree, fourFive, fiveSix, sevenEight, eightNine, tenEleven, elevenTwelve, thirteenFourteen, fourteenFifteen, sixteenSeventeen, seventeenEighteen, nineteenTwenty, twentyTwentyone, twentyTwoTwentyThree, twentyThreeTwentyFour, twentyFiveTwentySix, twentySixTwentySeven, twentyEightTwentyNine, twentyNineThirty, thirtyOneThirtyTwo, thirtyTwoThirtyThree, thirtyFourThirtyFive, thirtyFiveThirtySix
    // horizontal splits
    case oneFour, twoFive, threeSix, fourSeven, fiveEight, sixNine, sevenTen, eightEleven, nineTwelve, tenThirteen, elevenFourteen, twelveFifteen, thirteenSixteen, fourteenSeventeen, fifteenEighteen, sixteenNineteen, seventeenTwenty, eighteenTwentyOne, nineteenTwentyTwo, twentyTwentyThree, twentyOneTwentyFour, twentyTwoTwentyFive, twentyThreeTwentySix, twentyFourTwentySeven, twentyFiveTwentyEight, twentySixTwentyNine, twentySevenThirty, twentyEightThirtyOne, twentyNineThirtyTwo, thirtyThirtyThree, thirtyOneThirtyFour, thirtyTwoThirtyFive, thirtyThreeThirtySix
    // corner / square bets
    case oneTwoFourFive, twoThreeFiveSix, fourFiveSevenEight, fiveSixEightNine, sevenEightTenEleven, eightNineElevenTwelve, tenElevenThirteenFourteen, elevenTwelveFourteenFifteen, thirteenFourteenSixteenSeventeen, fourteenFifteenSeventeenEighteen, sixteenSeventeenNineteenTwenty, seventeenEighteenTwentyTwentyOne, nineteenTwentyTwentyTwoTwentyThree, twentyTwentyOneTwentyThreeTwentyFour, twentyTwoTwentyThreeTwentyFiveTwentySix, twentyThreeTwentyFourTwentySixTwentySeven, twentyFiveTwentySixTwentyEightTwentyNine, twentySixTwentySevenTwentyNineThirty, twentyEightTwentyNineThirtyOneThirtyTwo, twentyNineThirtyThirtyTwoThirtyThree, thirtyOneThirtyTwoThirtyFourThirtyFive, thirtyTwoThirtyThreeThirtyFiveThirtySix
    case firstTwelve, secondTwelve, thirdTwelve
    case firstRow, secondRow, thirdRow
    case firstHalf, secondHalf
    case odds, evens
    case blackSquares, redSquares
    case verticalSpacer, horizontalSpacer
    
    // switch defines border color for each cell based on name
    var squareColor: Color {
        switch self {
        
        case .zero, .doublezero:
            return Color(.green)
        case .zeroOneTwoThree, .zeroOneTwo, .zeroTwoThree, .zeroOne, .zeroTwo, .zeroThree:
            return Color(.white)
        case .one, .three, .five, .seven, .nine, .twelve, .fourteen, .sixteen, .eighteen, .nineteen, .twentyone, .twentythree, .twentyfive, .twentyseven, .thirty, .thirtytwo, .thirtyfour, .thirtysix:
            return Color(.red)
        
        case .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix:
            return Color(.white)
        case .oneFour, .twoFive, .threeSix, .fourSeven, .fiveEight, .sixNine, .sevenTen, .eightEleven, .nineTwelve, .tenThirteen, .elevenFourteen, .twelveFifteen, .thirteenSixteen, .fourteenSeventeen, .fifteenEighteen, .sixteenNineteen, .seventeenTwenty, .eighteenTwentyOne, .nineteenTwentyTwo, .twentyTwentyThree, .twentyOneTwentyFour, .twentyTwoTwentyFive, .twentyThreeTwentySix, .twentyFourTwentySeven, .twentyFiveTwentyEight, .twentySixTwentyNine, .twentySevenThirty, .twentyEightThirtyOne, .twentyNineThirtyTwo, .thirtyThirtyThree, .thirtyOneThirtyFour, .thirtyTwoThirtyFive, .thirtyThreeThirtySix:
            return Color(.white)
        case .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .nineteenTwentyTwentyTwoTwentyThree, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return Color(.white)
        case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return Color(.white)
        case .verticalSpacer:
            return Color(.white)
        default:
            return Color(.black)
            
        }
    }
    
    var textSize: CGFloat {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen, .fourteen, .fifteen, .sixteen, .seventeen, .eighteen, .nineteen, .twenty, .twentyone, .twentytwo, .twentythree, .twentyfour, .twentyfive, .twentysix, .twentyseven, .twentyeight, .twentynine, .thirty, .thirtyone, .thirtytwo, .thirtythree, .thirtyfour, .thirtyfive, .thirtysix:
            return 18
        default:
            return 10
        }
    }
    
    
    // switch defines border color for each cell based on name
    var textColor: Color {
        switch self {
        
        case .zero, .doublezero:
            return Color(.white)
        case .zeroOneTwoThree, .zeroOneTwo, .zeroTwoThree, .zeroOne, .zeroTwo, .zeroThree:
            return Color(.clear)
        case .one, .three, .five, .seven, .nine, .twelve, .fourteen, .sixteen, .eighteen, .nineteen, .twentyone, .twentythree, .twentyfive, .twentyseven, .thirty, .thirtytwo, .thirtyfour, .thirtysix:
            return Color(.white)
        
        case .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix:
            return Color(.clear)
        case .oneFour, .twoFive, .threeSix, .fourSeven, .fiveEight, .sixNine, .sevenTen, .eightEleven, .nineTwelve, .tenThirteen, .elevenFourteen, .twelveFifteen, .thirteenSixteen, .fourteenSeventeen, .fifteenEighteen, .sixteenNineteen, .seventeenTwenty, .eighteenTwentyOne, .nineteenTwentyTwo, .twentyTwentyThree, .twentyOneTwentyFour, .twentyTwoTwentyFive, .twentyThreeTwentySix, .twentyFourTwentySeven, .twentyFiveTwentyEight, .twentySixTwentyNine, .twentySevenThirty, .twentyEightThirtyOne, .twentyNineThirtyTwo, .thirtyThirtyThree, .thirtyOneThirtyFour, .thirtyTwoThirtyFive, .thirtyThreeThirtySix:
            return Color(.clear)
        case .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .nineteenTwentyTwentyTwoTwentyThree, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return Color(.clear)
        case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return Color(.clear)
        case .verticalSpacer:
            return Color(.clear)
        case .firstTwelve, .secondTwelve, .thirdTwelve, .firstHalf, .secondHalf, .odds, .evens, .blackSquares, .redSquares:
            return Color(.white)
        default:
            return Color(.white)
            
        }
    }
    
    
    
        // define width value for cells based on barrier or number square
        var squareWidth: CGFloat {
            switch self {
            case .zero:
                return UIScreen.main.bounds.width / divider
            case .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix:
                return UIScreen.main.bounds.width / divider
            case .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour:
                return UIScreen.main.bounds.width / divider
            case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
                return spacer
            case .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .nineteenTwentyTwentyTwoTwentyThree, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
                return spacer
            case .oneFour, .twoFive, .threeSix, .fourSeven, .fiveEight, .sixNine, .sevenTen, .eightEleven, .nineTwelve, .tenThirteen, .elevenFourteen, .twelveFifteen, .thirteenSixteen, .fourteenSeventeen, .fifteenEighteen, .sixteenNineteen, .seventeenTwenty, .eighteenTwentyOne, .nineteenTwentyTwo, .twentyTwentyThree, .twentyOneTwentyFour, .twentyTwoTwentyFive, .twentyThreeTwentySix, .twentyFourTwentySeven, .twentyFiveTwentyEight, .twentySixTwentyNine, .twentySevenThirty, .twentyEightThirtyOne, .twentyNineThirtyTwo, .thirtyThirtyThree, .thirtyOneThirtyFour, .thirtyTwoThirtyFive, .thirtyThreeThirtySix:
                return spacer
            case .zeroOneTwoThree, .zeroOneTwo, .zeroTwoThree, .zeroOne, .zeroTwo, .zeroThree:
                return spacer
            case .firstTwelve, .secondTwelve, .thirdTwelve:
                return ((UIScreen.main.bounds.width / divider) * 4) + (spacer * 5.3)
            case .firstHalf, .evens, .redSquares, .blackSquares, .odds, .secondHalf:
                return ((UIScreen.main.bounds.width / divider) * 2) + (spacer * 2.7)
            case .verticalSpacer:
                return UIScreen.main.bounds.width / divider
            case .horizontalSpacer:
                return spacer
            default:
                return UIScreen.main.bounds.width / divider
            }
        
    }
    
    
    // define height value for cells based on barrier or number square
    var squareHeight: CGFloat {
        switch self {
        case .zero:
            return ((UIScreen.main.bounds.width / divider) * 3) + (spacer * 3)
        case .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix:
            return spacer
        case .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .nineteenTwentyTwentyTwoTwentyThree, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return spacer
        case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return spacer
        case .zeroOneTwoThree, .zeroOneTwo, .zeroTwoThree:
            return spacer
//        case .firstTwelve, .secondTwelve, .thirdTwelve:
//            return UIScreen.main.bounds.width * 0.065
        case .verticalSpacer:
            return spacer
        default:
            return UIScreen.main.bounds.width / divider // defines height of each numerical square
        }
    
}
    

    // Replace text numbers with actual numbers
    var squareLabel: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .eleven:
            return "11"
        case .twelve:
            return "12"
        case .thirteen:
            return "13"
        case .fourteen:
            return "14"
        case .fifteen:
            return "15"
        case .sixteen:
            return "16"
        case .seventeen:
            return "17"
        case .eighteen:
            return "18"
        case .nineteen:
            return "19"
        case .twenty:
            return "20"
        case .twentyone:
            return "21"
        case .twentytwo:
            return "22"
        case .twentythree:
            return "23"
        case .twentyfour:
            return "24"
        case .twentyfive:
            return "25"
        case .twentysix:
            return "26"
        case .twentyseven:
            return "27"
        case .twentyeight:
            return "28"
        case .twentynine:
            return "29"
        case .thirty:
            return "30"
        case .thirtyone:
            return "31"
        case .thirtytwo:
            return "32"
        case .thirtythree:
            return "33"
        case .thirtyfour:
            return "34"
        case .thirtyfive:
            return "35"
        case .thirtysix:
            return "36"
        case .firstRow:
            return "2 to 1"
        case .secondRow:
            return "2 to 1"
        case .thirdRow:
            return "2 to 1"
        case .firstHalf:
            return "1 - 18"
        case .secondHalf:
            return "19 - 36"
        case .evens:
            return "EVENS"
        case .odds:
            return "ODDS"
        case .firstTwelve:
            return "1st 12"
        case .secondTwelve:
            return "2nd 12"
        case .thirdTwelve:
            return "3rd 12"
        case .redSquares:
            return "REDS"
        case .blackSquares:
            return "BLACKS"
        default:
            return ""
    }
}
    
    // var storedValue defines which number in the array holds the bet size for each square
    var storedValue: Int {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .eleven:
            return 11
        case .twelve:
            return 12
        case .thirteen:
            return 13
        case .fourteen:
            return 14
        case .fifteen:
            return 15
        case .sixteen:
            return 16
        case .seventeen:
            return 17
        case .eighteen:
            return 18
        case .nineteen:
            return 19
        case .twenty:
            return 20
        case .twentyone:
            return 21
        case .twentytwo:
            return 22
        case .twentythree:
            return 23
        case .twentyfour:
            return 24
        case .twentyfive:
            return 25
        case .twentysix:
            return 26
        case .twentyseven:
            return 27
        case .twentyeight:
            return 28
        case .twentynine:
            return 29
        case .thirty:
            return 30
        case .thirtyone:
            return 31
        case .thirtytwo:
            return 32
        case .thirtythree:
            return 33
        case .thirtyfour:
            return 34
        case .thirtyfive:
            return 35
        case .thirtysix:
            return 36
            // Going to divide the array into payout groups. First group is 2-square splits, horizontals
        case .zeroOne:
            return 37
        case .zeroTwo:
            return 38
        case .zeroThree:
            return 39
        case .oneTwo:
            return 40
        case .twoThree:
            return 41
        case .fourFive:
            return 42
        case .fiveSix:
            return 43
        case .sevenEight:
            return 44
        case .eightNine:
            return 45
        case .tenEleven:
            return 46
        case .elevenTwelve:
            return 47
        case .thirteenFourteen:
            return 48
        case .fourteenFifteen:
            return 49
        case .sixteenSeventeen:
            return 50
        case .seventeenEighteen:
            return 51
        case .nineteenTwenty:
            return 52
        case .twentyTwentyone:
            return 53
        case .twentyTwoTwentyThree:
            return 54
        case .twentyThreeTwentyFour:
            return 55
        case .twentyFiveTwentySix:
            return 56
        case .twentySixTwentySeven:
            return 57
        case .twentyEightTwentyNine:
            return 58
        case .twentyNineThirty:
            return 59
        case .thirtyOneThirtyTwo:
            return 60
        case .thirtyTwoThirtyThree:
            return 61
        case .thirtyFourThirtyFive:
            return 62
        case .thirtyFiveThirtySix:
            return 63
        // Second group is 2-square splits, verticals
        case .oneFour:
            return 64
        case .twoFive:
            return 65
        case .threeSix:
            return 66
        case .fourSeven:
            return 67
        case .fiveEight:
            return 68
        case .sixNine:
            return 69
        case .sevenTen:
            return 70
        case .eightEleven:
            return 71
        case .nineTwelve:
            return 72
        case .tenThirteen:
            return 73
        case .elevenFourteen:
            return 74
        case .twelveFifteen:
            return 75
        case .thirteenSixteen:
            return 76
        case .fourteenSeventeen:
            return 77
        case .fifteenEighteen:
            return 78
        case .sixteenNineteen:
            return 79
        case .seventeenTwenty:
            return 80
        case .eighteenTwentyOne:
            return 81
        case .nineteenTwentyTwo:
            return 82
        case .twentyTwentyThree:
            return 83
        case .twentyOneTwentyFour:
            return 84
        case .twentyTwoTwentyFive:
            return 85
        case .twentyThreeTwentySix:
            return 86
        case .twentyFourTwentySeven:
            return 87
        case .twentyFiveTwentyEight:
            return 88
        case .twentySixTwentyNine:
            return 89
        case .twentySevenThirty:
            return 90
        case .twentyEightThirtyOne:
            return 91
        case .twentyNineThirtyTwo:
            return 92
        case .thirtyThirtyThree:
            return 93
        case .thirtyOneThirtyFour:
            return 94
        case .thirtyTwoThirtyFive:
            return 95
        case .thirtyThreeThirtySix:
            return 96
            // Third group is 3-way zero bets
        case .zeroOneTwo:
            return 97
        case .zeroTwoThree:
            return 98
            // fourth group: streets
        case .streetOne:
            return 99
        case .streetFour:
            return 100
        case .streetSeven:
            return 101
        case .streetTen:
            return 102
        case .streetThirteen:
            return 103
        case .streetSixteen:
            return 104
        case .streetNineteen:
            return 105
        case .streetTwentyTwo:
            return 106
        case .streetTwentyFive:
            return 107
        case .streetTwentyEight:
            return 108
        case .streetThirtyOne:
            return 109
        case .streetThirtyFour:
            return 110
            // fifth group: 4-ways / corners
        case .zeroOneTwoThree:
            return 111
        case .oneTwoFourFive:
            return 112
        case .twoThreeFiveSix:
            return 113
        case .fourFiveSevenEight:
            return 114
        case .fiveSixEightNine:
            return 115
        case .sevenEightTenEleven:
            return 116
        case .eightNineElevenTwelve:
            return 117
        case .tenElevenThirteenFourteen:
            return 118
        case .elevenTwelveFourteenFifteen:
            return 119
        case .thirteenFourteenSixteenSeventeen:
            return 120
        case .fourteenFifteenSeventeenEighteen:
            return 121
        case .sixteenSeventeenNineteenTwenty:
            return 122
        case .seventeenEighteenTwentyTwentyOne:
            return 123
        case .nineteenTwentyTwentyTwoTwentyThree:
            return 124
        case .twentyTwentyOneTwentyThreeTwentyFour:
            return 125
        case .twentyTwoTwentyThreeTwentyFiveTwentySix:
            return 126
        case .twentyThreeTwentyFourTwentySixTwentySeven:
            return 127
        case .twentyFiveTwentySixTwentyEightTwentyNine:
            return 128
        case .twentySixTwentySevenTwentyNineThirty:
            return 129
        case .twentyEightTwentyNineThirtyOneThirtyTwo:
            return 130
        case .twentyNineThirtyThirtyTwoThirtyThree:
            return 131
        case .thirtyOneThirtyTwoThirtyFourThirtyFive:
            return 132
        case .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return 133
            // sixth group: double streets
        case .streetOneFour:
            return 134
        case .streetFourSeven:
            return 135
        case .streetSevenTen:
            return 136
        case .streetTenThirteen:
            return 137
        case .streetThirteenSixteen:
            return 138
        case .streetSixteenNineteen:
            return 139
        case .streetNineteenTwentyTwo:
            return 140
        case .streetTwentyTwoTwentyFive:
            return 141
        case .streetTwentyFiveTwentyEight:
            return 142
        case .streetTwentyEightThirtyOne:
            return 143
        case .streetThirtyOneThirtyFour:
            return 144
            // seventh group: twelves
        case .firstTwelve:
            return 145
        case .secondTwelve:
            return 146
        case .thirdTwelve:
            return 147
            // eighth group: rows
        case .firstRow:
            return 148
        case .secondRow:
            return 149
        case .thirdRow:
            return 150
            // ninth group: even money bets
        case .firstHalf:
            return 151
        case .secondHalf:
            return 152
        case .evens:
            return 153
        case .odds:
            return 154
        case .redSquares:
            return 155
        case .blackSquares:
            return 156
        default:
            return 157
        }
    }
    
    var isNumberButton: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen, .fourteen, .fifteen, .sixteen, .seventeen, .eighteen, .nineteen, .twenty, .twentyone, .twentytwo, .twentythree, .twentyfour, .twentyfive, .twentysix, .twentyseven, .twentyeight, .twentynine, .thirty, .thirtyone, .thirtytwo, .thirtythree, .thirtyfour, .thirtyfive, .thirtysix:
            return true
        default:
            return false
        }
    }
    
    // boolean to perhaps improve touch area of smaller buttons, starting with corners (4-number squares)
    var touchArea: CGFloat {
        switch self {

        case .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .nineteenTwentyTwentyTwoTwentyThree, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix, .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return spacer * 6
        
        default:
            return 0
            
        }
    }
    
    var storedValuePayout: CGFloat {
        switch self {
        // payout value for each location
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen, .fourteen, .fifteen, .sixteen, .seventeen, .eighteen, .nineteen, .twenty, .twentyone, .twentytwo, .twentythree, .twentyfour, .twentyfive, .twentysix, .twentyseven, .twentyeight, .twentynine, .thirty, .thirtyone, .thirtytwo, .thirtythree, .thirtyfour, .thirtyfive, .thirtysix:
            return 35
            // payout for splits
        case .zeroOne, .zeroTwo, .zeroThree, .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix, .oneFour, .twoFive, .threeSix, .fourSeven, .fiveEight, .sixNine, .sevenTen, .eightEleven, .nineTwelve, .tenThirteen, .elevenFourteen, .twelveFifteen, .thirteenSixteen, .fourteenSeventeen, .fifteenEighteen, .sixteenNineteen, .seventeenTwenty, .eighteenTwentyOne, .nineteenTwentyTwo, .twentyTwentyThree, .twentyOneTwentyFour, .twentyTwoTwentyFive, .twentyThreeTwentySix, .twentyFourTwentySeven, .twentyFiveTwentyEight, .twentySixTwentyNine, .twentySevenThirty, .twentyEightThirtyOne, .twentyNineThirtyTwo, .thirtyThirtyThree, .thirtyOneThirtyFour, .thirtyTwoThirtyFive, .thirtyThreeThirtySix:
            return 17
            // payout for 3-ways / streets
        case .zeroOneTwo, .zeroTwoThree, .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour:
            return 11
            // payout for double streets
        case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return 5
            // payout for 4-ways / corners
        case .zeroOneTwoThree, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return 8
            // payout for twelves
        case .firstTwelve, .secondTwelve, .thirdTwelve:
            return 2
            // payout for rows
        case .firstRow, .secondRow, .thirdRow:
            return 2
            // payout for even money bets
        case .firstHalf, .secondHalf, .evens, .odds, .redSquares, .blackSquares:
            return 1
        default:
            return 999
        }
    }
    
    var storedValueOdds: CGFloat {
        switch self {
        // odds value for each cell according to EV formula ($W * %W) - ($L * %L) where
        // Money won is (Bet size * payout)
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen, .fourteen, .fifteen, .sixteen, .seventeen, .eighteen, .nineteen, .twenty, .twentyone, .twentytwo, .twentythree, .twentyfour, .twentyfive, .twentysix, .twentyseven, .twentyeight, .twentynine, .thirty, .thirtyone, .thirtytwo, .thirtythree, .thirtyfour, .thirtyfive, .thirtysix:
            return (1 / 37)
            // odds for splits
        case .zeroOne, .zeroTwo, .zeroThree, .oneTwo, .twoThree, .fourFive, .fiveSix, .sevenEight, .eightNine, .tenEleven, .elevenTwelve, .thirteenFourteen, .fourteenFifteen, .sixteenSeventeen, .seventeenEighteen, .nineteenTwenty, .twentyTwentyone, .twentyTwoTwentyThree, .twentyThreeTwentyFour, .twentyFiveTwentySix, .twentySixTwentySeven, .twentyEightTwentyNine, .twentyNineThirty, .thirtyOneThirtyTwo, .thirtyTwoThirtyThree, .thirtyFourThirtyFive, .thirtyFiveThirtySix, .oneFour, .twoFive, .threeSix, .fourSeven, .fiveEight, .sixNine, .sevenTen, .eightEleven, .nineTwelve, .tenThirteen, .elevenFourteen, .twelveFifteen, .thirteenSixteen, .fourteenSeventeen, .fifteenEighteen, .sixteenNineteen, .seventeenTwenty, .eighteenTwentyOne, .nineteenTwentyTwo, .twentyTwentyThree, .twentyOneTwentyFour, .twentyTwoTwentyFive, .twentyThreeTwentySix, .twentyFourTwentySeven, .twentyFiveTwentyEight, .twentySixTwentyNine, .twentySevenThirty, .twentyEightThirtyOne, .twentyNineThirtyTwo, .thirtyThirtyThree, .thirtyOneThirtyFour, .thirtyTwoThirtyFive, .thirtyThreeThirtySix:
            return (2 / 37)
            // odds for 3-ways / streets
        case .zeroOneTwo, .zeroTwoThree, .streetOne, .streetFour, .streetSeven, .streetTen, .streetThirteen, .streetSixteen, .streetNineteen, .streetTwentyTwo, .streetTwentyFive, .streetTwentyEight, .streetThirtyOne, .streetThirtyFour:
            return (3 / 37)
            // odds for double streets
        case .streetOneFour, .streetFourSeven, .streetSevenTen, .streetTenThirteen, .streetThirteenSixteen, .streetSixteenNineteen, .streetNineteenTwentyTwo, .streetTwentyTwoTwentyFive, .streetTwentyFiveTwentyEight, .streetTwentyEightThirtyOne, .streetThirtyOneThirtyFour:
            return (6 / 37)
            
            // odds for 4-ways / corners
        case .zeroOneTwoThree, .oneTwoFourFive, .twoThreeFiveSix, .fourFiveSevenEight, .fiveSixEightNine, .sevenEightTenEleven, .eightNineElevenTwelve, .tenElevenThirteenFourteen, .elevenTwelveFourteenFifteen, .thirteenFourteenSixteenSeventeen, .fourteenFifteenSeventeenEighteen, .sixteenSeventeenNineteenTwenty, .seventeenEighteenTwentyTwentyOne, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwoTwentyThreeTwentyFiveTwentySix, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyFiveTwentySixTwentyEightTwentyNine, .twentySixTwentySevenTwentyNineThirty, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyNineThirtyThirtyTwoThirtyThree, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyTwoThirtyThreeThirtyFiveThirtySix:
            return (4 / 37)
            // odds for twelves
        case .firstTwelve, .secondTwelve, .thirdTwelve:
            return (12 / 37)
            // odds for rows
        case .firstRow, .secondRow, .thirdRow:
            return (12 / 37)
            // odds for even money bets
        case .firstHalf, .secondHalf, .evens, .odds, .redSquares, .blackSquares:
            return (18 / 37)
        default:
            return 999
        }
    }
}

let boxWidth = UIScreen.main.bounds.width * 0.065
let boxHeight = UIScreen.main.bounds.width * 0.065
let wheelheight = UIScreen.main.bounds.height + 20

var myVar = 1
var myVar1 = 0

//enum rouletteWheelLabels: String {
//        case "1", "2", 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 0
//    var squareColor: Color {
//        switch self {
//
//        case .zero, .doublezero:
//            return Color(.green)
//
//    }

struct ContentView: View {
    
    
    // buttons 2D array defines the columns of the roulette board. Need to be ordered top-down
    let buttons: [[RouletteSquare]] = [
        [.zero],
        // zero split bets barriers
        [.zeroThree, .zeroTwoThree, .zeroTwo, .zeroOneTwo, .zeroOne, .zeroOneTwoThree, ],
        // 1 2 3 row FIXED
        [.three, .twoThree, .two, .oneTwo, .one, .streetOne],
        // divider row FIXED
        [.threeSix, .twoThreeFiveSix, .twoFive, .oneTwoFourFive, .oneFour, .streetOneFour],
        // 4 5 6 row FIXED
        [.six, .fiveSix, .five, .fourFive, .four, .streetFour],
        // divider row FIXED
        [.sixNine, .fiveSixEightNine, .fiveEight, .fourFiveSevenEight, .fourSeven, .streetFourSeven],
        // 7 8 9 row FIXED
        [.nine, .eightNine, .eight, .sevenEight, .seven, .streetSeven],
        // divider row FIXED
        [.nineTwelve, .eightNineElevenTwelve, .eightEleven, .sevenEightTenEleven, .sevenTen, .streetSevenTen],
        // 10 11 12 row FIXED
        [.twelve, .elevenTwelve, .eleven, .tenEleven, .ten, .streetTen],
        // divider row FIXED
        [.twelveFifteen, .elevenTwelveFourteenFifteen, .elevenFourteen, .tenElevenThirteenFourteen, .tenThirteen, .streetTenThirteen],
        // 13 14 15 row FIXED
        [.fifteen, .fourteenFifteen, .fourteen, .thirteenFourteen, .thirteen, .streetThirteen],
        // divider row FIXED
        [.fifteenEighteen, .fourteenFifteenSeventeenEighteen, .fourteenSeventeen, .thirteenFourteenSixteenSeventeen, .thirteenSixteen, .streetThirteenSixteen],
        // 16 17 18 row FIXED
        [.eighteen, .seventeenEighteen, .seventeen, .sixteenSeventeen, .sixteen, .streetSixteen],
        // divider row FIXED
        [.eighteenTwentyOne, .seventeenEighteenTwentyTwentyOne, .seventeenTwenty, .sixteenSeventeenNineteenTwenty, .sixteenNineteen, .streetSixteenNineteen],
        // 19 20 21 row FIXED
        [.twentyone, .twentyTwentyone, .twenty, .nineteenTwenty, .nineteen, .streetNineteen],
        // divider row FIXED
        [.twentyOneTwentyFour, .twentyTwentyOneTwentyThreeTwentyFour, .twentyTwentyThree, .nineteenTwentyTwentyTwoTwentyThree, .nineteenTwentyTwo, .streetNineteenTwentyTwo],
        // 22 23 24 row FIXED
        [.twentyfour, .twentyThreeTwentyFour, .twentythree, .twentyTwoTwentyThree, .twentytwo, .streetTwentyTwo],
        // divider row FIXED
        [.twentyFourTwentySeven, .twentyThreeTwentyFourTwentySixTwentySeven, .twentyThreeTwentySix, .twentyTwoTwentyThreeTwentyFiveTwentySix,.twentyTwoTwentyFive, .streetTwentyTwoTwentyFive],
        // 25 26 27 row FIXED
        [.twentyseven, .twentySixTwentySeven, .twentysix, .twentyFiveTwentySix, .twentyfive, .streetTwentyFive],
        // divider row FIXED
        [.twentySevenThirty, .twentySixTwentySevenTwentyNineThirty, .twentySixTwentyNine, .twentyFiveTwentySixTwentyEightTwentyNine, .twentyFiveTwentyEight, .streetTwentyFiveTwentyEight],
        // 28 29 30 row FIXED
        [.thirty, .twentyNineThirty, .twentynine, .twentyEightTwentyNine, .twentyeight, .streetTwentyEight],
        // divider row FIXED
        [.thirtyThirtyThree, .twentyNineThirtyThirtyTwoThirtyThree, .twentyNineThirtyTwo, .twentyEightTwentyNineThirtyOneThirtyTwo, .twentyEightThirtyOne, .streetTwentyEightThirtyOne],
        // 31 32 33 row FIXED
        [.thirtythree, .thirtyTwoThirtyThree, .thirtytwo, .thirtyOneThirtyTwo, .thirtyone, .streetThirtyOne],
        // divider row FIXED
        [.thirtyThreeThirtySix, .thirtyTwoThirtyThreeThirtyFiveThirtySix, .thirtyTwoThirtyFive, .thirtyOneThirtyTwoThirtyFourThirtyFive, .thirtyOneThirtyFour, .streetThirtyOneThirtyFour],
        // 34 35 36 row FIXED
        [.thirtysix, .thirtyFiveThirtySix, .thirtyfive, .thirtyFourThirtyFive, .thirtyfour, .streetThirtyFour],
        // Rows
        [.thirdRow, .verticalSpacer, .secondRow, .verticalSpacer, .firstRow, .verticalSpacer]
    ]
    let outerButtons: [[RouletteSquare]] = [
        [.firstTwelve, .secondTwelve, .thirdTwelve],
        [.firstHalf, .evens, .redSquares, .blackSquares, .odds, .secondHalf]
    ]
    
    

    
    
    // array values are correlated to board number and barrier squares by storedValue variable within roulette enum above, row 265ish
    @State private var rouletteNumBetSize: [Int] = [
        0, // bet value container for 0
        0, // bet value container for 1
        0, // bet value container for 2
        0, // bet value container for 3
        0, // bet value container for 4
        0, // bet value container for 5
        0, // bet value container for 6
        0, // bet value container for 7
        0, // bet value container for 8
        0, // bet value container for 9
        0, // bet value container for 10
        0, // bet value container for 11
        0, // bet value container for 12
        0, // bet value container for 13
        0, // bet value container for 14
        0, // bet value container for 15
        0, // bet value container for 16
        0, // bet value container for 17
        0, // bet value container for 18
        0, // bet value container for 19
        0, // bet value container for 20
        0, // bet value container for 21
        0, // bet value container for 22
        0, // bet value container for 23
        0, // bet value container for 24
        0, // bet value container for 25
        0, // bet value container for 26
        0, // bet value container for 27
        0, // bet value container for 28
        0, // bet value container for 29
        0, // bet value container for 30
        0, // bet value container for 31
        0, // bet value container for 32
        0, // bet value container for 33
        0, // bet value container for 34
        0, // bet value container for 35
        0, // bet value container for 36 (37 array entries so far)
//        barrier squares: horizontal splits
        0, // bet value container for .zeroOne
        0, // bet value container for .zeroTwo
        0, // bet value container for .zeroThree
        0, // bet value container for .oneTwo
        0, // bet value container for .twoThree
        0, // bet value container for .threeFour
        0, // bet value container for .fourSeven
        0, // bet value container for .fiveEight
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // barrier squares: vertical splits
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0, // 75 array entires so far
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // third group: 3-way zero bets
        0, // .zeroOneTwo
        0, // .zeroTwoThree
        // fourth group: streets
        0,
        0,
        0,
        0, // 100 array entires so far
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // fifth group: 4-ways / corners
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0, // 125 array entries so far
        0,
        0,
        0,
        0,
        0,
        // sixth group: double streets
        0, // 1-4
        0, // 4-7
        0, // 7-10
        0, // 10-13
        0, // 13-16
        0, // 16-19
        0, // 19-22
        0, // 22-25
        0, // 25-28
        0, // 28-31
        0, // 31-34
        // seventh group: twelves
        0, // first 12
        0, // second 12
        0, // third 12
        // Twelves
        0, // 145: first 12 (CORRECTED)
        0, // 146: second 12 (CORRECTED)
        0, // 147: third 12 (CORRECTED)
        // Rows
        0, // 148: first row (CORRECTED)
        0, // 149: second row (CORRECTED)
        0, // 150: third row (CORRECTED)
        // Even Money Bets
        0, // 151: 1 - 18 (CORRECTED)
        0, // 152: 19 - 36 (CORRECTED)
        0, // 153: EVENS (CORRECTED)
        0, // 154: ODDS (CORRECTED)
        0, // 155: REDS (CORRECTED)
        0, // 156: BLACKS (CORRECTED)
        0, // 157 total right here...but program has a meltdown without the extra two zeroes
        //
        0,
        0
        
        ]
    
    // These array values hold the result of formula ((Betsize * payout) * odds) - "All other bets" ??? Verify this
    @State private var squareProfit: [CGFloat] = [
        0, // bet value container for 0
        0, // bet value container for 1
        0, // bet value container for 2
        0, // bet value container for 3
        0, // bet value container for 4
        0, // bet value container for 5
        0, // bet value container for 6
        0, // bet value container for 7
        0, // bet value container for 8
        0, // bet value container for 9
        0, // bet value container for 10
        0, // bet value container for 11
        0, // bet value container for 12
        0, // bet value container for 13
        0, // bet value container for 14
        0, // bet value container for 15
        0, // bet value container for 16
        0, // bet value container for 17
        0, // bet value container for 18
        0, // bet value container for 19
        0, // bet value container for 20
        0, // bet value container for 21
        0, // bet value container for 22
        0, // bet value container for 23
        0, // bet value container for 24
        0, // bet value container for 25
        0, // bet value container for 26
        0, // bet value container for 27
        0, // bet value container for 28
        0, // bet value container for 29
        0, // bet value container for 30
        0, // bet value container for 31
        0, // bet value container for 32
        0, // bet value container for 33
        0, // bet value container for 34
        0, // bet value container for 35
        0, // bet value container for 36
//        barrier squares: horizontal splits
        0, // bet value container for .zeroOne
        0, // bet value container for .zeroTwo
        0, // bet value container for .zeroThree
        0, // bet value container for .oneTwo
        0, // bet value container for .twoThree
        0, // bet value container for .threeFour
        0, // bet value container for .fourSeven
        0, // bet value container for .fiveEight
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // barrier squares: vertical splits
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // third group: 3-way zero bets
        0, // .zeroOneTwo
        0, // .zeroTwoThree
        // fourth group: streets
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // fifth group: 4-ways / corners
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        // sixth group: double streets
        0, // 1-4
        0, // 4-7
        0, // 7-10
        0, // 10-13
        0, // 13-16
        0, // 16-19
        0, // 19-22
        0, // 22-25
        0, // 25-28
        0, // 28-31
        0, // 31-34
        // seventh group: twelves
        0, // first 12
        0, // second 12
        0, // third 12
        // eighth group: rows
        0, // first row
        0, // second row
        0, // third row
        // ninth group: even money bets
        0, // first half
        0, // second half
        0, // evens
        0, // odds
        0, // reds
        0, // blacks
        // end? Bad math
        0,
        0,
        0,
        0,
        0,
        0
        
        ]
    
    // These array values hold the result of formula ((Betsize * payout) * odds) - "All other bets" ??? Verify this
    @State private var squareOdds: [CGFloat] = [
        0.027027027027027, // bet value container for 0
        0.027027027027027, // bet value container for 1
        0.027027027027027, // bet value container for 2
        0.027027027027027, // bet value container for 3
        0.027027027027027, // bet value container for 4
        0.027027027027027, // bet value container for 5
        0.027027027027027, // bet value container for 6
        0.027027027027027, // bet value container for 7
        0.027027027027027, // bet value container for 8
        0.027027027027027, // bet value container for 9
        0.027027027027027, // bet value container for 10
        0.027027027027027, // bet value container for 11
        0.027027027027027, // bet value container for 12
        0.027027027027027, // bet value container for 13
        0.027027027027027, // bet value container for 14
        0.027027027027027, // bet value container for 15
        0.027027027027027, // bet value container for 16
        0.027027027027027, // bet value container for 17
        0.027027027027027, // bet value container for 18
        0.027027027027027, // bet value container for 19
        0.027027027027027, // bet value container for 20
        0.027027027027027, // bet value container for 21
        0.027027027027027, // bet value container for 22
        0.027027027027027, // bet value container for 23
        0.027027027027027, // bet value container for 24
        0.027027027027027, // bet value container for 25
        0.027027027027027, // bet value container for 26
        0.027027027027027, // bet value container for 27
        0.0270270270270270, // bet value container for 28
        0.027027027027027, // bet value container for 29
        0.027027027027027, // bet value container for 30
        0.027027027027027, // bet value container for 31
        0.027027027027027, // bet value container for 32
        0.027027027027027, // bet value container for 33
        0.027027027027027, // bet value container for 34
        0.027027027027027, // bet value container for 35
        0.027027027027027, // bet value container for 36
//        barrier squares: horizontal splits
        0.459459459459459, // bet value container for .zeroOne
        0.459459459459459, // bet value container for .zeroTwo
        0.459459459459459, // bet value container for .zeroThree
        0.459459459459459, // bet value container for .oneTwo
        0.459459459459459, // bet value container for .twoThree
        0.459459459459459, // bet value container for .threeFour
        0.459459459459459, // bet value container for .fourSeven
        0.459459459459459, // bet value container for .fiveEight
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        // barrier squares: vertical splits
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        0.459459459459459,
        // third group: 3-way zero bets
        0.081081081081081, // .zeroOneTwo
        0.081081081081081, // .zeroTwoThree
        // fourth group: streets
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.0810810810810810,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        0.081081081081081,
        // fifth group: 4-ways / corners
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        0.2162162162162160,
        0.216216216216216,
        0.216216216216216,
        0.216216216216216,
        // sixth group: double streets
        0.135135135135135, // 1-4
        0.135135135135135, // 4-7
        0.1351351351351350, // 7-10
        0.1351351351351350, // 10-13
        0.135135135135135, // 13-16
        0.135135135135135, // 16-19
        0.1351351351351350, // 19-22
        0.135135135135135, // 22-25
        0.135135135135135, // 25-28
        0.135135135135135, // 28-31
        0.1351351351351350, // 31-34
        // seventh group: twelves
        0.324324324324324, // first 12
        0.324324324324324, // second 12
        0.324324324324324, // third 12
        // eighth group: rows
        0.324324324324324, // first row
        0.324324324324324, // second row
        0.324324324324324, // third row
        // ninth group: even money bets
        0.486486486486486, // first half
        0.486486486486486, // second half
        0.486486486486486, // evens
        0.486486486486486, // odds
        0.486486486486486, // reds
        0.486486486486486, // blacks
        // end? Bad math
        0,
        0,
        0,
        0,
        0,
        0
        
        ]
    
    // These array values hold the result of formula ((Betsize * payout) * odds) - "All other bets" ??? Verify this
    @State private var squarePayout: [CGFloat] = [
        35, // bet value container for 0
        35, // bet value container for 1
        35, // bet value container for 2
        35, // bet value container for 3
        35, // bet value container for 4
        35, // bet value container for 5
        35, // bet value container for 6
        35, // bet value container for 7
        35, // bet value container for 8
        35, // bet value container for 9
        35, // bet value container for 10
        35, // bet value container for 11
        35, // bet value container for 12
        35, // bet value container for 13
        35, // bet value container for 14
        35, // bet value container for 15
        35, // bet value container for 16
        35, // bet value container for 17
        35, // bet value container for 18
        35, // bet value container for 19
        35, // bet value container for 20
        35, // bet value container for 21
        35, // bet value container for 22
        35, // bet value container for 23
        35, // bet value container for 24
        35, // bet value container for 25
        35, // bet value container for 26
        35, // bet value container for 27
        35, // bet value container for 28
        35, // bet value container for 29
        35, // bet value container for 30
        35, // bet value container for 31
        35, // bet value container for 32
        35, // bet value container for 33
        35, // bet value container for 34
        35, // bet value container for 35
        35, // bet value container for 36
//        barrier squares: horizontal splits
        17, // bet value container for .zeroOne
        17, // bet value container for .zeroTwo
        17, // bet value container for .zeroThree
        17, // bet value container for .oneTwo
        17, // bet value container for .twoThree
        17, // bet value container for .threeFour
        17, // bet value container for .fourSeven
        17, // bet value container for .fiveEight
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        // barrier squares: vertical splits
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        17,
        // third group: 3-way zero bets
        11, // .zeroOneTwo
        11, // .zeroTwoThree
        // fourth group: streets
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        11,
        // fifth group: 4-ways / corners
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        8,
        // sixth group: double streets
        5, // 1-4
        5, // 4-7
        5, // 7-10
        5, // 10-13
        5, // 13-16
        5, // 16-19
        5, // 19-22
        5, // 22-25
        5, // 25-28
        5, // 28-31
        5, // 31-34
        // seventh group: twelves
        2, // first 12
        2, // second 12
        2, // third 12
        // eighth group: rows
        2, // first row
        2, // second row
        2, // third row
        // ninth group: even money bets
        1, // first half
        1, // second half
        1, // evens
        1, // odds
        1, // reds
        1, // blacks
        // end? Bad math
        0,
        0,
        0,
        0,
        0,
        0
        
        ]
    
    
    @State var selectedIndex = 0
    @State var summedArray = 0
   //  @State var rouletteNumber = 0
    let tabBarImageNames = ["person", "lasso", "gear", "plus.app.fill", "pencil", "lasso"]
    
 //   class RouletteMath {
        
       @State private var rouletteNumbers: [Int] = [
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
            24,
            25,
            26,
            27,
            28,
            29,
            30,
            31,
            32,
            33,
            34,
            35,
            36
        ]
    
    @State var buttonChip: [UIImage] = [
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
        UIImage(named: "redchip")!,
    ]
    
    @State var percentReturn: [CGFloat] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]
    
    @State var colorPercent: [Int] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]
    
    
    @State var redValue: [Double] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]
    
    @State var greenValue: [Double] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]
    
    @State var blueValue: [Double] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]
    
    
    
//    @State var isHidden: [Bool] = [
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//        false,
//    ]
    
    @State var blackBetIsRemoved = false
    @State var redBetIsRemoved = false
    @State var evenBetIsRemoved = false
    @State var oddBetIsRemoved = false
    @State var firstHalfBetIsRemoved = false
    @State var secondHalfBetIsRemoved = false
    @State var firstTwelveBetIsRemoved = false
    @State var secondTwelveBetIsRemoved = false
    @State var thirdTwelveBetIsRemoved = false
    @State var firstRowBetIsRemoved = false
    @State var secondRowBetIsRemoved = false
    @State var thirdRowBetIsRemoved = false
    
    @State var payout = 0
    @State var boundary = 0
    @State var profitableSquares = 0.00
    
    @State var totalBets: Int = 0
    @State var doubleUpOrMore:Int = 0
    @State var biggestHit:Int = 0
    @State var ev:CGFloat = 0
    @State var heatmapPositiveMultiplier:CGFloat = 1.01
    @State var heatmapNegativeMultiplier:CGFloat = -1.01
    @State var biggestWinners: [Int] = []
    @State var joinedWinners:String = ""
    
    
    func heatMap() {
        
        heatmapPositiveMultiplier = CGFloat(squareProfit.max()!)
        heatmapNegativeMultiplier = CGFloat(squareProfit.min()!)
        heatmapPositiveMultiplier = 255 / heatmapPositiveMultiplier
        heatmapNegativeMultiplier = 255 / heatmapNegativeMultiplier
        
        for n in 0...36 {
//            colorPercent[n] = Int(squareProfit[n]) / totalBets
            if squareProfit[n] > 0 {
                greenValue[n] = Double(squareProfit[n] * heatmapPositiveMultiplier)
                redValue[n] = (255 - greenValue[n]) / 255
                blueValue[n] = 0
//                greenValue[n] = Double(greenValue[n])
            }
            if squareProfit[n] < 0 {
                redValue[n] = Double(squareProfit[n] * heatmapNegativeMultiplier)
//                redValue[n] = Double(redValue[n])
                greenValue[n] = (255 - redValue[n]) / 255
                blueValue[n] = 0
            }
            if squareProfit[n] == 0 {
                redValue[n] = 90
//                redValue[n] = Double(redValue[n])
                greenValue[n] = 191
                blueValue[n] = 213
            }
            
            percentReturn[n] = (CGFloat(squareProfit[n]) / CGFloat(totalBets)) * 100
            percentReturn[n] = round(percentReturn[n] * 100) / 100.0
//            green = Int(squareProfit[n]) / totalBets
//            red = green * -1
        }
    }
    
    func updateStats() {
        biggestWinners.removeAll()
        doubleUpOrMore = 0
        biggestHit = Int(squareProfit.max()!)
        ev = 0
        for n in 0...37 {
            if squareProfit[n] >= CGFloat(totalBets) {
                doubleUpOrMore += 1
                
            }
            if Int(squareProfit[n]) >= biggestHit {
                biggestWinners.append(n)
        }
            ev = ev + (squareProfit[n] * (1/37))
        }
        ev = round(ev * 1000) / 100.0
        
        for entry in 0...(biggestWinners.count - 1) {
            if entry == 0 {
                joinedWinners = String(biggestWinners[0]) + ", "
            } else {
        joinedWinners = joinedWinners + String(biggestWinners[entry]) + ", "
            }
        }
        joinedWinners = joinedWinners + ": $"
    }
    
    func lossMath(rouletteNumber: Int, isRed: Bool = false, isBlack: Bool = false, isFirstHalf: Bool = false, isSecondHalf: Bool = false, isEven:Bool = false, isOdd: Bool = false, isFirstTwelve: Bool = false, isSecondTwelve: Bool = false, isThirdTwelve: Bool = false, isFirstRow: Bool = false, isSecondRow: Bool = false, isThirdRow: Bool = false) {
        // lossMath() is intended to subtract all irrelevant / losing bets from each number's final outcome amount
        summedArray = rouletteNumBetSize.reduce(0, {$0 + $1})
        print("lossMath: original summedArray[" + String(rouletteNumber) + "]:")
        print(String(summedArray))
        // take away the current number's bet from summedArray to exclude from loss side
        summedArray = summedArray - Int(rouletteNumBetSize[rouletteNumber])
        print("lossMath: adjusted summedArray[" + String(rouletteNumber) + "]:")
        print(String(summedArray))
        
        if isRed {
            print("lossMath: Number is red; subtracting red bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[155])
        }
        if isBlack {
            print("lossMath: Number is black; subtracting black bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[156])
        }
        if isFirstHalf {
            print("lossMath: Number is within 1-18; subtracting 1-18 bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[151])
        }
        if isSecondHalf {
            print("lossMath: Number is within 19-36; subtracting 19-36 bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[152])
        }
        if isEven {
            print("lossMath: Number is even; subtracting evens bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[153])
        }
        if isOdd {
            print("lossMath: Number is odd; subtracting odds bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[154])
        }
        if isFirstTwelve {
            print("lossMath: Number is within 1st 12; subtracting 1st 12 bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[145])
        }
        if isSecondTwelve {
            print("lossMath: Number is within 2nd 12; subtracting 2nd 12 bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[146])
        }
        if isThirdTwelve {
            print("lossMath: Number is within 3rd 12; subtracting 3rd 12 bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[147])
        }
        if isFirstRow {
            print("lossMath: Number is within 1st row; subtracting 1st row bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[148])
        }
        if isSecondRow {
            print("lossMath: Number is within 2nd row; subtracting 2nd row bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[149])
        }
        if isThirdRow {
            print("lossMath: Number is within 3rd row; subtracting 3rd row bet from summedArray")
            summedArray = summedArray - Int(rouletteNumBetSize[150])
        }
        
    }
        
    func coreMath(rouletteNumber: Int) {
            // put the math every number must perform here
            print("coreMath() running...")
           // lossMath(rouletteNumber: rouletteNumber)
            print("summedArray[" + String(rouletteNumber) + "]:")
            print(String(summedArray))
        // Show profit calculation
        print(String(Int(squareProfit[rouletteNumber])) + " = " + String(Int(rouletteNumBetSize[rouletteNumber])) + " - " + String(Int(summedArray)))
            squareProfit[rouletteNumber] = (CGFloat(rouletteNumBetSize[rouletteNumber]) * 35)  - CGFloat(summedArray)
            print("Number " + String(Int(rouletteNumber)) + " = " + String(Int(squareProfit[rouletteNumber])))
        }
    
    func boundaryMath(rouletteNumber: Int, boundary: Int, payout: Int) {
            // put the math every number must perform here
            print("boundaryMath() running...")
            // Show profit calculation
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[boundary]) * CGFloat(payout))
            // subtract boundary bet from Number sqaure profit
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + CGFloat(rouletteNumBetSize[boundary])
            print("Number " + String(Int(rouletteNumber)) + " = " + String(Int(squareProfit[rouletteNumber])))
        }
        
        func blackSquareMath(rouletteNumber: Int) {
            print("blackSquareMath() running...")

            print("summedArray[" + String(rouletteNumber) + "]:")
            print(String(summedArray))
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[156]) * 1) //Using manually entered payout multiplier 1
        }
        
        func redSquareMath(rouletteNumber: Int) {
            print("redSquareMath() running...")
            // rouletteNumBetSize[155]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[155]) * 1) //Using manually entered payout multiplier 1
        }
        func evenSquareMath(rouletteNumber: Int) {
            print("evenSquareMath() running...")
            // rouletteNumBetSize[153]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[153]) * 1) //Using manually entered payout multiplier 1
        }
        
        func oddSquareMath(rouletteNumber: Int) {
            print("oddSquareMath() running...")
            // rouletteNumBetSize[154]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[154]) * 1) //Using manually entered payout multiplier 1
        }
        
        func firstHalfSquareMath(rouletteNumber: Int) {
            print("firstHalfSquareMath() running...")
            // rouletteNumBetSize[151]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[151]) * 1) //Using manually entered payout multiplier 1
        }
        
        func secondHalfSquareMath(rouletteNumber: Int) {
            print("secondHalfSquareMath() running...")
            // rouletteNumBetSize[152]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[152]) * 1) //Using manually entered payout multiplier 1
        }
        
        func firstTwelveSquareMath(rouletteNumber: Int) {
            print("firstTwelveSquareMath() running...")
            // rouletteNumBetSize[145]
            print(String(Int(squareProfit[rouletteNumber])) + " = " + String(Int(rouletteNumBetSize[145])) + " * 2 ")
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[145]) * 2) //Using manually entered payout multiplier 2
            print("Profit for number " + String(rouletteNumber) + " is: " + String(Int(squareProfit[rouletteNumber])))
        }
        
        func secondTwelveSquareMath(rouletteNumber: Int) {
            print("secondTwelveSquareMath() running...")
            // rouletteNumBetSize[146]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[146]) * 2) //Using manually entered payout multiplier 2
        }
        
        func thirdTwelveSquareMath(rouletteNumber: Int) {
            print("thirdTwelveSquareMath() running...")
            // rouletteNumBetSize[147]
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[147]) * 2) //Using manually entered payout multiplier 2
        }
        
        func firstRowSquareMath(rouletteNumber: Int) {
            print("firstRowSquareMath() running...")
            // 148: first row (CORRECTED)
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[148]) * 2) //Using manually entered payout multiplier 2
        }
        
        func secondRowSquareMath(rouletteNumber: Int) {
            print("secondRowSquareMath() running...")
            // 149: second row (CORRECTED)
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[149]) * 2) //Using manually entered payout multiplier 2
        }
        
        func thirdRowSquareMath(rouletteNumber: Int) {
            print("thirdRowSquareMath() running...")
            // 150: third row (CORRECTED)
            squareProfit[rouletteNumber] = squareProfit[rouletteNumber] + (CGFloat(rouletteNumBetSize[150]) * 2) //Using manually entered payout multiplier 2
        }
        
        func calculateEverything2() {
            
            print("CalculateEverything2() has begun! ****************************************")
            rouletteNumBetSize[157] = 0
            totalBets = rouletteNumBetSize.reduce(0, {$0 + $1})
            summedArray = rouletteNumBetSize.reduce(0, {$0 + $1})
            blackBetIsRemoved = false
            redBetIsRemoved = false
            evenBetIsRemoved = false
            oddBetIsRemoved = false
            firstHalfBetIsRemoved = false
            secondHalfBetIsRemoved = false
            firstTwelveBetIsRemoved = false
            secondTwelveBetIsRemoved = false
            thirdTwelveBetIsRemoved = false
            firstRowBetIsRemoved = false
            secondRowBetIsRemoved = false
            thirdRowBetIsRemoved = false
            
            
            
            for rouletteNumber in rouletteNumbers {
                
            switch rouletteNumber {
            case 0:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: false, isFirstHalf: false, isSecondHalf: false, isEven: false, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 111, payout: 8) // 0-1-2-3 111 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 97, payout: 11) // 0-1-2 97 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 98, payout: 11) // 0-2-3 98 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 37, payout: 17) // 0-1 37 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 38, payout: 17) // 0-2 38 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 39, payout: 17) // 0-3 39 VERIFIED
               
            case 1:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 111, payout: 8) // 0-1-2-3 111 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 97, payout: 11) // 0-1-2 97 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 37, payout: 17) // 0-1 37 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 40, payout: 17) // 1-2 40 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 64, payout: 17) // 1-4 64 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 99, payout: 11) // streetOne 99 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 112, payout: 8) // 1-2-4-5 112 VERIFIED
                
            case 2:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 111, payout: 8) // 0-1-2-3 111 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 97, payout: 11) // 0-1-2 97 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 98, payout: 11) // 0-2-3 98 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 38, payout: 17) // 0-2 38 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 40, payout: 17) // 1-2 40 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 41, payout: 17) // 2-3 41 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 65, payout: 17) // 2-5 65 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 99, payout: 11) // streetOne 99 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 112, payout: 8) // 1-2-4-5 112 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 113, payout: 8) // 2-3-5-6 113 VERIFIED
                
            case 3:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 111, payout: 8) // 0-1-2-3 111 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 98, payout: 11) // 0-2-3 98 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 39, payout: 17) // 0-3 39 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 41, payout: 17) // 2-3 41 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 66, payout: 17) // 3-6 66 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 99, payout: 11) // streetOne 99 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 113, payout: 8) // 2-3-5-6 113 VERIFIED
            
            case 4:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 64, payout: 17) // 1-4 64 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 42, payout: 17) // 4-5 42 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 67, payout: 17) // 4-7 67 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 100, payout: 11) // streetFour 100 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 112, payout: 8) // 1-2-4-5 112 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 114, payout: 8) // 4-5-7-8 114 VERIFIED
            
            case 5:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 11 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 65, payout: 17) // 2-5 65 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 68, payout: 17) // 5-8 68 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 42, payout: 17) // 4-5 42 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 43, payout: 17) // 5-6 43 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 100, payout: 11) // streetFour 100 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 112, payout: 8) // 1-2-4-5 112 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 113, payout: 8) // 2-3-5-6 113 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 114, payout: 8) // 4-5-7-8 114 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 115, payout: 8) // 5-6-8-9 115 VERIFIED
            
            case 6:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 66, payout: 17) // 3-6 66 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 43, payout: 17) // 5-6 43 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 69, payout: 17) // 6-9 69 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 100, payout: 11) // streetFour 100 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 134, payout: 5) // streetOneFour 134 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 113, payout: 8) // 2-3-5-6 113 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 115, payout: 8) // 5-6-8-9 115 VERIFIED
            
            case 7:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 67, payout: 17) // 4-7 67 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 44, payout: 17) // 7-8 44 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 70, payout: 17) // 7-10 70 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 101, payout: 11) // streetSeven 101 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 114, payout: 8) // 4-5-7-8 114 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 116, payout: 8) // 7-8-10-11 116 VERIFIED
            
            case 8:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 11 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 68, payout: 17) // 5-8 68 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 71, payout: 17) // 8-11 71 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 44, payout: 17) // 7-8 44 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 45, payout: 17) // 8-9 45 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 101, payout: 11) // streetSeven 101 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 114, payout: 8) // 4-5-7-8 114 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 115, payout: 8) // 5-6-8-9 115 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 116, payout: 8) // 7-8-10-11 116 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 117, payout: 8) // 8-9-11-12 117 VERIFIED
            
            case 9:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 69, payout: 17) // 6-9 69 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 72, payout: 17) // 9-12 72 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 45, payout: 17) // 8-9 45 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 101, payout: 11) // streetSeven 101 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 135, payout: 5) // streetFourSeven 135 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 115, payout: 8) // 5-6-8-9 115 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 117, payout: 8) // 8-9-11-12 117 VERIFIED
            
            case 10:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 70, payout: 17) // 7-10 70 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 73, payout: 17) // 10-13 73 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 46, payout: 17) // 10-11 46 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 102, payout: 11) // streetTen 102 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 116, payout: 8) // 7-8-10-11 116 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 118, payout: 8) // 10-11-13-14 118 VERIFIED
            
            case 11:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 46, payout: 17) // 10-11 46 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 47, payout: 17) // 11-12 47 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 71, payout: 17) // 8-11 71 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 74, payout: 17) // 11-14 74 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 102, payout: 11) // streetTen 102 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 116, payout: 8) // 7-8-10-11 116 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 117, payout: 8) // 8-9-11-12 117 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 118, payout: 8) // 10-11-13-14 118 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 119, payout: 8) // 11-12-14-15 119 VERIFIED
            
            case 12:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: true, isSecondTwelve: false, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                firstTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 47, payout: 17) // 11-12 47 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 72, payout: 17) // 9-12 72 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 75, payout: 17) // 12-15 75 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 102, payout: 11) // streetTen 102 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 136, payout: 5) // streetSevenTen 136 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 117, payout: 8) // 8-9-11-12 117 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 119, payout: 8) // 11-12-14-15 119 VERIFIED
            
            case 13:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 48, payout: 17) // 13-14 48 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 73, payout: 17) // 10-13 73 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 76, payout: 17) // 13-16 76 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 103, payout: 11) // streetThirteen 103 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 118, payout: 8) // 10-11-13-14 118 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 120, payout: 8) // 13-14-16-17 120 VERIFIED
                
            case 14:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 48, payout: 17) // 13-14 48 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 49, payout: 17) // 14-15 49 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 74, payout: 17) // 11-14 74 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 77, payout: 17) // 14-17 77 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 103, payout: 11) // streetThirteen 103 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 118, payout: 8) // 10-11-13-14 118 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 119, payout: 8) // 11-12-14-15 119 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 120, payout: 8) // 13-14-16-17 120 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 121, payout: 8) // 14-15-16-17 121 VERIFIED
            
            case 15:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 75, payout: 17) // 12-15 75 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 49, payout: 17) // 14-15 49 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 78, payout: 17) // 15-18 78 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 103, payout: 11) // streetThirteen 103 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 137, payout: 5) // streetTenThirteen 137 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 119, payout: 8) // 11-12-14-15 119 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 121, payout: 8) // 14-15-16-17 121 VERIFIED
            
            case 16:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 76, payout: 17) // 13-16 76 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 79, payout: 17) // 16-19 79 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 50, payout: 17) // 16-17 50 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 104, payout: 11) // streetSixteen 104 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 120, payout: 8) // 13-14-16-17 120 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 121, payout: 8) // 14-15-17-18 121 VERIFIED
            
            case 17:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: true, isSecondHalf: false, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 50, payout: 17) // 16-17 50 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 51, payout: 17) // 17-18 51 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 77, payout: 17) // 14-17 77 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 80, payout: 17) // 17-20 80 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 104, payout: 11) // streetSixteen 104 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 120, payout: 8) // 13-14-16-17 120 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 121, payout: 8) // 14-15-17-18 121 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 122, payout: 8) // 16-17-19-20 122 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 123, payout: 8) // 17-18-20-21 123 VERIFIED
            
            case 18:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: true, isSecondHalf: false, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                firstHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 78, payout: 17) // 15-18 78 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 81, payout: 17) // 18-21 81 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 51, payout: 17) // 17-18 51 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 104, payout: 11) // streetSixteen 104 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 138, payout: 5) // streetThirteenSixteen 138 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 121, payout: 8) // 14-15-17-18 121 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 123, payout: 8) // 17-18-20-21 123 VERIFIED
            
            case 19:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 79, payout: 17) // 16-19 79 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 82, payout: 17) // 19-22 82 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 52, payout: 17) // 19-20 52 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 105, payout: 11) // streetNineteen 105 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 122, payout: 8) // 16-17-19-20 122 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 124, payout: 8) // 19-20-22-23 124 VERIFIED
            
            case 20:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 80, payout: 17) // 17-20 80 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 52, payout: 17) // 19-20 52 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 53, payout: 17) // 20-21 53 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 83, payout: 17) // 20-23 83 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 105, payout: 11) // streetNineteen 105 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 122, payout: 8) // 16-17-19-20 122 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 123, payout: 8) // 17-18-20-21 123 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 124, payout: 8) // 19-20-22-23 124 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 125, payout: 8) // 20-21-23-24 125 VERIFIED
            
            case 21:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 81, payout: 17) // 18-21 81 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 53, payout: 17) // 20-21 53 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 84, payout: 17) // 21-24 84 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 105, payout: 11) // streetNineteen 105 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 139, payout: 5) // streetSixteenNineteen 139 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 123, payout: 8) // 17-18-20-21 123 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 125, payout: 8) // 20-21-23-24 125 VERIFIED
            
            case 22:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 82, payout: 17) // 19-22 82 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 85, payout: 17) // 22-25 85 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 54, payout: 17) // 22-23 54 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 106, payout: 11) // streetTwentyTwo 106 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 124, payout: 8) // 19-20-22-23 124 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 126, payout: 8) // 22-23-25-26 126 VERIFIED
            
            case 23:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 83, payout: 17) // 20-23 83 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 86, payout: 17) // 23-26 86 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 54, payout: 17) // 22-23 54 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 55, payout: 17) // 23-24 55 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 106, payout: 11) // streetTwentyTwo 106 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 124, payout: 8) // 19-20-22-23 124 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 125, payout: 8) // 20-21-23-24 125 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 126, payout: 8) // 22-23-25-26 126 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 127, payout: 8) // 23-24-25-26 127 VERIFIED
            
            case 24:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: true, isThirdTwelve: false, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                secondTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 55, payout: 17) // 23-24 55 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 84, payout: 17) // 21-24 84 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 87, payout: 17) // 24-27 87 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 106, payout: 11) // streetTwentyTwo 106 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 140, payout: 5) // streetNineteenTwentyTwo 140 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 125, payout: 8) // 20-21-23-24 125 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 127, payout: 8) // 23-24-26-27 127 VERIFIED
            
            case 25:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 85, payout: 17) // 22-25 85 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 88, payout: 17) // 25-28 88 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 56, payout: 17) // 25-26 56 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 107, payout: 11) // streetTwentyFive 107 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 126, payout: 8) // 22-23-25-26 126 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 127, payout: 8) // 23-24-26-27 127 VERIFIED
            
            case 26:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 86, payout: 17) // 23-26 86 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 56, payout: 17) // 25-26 56 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 57, payout: 17) // 26-27 57 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 89, payout: 17) // 26-29 89 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 107, payout: 11) // streetTwentyFive 107 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 126, payout: 8) // 22-23-25-26 126 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 127, payout: 8) // 23-24-26-27 127 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 128, payout: 8) // 25-26-28-29 128 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 129, payout: 8) // 26-27-29-30 129 VERIFIED
            
            case 27:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 87, payout: 17) // 24-27 87 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 57, payout: 17) // 26-27 57 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 90, payout: 17) // 27-30 90 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 107, payout: 11) // streetTwentyFive 107 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 141, payout: 5) // streetTwentyTwoTwentyFive 141 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 127, payout: 8) // 23-24-26-27 127 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 129, payout: 8) // 26-27-29-30 129 VERIFIED
            
            case 28:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 88, payout: 17) // 25-28 88 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 91, payout: 17) // 28-31 91 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 58, payout: 17) // 28-29 58 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 108, payout: 11) // streetTwentyEight 108 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 128, payout: 8) // 25-26-28-29 128 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 130, payout: 8) // 28-29-31-32 130 VERIFIED
            
            case 29:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 89, payout: 17) // 26-29 89 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 58, payout: 17) // 28-29 58 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 59, payout: 17) // 29-30 59 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 92, payout: 17) // 29-32 92 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 108, payout: 11) // streetTwentyEight 108 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 128, payout: 8) // 25-26-28-29 128 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 129, payout: 8) // 26-27-29-30 129 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 130, payout: 8) // 28-29-31-32 130 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 131, payout: 8) // 29-30-32-33 131 VERIFIED
            
            case 30:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 90, payout: 17) // 27-30 90 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 59, payout: 17) // 29-30 59 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 93, payout: 17) // 30-33 93 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 108, payout: 11) // streetTwentyEight 108 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 142, payout: 5) // streetTwentyFiveTwentyEight 142 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 129, payout: 8) // 26-27-29-30 129 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 131, payout: 8) // 29-30-32-33 131 VERIFIED
            
            case 31:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 91, payout: 17) // 28-31 91 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 94, payout: 17) // 31-34 94 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 60, payout: 17) // 31-32 60 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 109, payout: 11) // streetThirtyOne 109 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 130, payout: 8) // 28-29-31-32 130 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 132, payout: 8) // 31-32-34-35 132 VERIFIED
            
            case 32:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // 11
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 92, payout: 17) // 29-32 92 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 60, payout: 17) // 31-32 60 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 61, payout: 17) // 32-33 61 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 95, payout: 17) // 32-35 95 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 109, payout: 11) // streetThirtyOne 109 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 130, payout: 8) // 28-29-31-32 130 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 131, payout: 8) // 29-30-32-33 131 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 132, payout: 8) // 31-32-34-35 132 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 133, payout: 8) // 32-33-35-36 133 VERIFIED
            
            case 33:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // 8
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 93, payout: 17) // 30-33 93 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 61, payout: 17) // 32-33 61 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 96, payout: 17) // 33-36 96 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 109, payout: 11) // streetThirtyOne 109 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 143, payout: 5) // streetTwentyEightThirtyOne 143 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 131, payout: 8) // 29-30-32-33 131 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 133, payout: 8) // 32-33-35-36 133 VERIFIED
            
            case 34:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: true, isSecondRow: false, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                firstRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 5 boundaryMaths
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 94, payout: 17) // 31-34 94 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 62, payout: 17) // 34-35 62 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 110, payout: 11) // streetThirtyFour 110 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 132, payout: 8) // 31-32-34-35 132 VERIFIED
            
            case 35:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: false, isBlack: true, isFirstHalf: false, isSecondHalf: true, isEven: false, isOdd: true, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: true, isThirdRow: false)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                secondRowSquareMath(rouletteNumber: rouletteNumber)
                blackSquareMath(rouletteNumber: rouletteNumber)
                oddSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 7
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 95, payout: 17) // 32-35 95
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 62, payout: 17) // 34-35 62 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 63, payout: 17) // 35-36 63 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 110, payout: 11) // streetThirtyFour 110 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 132, payout: 8) // 31-32-34-35 132 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 133, payout: 8) // 32-33-35-36 133 VERIFIED
            
            case 36:
                print("case " + String(rouletteNumber))
                lossMath(rouletteNumber: rouletteNumber, isRed: true, isBlack: false, isFirstHalf: false, isSecondHalf: true, isEven: true, isOdd: false, isFirstTwelve: false, isSecondTwelve: false, isThirdTwelve: true, isFirstRow: false, isSecondRow: false, isThirdRow: true)
                coreMath(rouletteNumber: rouletteNumber)
                secondHalfSquareMath(rouletteNumber: rouletteNumber)
                thirdTwelveSquareMath(rouletteNumber: rouletteNumber)

                thirdRowSquareMath(rouletteNumber: rouletteNumber)
                redSquareMath(rouletteNumber: rouletteNumber)
                evenSquareMath(rouletteNumber: rouletteNumber)
                
                // there should be 5
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 96, payout: 17) // 33-36 96 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 63, payout: 17) // 35-36 63 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 110, payout: 11) // streetThirtyFour 110 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 144, payout: 5) // streetThirtyOneThirtyFour 144 VERIFIED
                boundaryMath(rouletteNumber: rouletteNumber, boundary: 133, payout: 8) // 32-33-35-36 133 VERIFIED
            
            default:
                print("default case??? How?")
            }
        }
            profitableSquares = 0.00
            for rouletteNumber in rouletteNumbers {
                if (squareProfit[rouletteNumber] > 0) {
                    profitableSquares += 1.00
                }
            }
            profitableSquares = (profitableSquares / 37) * 100
            profitableSquares = round(profitableSquares * 100) / 100.0
            
            updateStats()
            heatMap()
        }
    
    func clearBoard() {
        rouletteNumBetSize = rouletteNumBetSize.map { _ in
            0
        }
        profitableSquares = 0
        totalBets = 0
        doubleUpOrMore = 0
        biggestHit = 0
        ev = 0
        squareProfit = squareProfit.map { _ in
            0
        }
        redValue = redValue.map { _ in
                0
        }
        greenValue = greenValue.map { _ in
                0
        }
        percentReturn = percentReturn.map { _ in
                0
        }
        biggestWinners.removeAll()
        joinedWinners = ""
    }
    
    
    // Randomizer Options Settings vars
    @State var indexX: Int = 0 // for some reason the RandomBet() for loop won't increment so I had to add this indexX var
    @State var randomize: Int = 0
    @State var maxBetReached = 2
    @State var favorAdjacent = true
    @State var maxRandomBet: Double = 30
    @State var maxSingleBet: Double = 2
    @State var nextBet:Int = 0
    @State var requireMinCoverage:Bool = false
    @State var minCoverage:Double = 0
    @State var randomTimeout:Int = 0
    @State var totalMinReturnSquares:Int = 0
    @State var requireMinReturn = false
    @State var minReturn:Double = 1
    
    // RANDOM BET GENERATOR
    func RandomBet() {
        totalMinReturnSquares = 0
        clearBoard()
        rouletteNumBetSize.forEach { index in
            indexX = Int.random(in: 0..<157)
            
            print("RandomBet():")
            print("Adding bet to rouletteNumBetSize[\(indexX)]")
            randomize = Int.random(in: 0..<10)
            if randomize >= 7 {
                if totalBets >= Int(maxRandomBet) { // if maxRandomBet threshold is crossed, then make every remaining bet = 0
                    rouletteNumBetSize[indexX] = 0
                } else {
                    nextBet = Int.random(in: 0..<Int(maxSingleBet))
                    if (totalBets + nextBet) >= Int(maxRandomBet) { // if the next bet would cross the maxRandombet threshold, change it to zero
                        rouletteNumBetSize[indexX] = 0
                    } else {
                    rouletteNumBetSize[indexX] = nextBet
                    }
                }
            }
            print(String(rouletteNumBetSize[indexX]))
//            indexX += 1
            totalBets = rouletteNumBetSize.reduce(0, {$0 + $1})
            
            
        }
        calculateEverything2()
        indexX = 0
        if requireMinCoverage && randomTimeout <= 2000 { // if we are looping until a wheel coverage is reacher AND we haven't reached 50 tries, re-run
            
            if profitableSquares <= minCoverage {
                print("randomBet() iteration count: \(randomTimeout)")
                randomTimeout += 1
                RandomBet()
            } else {
                if requireMinReturn {
//                squareProfit.forEach() { num in
                    for num in 0..<37 {
                    if (Int(squareProfit[Int(num)]) / totalBets) >= Int(minReturn) {
                        totalMinReturnSquares += 1
                    }
                    if ((totalMinReturnSquares / 37) * 100) >= Int(minCoverage) {
                        randomTimeout = 0
                    } else {
                        print("randomBet() iteration count: \(randomTimeout)")
                        randomTimeout += 1
                        RandomBet()
                    }
                }
                }
                randomTimeout = 0
            }
            
        } else {
            randomTimeout = 0
        }
    }
    
    
   // }
   
    struct RouletteWheel: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
//            let center = CGPoint(x: rect.midX, y: rect.midY)
            
            let radius: Double = Double(rect.width) / 2 - 20
    
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX + 100, y: rect.midY))
//            path.addArc(center: center, radius: CGFloat(Double(100)), startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360/37), clockwise: false)
//            path.closeSubpath()
            for i in stride(from: 0, to: 361.0 / 37, by: 1) {
                        // radians = degrees * PI / 180
                        let radians = i * Double.pi / 180
            
                        let x = Double(center.x) + radius * cos(radians)
                        let y = Double(center.y) + radius * sin(radians)
            
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
            
            return path
        }
    }
 
    var screenWidth:CGFloat = UIScreen.main.bounds.width
    @State var isLongPressed = false
    
    func subtractChip(storedValue: Int) {
        if storedValue > 0 {
            rouletteNumBetSize[storedValue] -= 1
            totalBets -= 1
        }
        
    }
    
    
    struct rouletteWheelCell: Identifiable {
        let name: String
        let index: Int
        let color: Color
        let size: CGFloat
        let degrees: Double
        
        var id: String { name }
    }
    
    let rouletteWheelCells: [rouletteWheelCell] = [
        
        rouletteWheelCell(name: "6", index: 6, color: .black, size: 350, degrees: 0), // Original value, faces straight to the right?
        rouletteWheelCell(name: "27", index: 27, color: .red, size: 350, degrees: 9.756756756756757),
        rouletteWheelCell(name: "13", index: 13, color: .black, size: 350, degrees: 19.513513513513514),
        rouletteWheelCell(name: "36", index: 36, color: .red, size: 350, degrees: 29.270270270270271),
        rouletteWheelCell(name: "11", index: 11, color: .black, size: 350, degrees: 39.027027027027028),
        rouletteWheelCell(name: "30", index: 30, color: .red, size: 350, degrees: 48.783783783783785),
        rouletteWheelCell(name: "8", index: 8, color: .black, size: 350, degrees: 58.540540540540542),
        rouletteWheelCell(name: "23", index: 23, color: .red, size: 350, degrees: 68.297297297297299),
        rouletteWheelCell(name: "10", index: 10, color: .black, size: 350, degrees: 78.054054054054056),
        rouletteWheelCell(name: "5", index: 5, color: .red, size: 350, degrees: 87.810810810810813),
        rouletteWheelCell(name: "24", index: 24, color: .black, size: 350, degrees: 97.56756756756757),
        rouletteWheelCell(name: "16", index: 16, color: .red, size: 350, degrees: 107.324324324324327),
        rouletteWheelCell(name: "33", index: 33, color: .black, size: 350, degrees: 117.081081081081084),
        rouletteWheelCell(name: "1", index: 1, color: .red, size: 350, degrees: 126.837837837837841),
        rouletteWheelCell(name: "20", index: 20, color: .black, size: 350, degrees: 136.594594594594598),
        rouletteWheelCell(name: "14", index: 14, color: .red, size: 350, degrees: 146.351351351351355),
        rouletteWheelCell(name: "31", index: 31, color: .black, size: 350, degrees: 156.108108108108112),
        rouletteWheelCell(name: "9", index: 9, color: .red, size: 350, degrees: 165.864864864864869),
        rouletteWheelCell(name: "22", index: 22, color: .black, size: 350, degrees: 175.621621621621626),
        rouletteWheelCell(name: "18", index: 18, color: .red, size: 350, degrees: 185.378378378378383),
        rouletteWheelCell(name: "29", index: 29, color: .black, size: 350, degrees: 195.13513513513514),
        rouletteWheelCell(name: "7", index: 7, color: .red, size: 350, degrees: 204.891891891891897),
        rouletteWheelCell(name: "28", index: 28, color: .black, size: 350, degrees: 214.648648648648654),
        rouletteWheelCell(name: "12", index: 12, color: .red, size: 350, degrees: 224.405405405405411),
        rouletteWheelCell(name: "35", index: 35, color: .black, size: 350, degrees: 234.162162162162168),
        rouletteWheelCell(name: "3", index: 3, color: .red, size: 350, degrees: 243.918918918918925),
        rouletteWheelCell(name: "26", index: 26, color: .black, size: 350, degrees: 253.675675675675682),
        rouletteWheelCell(name: "0", index: 0, color: .green, size: 350, degrees: 263.432432432432439),
        rouletteWheelCell(name: "32", index: 32, color: .red, size: 350, degrees: 273.189189189189189), // 9.756756756756757 * 28
        rouletteWheelCell(name: "15", index: 15, color: .black, size: 350, degrees: 282.945945945945953), // 9.756756756756757 * 29
        rouletteWheelCell(name: "19", index: 19, color: .red, size: 350, degrees: 292.70270270270271),
        rouletteWheelCell(name: "4", index: 4, color: .black, size: 350, degrees: 302.459459459459467), // 9.756756756756757 * 30
        rouletteWheelCell(name: "21", index: 21, color: .red, size: 350, degrees: 312.216216216216224), // 9.756756756756757 * 31
        rouletteWheelCell(name: "2", index: 2, color: .black, size: 350, degrees: 321.972972972972981),
        rouletteWheelCell(name: "25", index: 25, color: .red, size: 350, degrees: 331.729729729729738),
        rouletteWheelCell(name: "17", index: 17, color: .black, size: 350, degrees: 341.486486486486495),
        rouletteWheelCell(name: "34", index: 34, color: .red, size: 350, degrees: 351.243243243243252),
        
        
    ]
    
    let rouletteWheelInnerCells: [rouletteWheelCell] = [
        rouletteWheelCell(name: "6", index: 6, color: .white, size: 175, degrees: 0), // Original value, faces straight to the right?
        rouletteWheelCell(name: "27", index: 27, color: .white, size: 175, degrees: 9.756756756756757),
        rouletteWheelCell(name: "13", index: 13, color: .white, size: 175, degrees: 19.513513513513514),
        rouletteWheelCell(name: "36", index: 36, color: .white, size: 175, degrees: 29.270270270270271),
        rouletteWheelCell(name: "11", index: 11, color: .white, size: 175, degrees: 39.027027027027028),
        rouletteWheelCell(name: "30", index: 30, color: .white, size: 175, degrees: 48.783783783783785),
        rouletteWheelCell(name: "8", index: 8, color: .white, size: 175, degrees: 58.540540540540542),
        rouletteWheelCell(name: "23", index: 23, color: .white, size: 175, degrees: 68.297297297297299),
        rouletteWheelCell(name: "10", index: 10, color: .white, size: 175, degrees: 78.054054054054056),
        rouletteWheelCell(name: "5", index: 5, color: .white, size: 175, degrees: 87.810810810810813),
        rouletteWheelCell(name: "24", index: 24, color: .white, size: 175, degrees: 97.56756756756757),
        rouletteWheelCell(name: "16", index: 16, color: .white, size: 175, degrees: 107.324324324324327),
        rouletteWheelCell(name: "33", index: 33, color: .white, size: 175, degrees: 117.081081081081084),
        rouletteWheelCell(name: "1", index: 1, color: .white, size: 175, degrees: 126.837837837837841),
        rouletteWheelCell(name: "20", index: 20, color: .white, size: 175, degrees: 136.594594594594598),
        rouletteWheelCell(name: "14", index: 14, color: .white, size: 175, degrees: 146.351351351351355),
        rouletteWheelCell(name: "31", index: 31, color: .white, size: 175, degrees: 156.108108108108112),
        rouletteWheelCell(name: "9", index: 9, color: .white, size: 175, degrees: 165.864864864864869),
        rouletteWheelCell(name: "22", index: 22, color: .white, size: 175, degrees: 175.621621621621626),
        rouletteWheelCell(name: "18", index: 18, color: .white, size: 175, degrees: 185.378378378378383),
        rouletteWheelCell(name: "29", index: 29, color: .white, size: 175, degrees: 195.13513513513514),
        rouletteWheelCell(name: "7", index: 7, color: .white, size: 175, degrees: 204.891891891891897),
        rouletteWheelCell(name: "28", index: 28, color: .white, size: 175, degrees: 214.648648648648654),
        rouletteWheelCell(name: "12", index: 12, color: .white, size: 175, degrees: 224.405405405405411),
        rouletteWheelCell(name: "35", index: 35, color: .white, size: 175, degrees: 234.162162162162168),
        rouletteWheelCell(name: "3", index: 3, color: .white, size: 175, degrees: 243.918918918918925),
        rouletteWheelCell(name: "26", index: 26, color: .white, size: 175, degrees: 253.675675675675682),
        rouletteWheelCell(name: "0", index: 0, color: .white, size: 175, degrees: 263.432432432432439),
        rouletteWheelCell(name: "32", index: 32, color: .white, size: 175, degrees: 273.189189189189189), // 9.756756756756757 * 28
        rouletteWheelCell(name: "15", index: 15, color: .white, size: 175, degrees: 282.945945945945953), // 9.756756756756757 * 29
        rouletteWheelCell(name: "19", index: 19, color: .white, size: 175, degrees: 292.70270270270271),
        rouletteWheelCell(name: "4", index: 4, color: .white, size: 175, degrees: 302.459459459459467), // 9.756756756756757 * 30
        rouletteWheelCell(name: "21", index: 21, color: .white, size: 175, degrees: 312.216216216216224), // 9.756756756756757 * 31
        rouletteWheelCell(name: "2", index: 2, color: .white, size: 175, degrees: 321.972972972972981),
        rouletteWheelCell(name: "25", index: 25, color: .white, size: 175, degrees: 331.729729729729738),
        rouletteWheelCell(name: "17", index: 17, color: .white, size: 175, degrees: 341.486486486486495),
        rouletteWheelCell(name: "34", index: 34, color: .white, size: 175, degrees: 351.243243243243252),
        
    ]
    
    var isIpad:Bool {
        if screenSize > 900 {
            return true
        } else {
            return false
        }
    }
    
    var screenFactor: CGFloat {
        if screenSize > 1000 {
            return 1.2
        } else {
            return 0.5
        }
    }
    
    var theScreenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        
        VStack(spacing:0) {

            switch selectedIndex {
            case 0:
                switch isIpad {
                case true:
                
                    Spacer()
                    
                    HStack {
                    ZStack {
                        
                        
                        // START OF ROULETTE WHEEL CODE
                        
                        ForEach(rouletteWheelCells) { rouletteWheelCell in

                                RouletteWheel()
                                    .frame(width: rouletteWheelCell.size * screenFactor, height: rouletteWheelCell.size * screenFactor)
                                    .foregroundColor(rouletteWheelCell.color)
                                    .background(Color.clear)
                                    .overlay(Text(rouletteWheelCell.name).font(.system(size: 19)).bold().rotationEffect(.degrees(93)).offset(x: 180, y: 13.5).foregroundColor(.white))
                                    .rotationEffect(
                                        
                                        .degrees(rouletteWheelCell.degrees)
                                    )
                        }
                        
                        ForEach(rouletteWheelInnerCells) { rouletteWheelCell in

                                RouletteWheel()
                                    .frame(width: 280 * screenFactor, height: 280 * screenFactor)
                                    .foregroundColor(Color(red: redValue[rouletteWheelCell.index], green: greenValue[rouletteWheelCell.index], blue: blueValue[rouletteWheelCell.index]).opacity(0.5)) // set to default roulette colors unless heatmap values active)
                                    
                                    .background(Color.clear)
                                    
                                    .rotationEffect(
                                        .degrees(rouletteWheelCell.degrees)
                                    )
                        }
                        ForEach(rouletteWheelInnerCells) { rouletteWheelCell in

                                RouletteWheel()
                                    .frame(width: 250 * screenFactor, height: 250 * screenFactor)
            
                                    .foregroundColor(Color.black)
                                    .background(Color.clear)
                                    
                                    .rotationEffect(
                                        .degrees(rouletteWheelCell.degrees)
                                    )
                        }
                        
                    }
                    
                        // END OF ROULETTE WHEEL CODE
            
                        Spacer()
                    }
                    
                    
    //                Spacer()
                    VStack(spacing: 0) {
//                        Text(String(Int(theScreenWidth)))
    //                    Spacer() // Important Spacer to keep board away from top
                        HStack(spacing:1) {
                      
                        // Inner squares
                            ForEach(buttons, id: \.self) { row in
                                
                                VStack {
                                    ForEach(row, id: \.self) { button in
                                        
                                        Button(action: {
                                            // Increment bet size, stored in array roulettenumBetSize &
                                            // indexed via var storedValue in enum Roulettesquare
                                            
                                            rouletteNumBetSize[button.storedValue] += 1
                                            print("rouletteNumBetSize[\(button.storedValue)] = \(rouletteNumBetSize[button.storedValue])")
                                            
                                          //  calculateEverything(a: button.storedValue)
                                            calculateEverything2()
    //                                        if isHidden[button.storedValue] == false {
    //                                        isHidden[button.storedValue] = true
    //                                        }
    //                                        else {
    //                                            isHidden[button.storedValue] = false
    //                                        }
                                            
                                        }, label: {
                                            if rouletteNumBetSize[button.storedValue] == 0 { // display squares without chip overlay
                                            ZStack() {
                                                
                                            Text(button.squareLabel)
                                            .font(.system(size: button.textSize))
                                                .bold()
    //                                            .overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).offset(x:-18, y: 19))
                                            .frame(width: button.squareWidth, height: button.squareHeight, alignment: .center)
                                            .foregroundColor(button.textColor)
                                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                            .background(button.squareColor.opacity(0.9))
    //                                        .background(Color.clear)
                                                .border(button.squareColor, width: 1)
                                            }
                                            
                                            
                                            } else { // display chip overlay when bets are added
                                                ZStack() {
                                                    
                                                Text(button.squareLabel)
                                                .font(.system(size: button.textSize))
                                                    .bold()
                                                    .frame(width: button.squareWidth, height: button.squareHeight, alignment: .center)
                                                .foregroundColor(button.textColor)
                                                    .background(button.squareColor.opacity(0.9))
                                                .border(button.squareColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                                    
                                                    .overlay(Image("redchip").resizable().aspectRatio(contentMode: .fit).frame(width: 32, height: 32, alignment: .center).overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).foregroundColor(.white).bold().offset(x:0, y: 0)))
                                                }
                                                
                                                .onTapGesture { // seems redundant but due to the LongPress its needed
                                                    rouletteNumBetSize[button.storedValue] += 1
                                                    calculateEverything2()
                                                }
                                                .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) { // subtracts one unit from square
                                                    subtractChip(storedValue: button.storedValue)
                                                    calculateEverything2()
                                                    heatMap()
                                                }
                                                
                                                
                                            }
            
                                        })
                                    }
                                }
                            }
                    }
                        .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
                        
                        
                    HStack {
                        Spacer()
                        VStack {
                            
                            // Outer Squares
                        ForEach(outerButtons, id: \.self) { row in
                        //   VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                ForEach(row, id: \.self) { button in
                                    Button(action: {
                                        // Increment bet size, stored in array roulettenumBetSize &
                                        // indexed via var storedValue in enum Roulettesquare
                                        rouletteNumBetSize[button.storedValue] += 1
                                     //   calculateEverything(a: button.storedValue)
                                        calculateEverything2()
                                    }, label: {

                                        VStack(spacing: 0) {
                                            ZStack { // Adding this corrects spacing of outer squares with chips
                                        Text(button.squareLabel)

                                        .font(.system(size: 16))
                                        .frame(width: button.squareWidth, height: (button.squareHeight * 0.8), alignment: .center)
                                        .foregroundColor(button.textColor)
                                        .background(Color.white.opacity(0.1))
                                        .border(Color.white, width: 1)
                                                
                                            
                                            if rouletteNumBetSize[button.storedValue] > 0 {
                                                Image("redchip")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 32, height: 32, alignment: .center)
    //                                                .padding(.all, -10) // negative number is an attempt to compensate for bulge due to chip
    //                                                .offset(x: 0, y: -25)
    //                                                .zIndex(50)
                                                    .onTapGesture { // seems redundant but due to the LongPress its needed
                                                        rouletteNumBetSize[button.storedValue] += 1
                                                        calculateEverything2()
                                                    }
                                                    .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) { // subtracts one unit from square
                                                        subtractChip(storedValue: button.storedValue)
                                                        calculateEverything2()
                                                        heatMap()
                                                    }
                                                    .overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).foregroundColor(.white).bold().offset(x:0, y: 0))

                                            }
                                        }
                                        }
                                    })
                                    .frame(width: button.squareWidth, height: (button.squareHeight * 0.8), alignment: .center)
                                    .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                    
                                }
                                }
                                .padding(.top, 5)
                            }
                        }
                        
                        Spacer()
                                }
                    .padding(.top, 2) // small gap between board and outer squares to make street squares touchable
                    .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
                        
                        
                        HStack(spacing:0) {
                            Spacer()
                            Button(action: {
                                RandomBet() // doesn't work yet
                            }, label: {
                            Text("Random")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50, alignment: .center)
                                .border(Color.white, width: 2)
                               
                            })
                            .background(Color.yellow.opacity(0.3))
                            
                            Text("Total Bet: \n$" + String(totalBets))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 125, height: 50, alignment: .center)
                                .background(Color.blue.opacity(0.5))
                                .border(Color.white, width: 1)
                                .padding(1)
                            // Text box to show board coverage
                            Text("Coverage: \n" + String(profitableSquares) + "%")
                                .bold()
                                .frame(width: 145, height: 50, alignment: .center)
                                .background(Color.blue.opacity(0.5))
                                .border(Color.white, width: 1)
                                .padding(1)
                                .foregroundColor(.white)
                                
    //                            .padding(.leading, 40)
                            Text("Biggest wins: \n" + joinedWinners + String(biggestHit))
                                    .bold()
                                    .frame(width: 192, height: 50, alignment: .center)
                                    .background(Color.blue.opacity(0.5))
                                    .border(Color.white, width: 1)
                                    .padding(1)
                                    .foregroundColor(.white)
                            
       
                            Button(action: {
                                clearBoard() // doesn't work yet
                            }, label: {
                            Text("Clear Board")
                                .bold()
    //                            .frame(width: 100, height: 60, alignment: .center)
    //                            .background(Color.yellow.opacity(0.3))
                                .foregroundColor(.white)
                                .frame(width: 115, height: 50, alignment: .center)
                                .border(Color.white, width: 2)
    //                            .padding(.leading, 0)
                            })
                            .background(Color.yellow.opacity(0.3))
                        Spacer()
                            
                        }
                        .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
    //                    Spacer()
                    }
                    
                
            
                    // END OF FIRST CASE
            
            .background(Color(red:63/255, green:64/255, blue:69/255))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    

                case false:
                SwiftUI.ScrollView(.horizontal) {
                
                Spacer()
                HStack {
                
                ZStack {
                    
                    
                    // START OF ROULETTE WHEEL CODE
                    
                    ForEach(rouletteWheelCells) { rouletteWheelCell in

                            RouletteWheel()
                                .frame(width: rouletteWheelCell.size, height: rouletteWheelCell.size)
                                .foregroundColor(rouletteWheelCell.color)
                                .background(Color.clear)
                                .overlay(Text(rouletteWheelCell.name).bold().rotationEffect(.degrees(92)).offset(x: 140, y: 10).foregroundColor(.white))
                                .rotationEffect(
                                    
                                    .degrees(rouletteWheelCell.degrees)
                                )
                    }
                    
                    ForEach(rouletteWheelInnerCells) { rouletteWheelCell in

                            RouletteWheel()
                                .frame(width: 280, height: 280)
                                .foregroundColor(Color(red: redValue[rouletteWheelCell.index], green: greenValue[rouletteWheelCell.index], blue: blueValue[rouletteWheelCell.index]).opacity(0.5)) // set to default roulette colors unless heatmap values active)
                                
                                .background(Color.clear)
                                
                                .rotationEffect(
                                    .degrees(rouletteWheelCell.degrees)
                                )
                    }
                    ForEach(rouletteWheelInnerCells) { rouletteWheelCell in

                            RouletteWheel()
                                .frame(width: 250, height: 250)
        
                                .foregroundColor(Color.black)
                                .background(Color.clear)
                                
                                .rotationEffect(
                                    .degrees(rouletteWheelCell.degrees)
                                )
                    }
                    
                }
                
                    // END OF ROULETTE WHEEL CODE
        
                
//                Spacer()
                VStack(spacing: 0) {
//                    Spacer() // Important Spacer to keep board away from top
                    HStack(spacing:1) {
                  
                    // Inner squares
                        ForEach(buttons, id: \.self) { row in
                            
                            VStack {
                                ForEach(row, id: \.self) { button in
                                    
                                    Button(action: {
                                        // Increment bet size, stored in array roulettenumBetSize &
                                        // indexed via var storedValue in enum Roulettesquare
                                        
                                        rouletteNumBetSize[button.storedValue] += 1
                                        print("rouletteNumBetSize[\(button.storedValue)] = \(rouletteNumBetSize[button.storedValue])")
                                        
                                      //  calculateEverything(a: button.storedValue)
                                        calculateEverything2()
//                                        if isHidden[button.storedValue] == false {
//                                        isHidden[button.storedValue] = true
//                                        }
//                                        else {
//                                            isHidden[button.storedValue] = false
//                                        }
                                        
                                    }, label: {
                                        if rouletteNumBetSize[button.storedValue] == 0 { // display squares without chip overlay
                                        ZStack() {
                                            
                                        Text(button.squareLabel)
                                        .font(.system(size: button.textSize))
                                            .bold()
//                                            .overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).offset(x:-18, y: 19))
                                        .frame(width: button.squareWidth, height: button.squareHeight, alignment: .center)
                                        .foregroundColor(button.textColor)
                                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                        .background(button.squareColor.opacity(0.9))
//                                        .background(Color.clear)
                                            .border(button.squareColor, width: 1)
                                        }
                                        
                                        
                                        } else { // display chip overlay when bets are added
                                            ZStack() {
                                                
                                            Text(button.squareLabel)
                                            .font(.system(size: button.textSize))
                                                .bold()
                                                .frame(width: button.squareWidth, height: button.squareHeight, alignment: .center)
                                            .foregroundColor(button.textColor)
                                                .background(button.squareColor.opacity(0.9))
                                            .border(button.squareColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                                
                                                .overlay(Image("redchip").resizable().aspectRatio(contentMode: .fit).frame(width: 32, height: 32, alignment: .center).overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).foregroundColor(.white).bold().offset(x:0, y: 0)))
                                            }
                                            
                                            .onTapGesture { // seems redundant but due to the LongPress its needed
                                                rouletteNumBetSize[button.storedValue] += 1
                                                calculateEverything2()
                                            }
                                            .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) { // subtracts one unit from square
                                                subtractChip(storedValue: button.storedValue)
                                                calculateEverything2()
                                                heatMap()
                                            }
                                            
                                            
                                        }
        
                                    })
                                }
                            }
                        }
                }
                    .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
                    
                    
                HStack {
                    Spacer()
                    VStack {
                        
                        // Outer Squares
                    ForEach(outerButtons, id: \.self) { row in
                    //   VStack(spacing: 0) {
                            HStack(spacing: 0) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    // Increment bet size, stored in array roulettenumBetSize &
                                    // indexed via var storedValue in enum Roulettesquare
                                    rouletteNumBetSize[button.storedValue] += 1
                                 //   calculateEverything(a: button.storedValue)
                                    calculateEverything2()
                                }, label: {

                                    VStack(spacing: 0) {
                                        ZStack { // Adding this corrects spacing of outer squares with chips
                                    Text(button.squareLabel)

                                    .font(.system(size: 16))
                                    .frame(width: button.squareWidth, height: (button.squareHeight * 0.8), alignment: .center)
                                    .foregroundColor(button.textColor)
                                    .background(Color.white.opacity(0.1))
                                    .border(Color.white, width: 1)
                                            
                                        
                                        if rouletteNumBetSize[button.storedValue] > 0 {
                                            Image("redchip")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32, alignment: .center)
//                                                .padding(.all, -10) // negative number is an attempt to compensate for bulge due to chip
//                                                .offset(x: 0, y: -25)
//                                                .zIndex(50)
                                                .onTapGesture { // seems redundant but due to the LongPress its needed
                                                    rouletteNumBetSize[button.storedValue] += 1
                                                    calculateEverything2()
                                                }
                                                .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) { // subtracts one unit from square
                                                    subtractChip(storedValue: button.storedValue)
                                                    calculateEverything2()
                                                    heatMap()
                                                }
                                                .overlay(Text(String(rouletteNumBetSize[button.storedValue])).font(.system(size: 13)).foregroundColor(.white).bold().offset(x:0, y: 0))

                                        }
                                    }
                                    }
                                })
                                .frame(width: button.squareWidth, height: (button.squareHeight * 0.8), alignment: .center)
                                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                
                            }
                            }
                            .padding(.top, 5)
                        }
                    }
                    
                    Spacer()
                            }
                .padding(.top, 2) // small gap between board and outer squares to make street squares touchable
                .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
                    
                    
                    HStack(spacing:0) {
                        Spacer()
                        Button(action: {
                            RandomBet() // doesn't work yet
                        }, label: {
                        Text("Random")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50, alignment: .center)
                            .border(Color.white, width: 2)
                           
                        })
                        .background(Color.yellow.opacity(0.3))
                        
                        Text("Total Bet: \n$" + String(totalBets))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 125, height: 50, alignment: .center)
                            .background(Color.blue.opacity(0.5))
                            .border(Color.white, width: 1)
                            .padding(1)
                        // Text box to show board coverage
                        Text("Coverage: \n" + String(profitableSquares) + "%")
                            .bold()
                            .frame(width: 145, height: 50, alignment: .center)
                            .background(Color.blue.opacity(0.5))
                            .border(Color.white, width: 1)
                            .padding(1)
                            .foregroundColor(.white)
                            
//                            .padding(.leading, 40)
                        Text("Biggest wins: \n" + joinedWinners + String(biggestHit))
                                .bold()
                                .frame(width: 192, height: 50, alignment: .center)
                                .background(Color.blue.opacity(0.5))
                                .border(Color.white, width: 1)
                                .padding(1)
                                .foregroundColor(.white)
                        
   
                        Button(action: {
                            clearBoard() // doesn't work yet
                        }, label: {
                        Text("Clear Board")
                            .bold()
//                            .frame(width: 100, height: 60, alignment: .center)
//                            .background(Color.yellow.opacity(0.3))
                            .foregroundColor(.white)
                            .frame(width: 115, height: 50, alignment: .center)
                            .border(Color.white, width: 2)
//                            .padding(.leading, 0)
                        })
                        .background(Color.yellow.opacity(0.3))
                    Spacer()
                        
                    }
                    .padding(.trailing, 35) // this padding is necessary for iphones with the dip that intrude upon the row squares
//                    Spacer()
                }
                
            }
        }
        
        .background(Color(red:63/255, green:64/255, blue:69/255))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            } // closing bracket for isIpad switch
                
            case 1:
                
                VStack(spacing: 2) {
//                    Spacer()
                    
                    Text("Profitability of Each Square")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .padding(.top, safeHeight * 0.15)
                    
                        
                HStack(spacing:0) {
                  
                   
                    
                    // Inner squares
                        ForEach(buttons, id: \.self) { row in

                            VStack {
                                Spacer()
                                ForEach(row, id: \.self) { button in
                                    
                                        Text(String(Int(squareProfit[button.storedValue])) + "\n\(percentReturn[button.storedValue])%")
                                            .font(.system(size: 12))
                                            // 1.04 multiplier on frame dimensions is to compensate for discrepancy between board 1 and 2
                                            .frame(width: button.squareWidth * 1.04, height: button.squareHeight * 1.04, alignment: .center)
                                            .foregroundColor(greenValue[button.storedValue] == 0 && redValue[button.storedValue] == 0 ? button.textColor : Color.black)
        //                                    .background(button.squareColor)
        //                                    .background(Color.clear)
//                                            .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                            .background(greenValue[button.storedValue] == 0 && redValue[button.storedValue] == 0 ? button.squareColor :
                                                                        Color(red: redValue[button.storedValue], green: greenValue[button.storedValue], blue: 0/255)) // set to default roulette colors unless heatmap values active
                                    

                                }
                                }

                            }
                    
                }
                    
                    
                HStack {
                    Spacer()
                    VStack {
                        
                        // Outer Squares
                    ForEach(outerButtons, id: \.self) { row in
                    //   VStack(spacing: 0) {
                            HStack(spacing: 0) {
                            ForEach(row, id: \.self) { button in
                                
                                    VStack(spacing: 0) {

                                    Text(button.squareLabel)

                                    .font(.system(size: 16))
                                    .frame(width: button.squareWidth, height: (button.squareHeight * 0.8), alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.clear)
                                    .border(Color.white, width: 1)
                                    }

                            }

                            }
                        }
                    }
                    Spacer()
            }
                    
                    // Text box to show board coverage
                    HStack(spacing:0) {
                        Spacer()
//                        VStack(spacing: 0) {
                        Text("Total Bet: \n$" + String(totalBets))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 125, height: 50, alignment: .center)
                            .background(Color.blue.opacity(0.5))
                            .border(Color.white, width: 1)
                            .padding(1)
                        Text("Coverage: \n" + String(profitableSquares) + "%")
                            .bold()
                            .frame(width: 145, height: 50, alignment: .center)
                            .background(Color.blue.opacity(0.5))
                            .border(Color.white, width: 1)
                            .padding(1)
                            .foregroundColor(.white)
                            
//                            .padding(.leading, 40)
                        Text("Biggest wins: \n" + joinedWinners + String(biggestHit))
                                .bold()
                                .frame(width: 192, height: 50, alignment: .center)
                                .background(Color.blue.opacity(0.5))
                                .border(Color.white, width: 1)
                                .padding(1)
                                .foregroundColor(.white)
                            Text("EV: \n" + String(ev.description))
                                .bold()
                                .frame(width: 100, height: 50, alignment: .center)
                                .background(Color.blue.opacity(0.5))
                                .border(Color.white, width: 1)
                                .padding(1)
                                .foregroundColor(.white)
                                
//                                .frame(width: 400, alignment: .topLeading)
//                        Spacer()
//                        }
                        
//                        .background(Color.blue.opacity(0.5))
                        
//                        .frame(width: 400, height:80, alignment: .topLeading)
//                        .padding(.leading, 4)
                        
   
                        Button(action: {
                            clearBoard() // doesn't work yet
                        }, label: {
                        Text("Clear Board")
                            .bold()
//                            .frame(width: 100, height: 60, alignment: .center)
//                            .background(Color.yellow.opacity(0.3))
                            .foregroundColor(.white)
                            .frame(width: 115, height: 50, alignment: .center)
                            .border(Color.white, width: 2)
//                            .padding(.leading, 0)
                        })
                        .background(Color.yellow.opacity(0.3))
//                        .frame(width: 160, height: 30, alignment: .center)
                    Spacer()
                        
                    }
                }
//                .background(Image("green")) // background felt image for second screen
                .background(Color(red:63/255, green:64/255, blue:69/255))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            case 2:
                ZStack {
                    HStack {
                        
                    VStack(spacing: 5) {
//                        Spacer()
                    Text("Randomizer Settings")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        Spacer()
//                        Divider()
                        
                        
//                        Toggle("Favor Adjacent Numbers", isOn: $favorAdjacent)
//                            .padding(.all, 5)
                        Toggle("Require Minimum Wheel Coverage:", isOn: $requireMinCoverage)
                            .padding(.all, 5)
                        Toggle("Minimum Return per winning number:", isOn: $requireMinReturn)
                            .padding(.all, 5)
//                        Divider()
                        HStack {
                            Text("Total Bet: $\(Int(maxRandomBet))")
                                .padding(.leading, 5)
                            Slider(value: $maxRandomBet, in: 2...100)
                                .padding(.trailing, 5)
                        }
                        HStack {
                            Text("Max Single Bet: $\(Int(maxSingleBet))")
                                .padding(.leading, 5)
                            Slider(value: $maxSingleBet, in: 2...15)
                                .padding(.trailing, 5)
                        }
                        HStack {
                            Text("Minimum Wheel Coverage: \(Int(minCoverage))%")
                                .padding(.leading, 5)
                            Slider(value: $minCoverage, in: 10...90)
                                .padding(.trailing, 5)
                        }
                        HStack {
                            Text("Min Return per \nWinner: \(Double(minReturn))x")
                                .padding(.leading, 5)
                            Slider(value: $minReturn, in: 0.1...10)
                                .padding(.trailing, 5)
                        }

                        
                    Spacer()
                    }
                    .frame(width: 400, height: safeHeight, alignment: .center)
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    .cornerRadius(5)
//                        Spacer()
                        VStack {
                            ScrollView {
                                Divider()
                                Text("RouletteTools")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, 10)
                                Text("Version 1.0")
                                
                            Divider()
                            Text("Touch any board location to add a chip. Hold down to remove one.\n\nThis app is brand new and we expect it to have a few issues. Please help us track them down, we'd love to hear from you! Good or bad, please contact us with your feedback so we can improve your experience.")
                                .padding([.top, .bottom], 5)
                                
                                Button(action: {
                                   EmailHelper.shared.sendEmail(subject: "Anything...", body: "", to: "")
                                 }) {
                                     Text("Send us an Email")
                                        .frame(width: 200, height: 50, alignment: .center)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                        .padding([.top, .bottom], 10)
                                 }
//                            Divider()
                                Text("Disclaimer: This application is for entertainment and educational purposes only. By using this application you agree to the terms listed here. This app must be used in accordance with any applicable laws in your country, state, or city. The maker of this app is not liable for any damages or legal ramifications resulting from the use of this application.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding([.top, .bottom], 10)
                            Text("Copyright 2020. All rights reserved.")
                                .padding([.top, .bottom], 10)
                            Spacer()
                            }
                        }
                        .foregroundColor(.white)
                        
                    }
                    
//                    VStack {
//                        Spacer()
//                    }
                }
                .padding(10)
//                .background(Image("green")) // background felt image for second screen
                .background(Color(red:63/255, green:64/255, blue:69/255))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                Spacer()
            
            
            
            
            default:
            Text("Remaining Tabs")
        }
        Spacer()
            
        Divider()
            .padding(.bottom, 1)
            
            HStack {
                ForEach(0..<3) { num in
                    Button(action:{
                        selectedIndex = num
                    }, label: {
                    Spacer()
                        
                        if num == 2 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.label) :
                                                    .init(white: 0.8))
                        }

                    Spacer()
                })
                }}
               // .background(Color.black)
            
        }
//        .background(Color.clear)
        .background(Color(red:63/255, green:64/255, blue:69/255))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    
    // }
    // Body view close
    }
// }
//contentview close
//}
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
    
    
}


//
