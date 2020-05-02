//
//  SBUIconSet.swift
//  SendBirdUIKit
//
//  Created by Harry Kim on 2020/02/07.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit

@objcMembers
public class SBUIconSet: NSObject {
    
    private static let bundle = Bundle(identifier: "com.sendbird.uikit")
    
    public static var iconActionLeave = getImage(name: "iconActionLeave")
    public static var iconActionNotificationOn = getImage(name: "iconActionNotificationOn")
    public static var iconActionNotificationOff = getImage(name: "iconActionNotificationOff")
    public static var iconAdd = getImage(name: "iconAdd")
    public static var iconBack = getImage(name: "iconBack")
    public static var iconCamera = getImage(name: "iconCamera")
    public static var iconPlus = getImage(name: "iconPlus")
    public static var iconChat = getImage(name: "iconChat")
    public static var iconCheckbox = getImage(name: "iconCheckbox")
    public static var iconCheckboxOff = getImage(name: "iconCheckboxOff")
    public static var iconClose = getImage(name: "iconClose")
    public static var iconCopy = getImage(name: "iconCopy")
    public static var iconCreate = getImage(name: "iconCreate")
    public static var iconDelete = getImage(name: "iconDelete")
    public static var iconDelivered = getImage(name: "iconDelivered")
    public static var iconDocument = getImage(name: "iconDocument")
    public static var iconDownload = getImage(name: "iconDownload")
    public static var iconDummy = getImage(name: "iconDummy")
    public static var iconEdit = getImage(name: "iconEdit")
    public static var iconError = getImage(name: "iconError")
    public static var iconErrorFilled = getImage(name: "iconErrorFilled")
    public static var iconGif = getImage(name: "iconGif")
    public static var iconInfo = getImage(name: "iconInfo")
    public static var iconLeave = getImage(name: "iconLeave")
    public static var iconMembers = getImage(name: "iconMembers")
    public static var iconMute = getImage(name: "iconMute")
    public static var iconNotifications = getImage(name: "iconNotifications")
    public static var iconThumbnailLight = getImage(name: "iconThumbnailLight")
    public static var iconNoThumbnailLight = getImage(name: "iconNoThumbnailLight")
    public static var iconPhoto = getImage(name: "iconPhoto")
    public static var iconPlay = getImage(name: "iconPlay")
    public static var iconRead = getImage(name: "iconRead")
    public static var iconRefresh = getImage(name: "iconRefresh")
    public static var iconAvatarLight = getImage(name: "iconAvatarLight")
    public static var iconSend = getImage(name: "iconSend")
    public static var iconSent = getImage(name: "iconSent")
    public static var iconFailed = getImage(name: "iconFailed")
    public static var iconShevronRight = getImage(name: "iconShevronRight")
    public static var iconUser = getImage(name: "iconUser")
    public static var iconSpinnerSmall = getImage(name: "iconSpinnerSmall")
    public static var iconSpinnerLarge = getImage(name: "iconSpinnerLarge")
    public static var iconFileDocument = getImage(name: "iconFileDocument")
    public static var iconFileAudio = getImage(name: "iconFileAudio")
    public static var iconChevronDown = getImage(name: "iconChevronDown")
}

private extension SBUIconSet {
    
    static func getImage(name: String, tintColor: UIColor? = nil) -> UIImage {
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)!
        guard let tintColor = tintColor else { return image }
        return image.with(tintColor: tintColor)
    }
    
}
