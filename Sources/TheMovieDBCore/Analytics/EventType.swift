//
//  File.swift
//  
//
//  Created by alfian on 02/08/24.
//

import Foundation

enum EventType: String {
  case screenView = "screen_view"
  case sessionStart = "session_start"
  case sessionEnd = "session_end"
  case buttonClick = "button_click"
  case formSubmission = "form_submission"
  case loadingTime = "loading_time"
  case purchase = "purchase"
  case signUp = "sign_up"
  case featureUsage = "feature_usage"
  case feedback = "feedback"
}

public extension String {
  static var screenView = EventType.screenView.rawValue
  static var sessionStart = EventType.sessionStart.rawValue
  static var sessionEnd = EventType.sessionEnd.rawValue
  static var buttonClick = EventType.buttonClick.rawValue
  static var formSubmission = EventType.formSubmission.rawValue
  static var loadingTime = EventType.loadingTime.rawValue
  static var purchase = EventType.purchase.rawValue
  static var signUp = EventType.signUp.rawValue
  static var featureUsage = EventType.featureUsage.rawValue
  static var feedback = EventType.feedback.rawValue
}
