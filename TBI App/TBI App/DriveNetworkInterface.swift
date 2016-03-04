//
//  DriveNetworkInterface.swift
//  TBI App
//
//  Created by George McDonnell on 04/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class DriveNetworkInterface: NSObject {
    
    var service = GTLServiceDrive()
    
    init(authorizer: GTMOAuth2Authentication?) {
        if (authorizer != nil) {
            service.authorizer = authorizer
        } else {
            service.authorizer = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(Constants.kKeychainItemName, clientID: Constants.kClientID, clientSecret: nil)
        }
        super.init()
    }
    
    func saveFile(csvString: String) {
        let query = GTLQueryDrive.queryForFilesList() as! GTLQueryDrive
        query.q = "title = 'tbiData.csv' and trashed = false"
        service.executeQuery(query) { (ticket, fileList, error) -> Void in
            if (error == nil) {
                if let items = (fileList as? GTLDriveFileList)?.items() {
                    if (items.count != 0) {
                        if let file = items.first as? GTLDriveFile {
                            self.updateFileWithId(file.identifier, csvString: csvString)
                        }
                    }
                } else {
                    self.createFile(csvString)
                }
            }
        }
    }
    
    func updateFileWithId(fileID: String, csvString: String) {
        let file = createFile()
        let mimeType = "text/csv"
        let data = csvString.dataUsingEncoding(NSUTF8StringEncoding)
        let uploadParameters = GTLUploadParameters(data: data, MIMEType: mimeType)

        let query = GTLQueryDrive.queryForFilesUpdateWithObject(file, fileId: fileID, uploadParameters: uploadParameters) as! GTLQueryDrive
        
        service.executeQuery(query) { (ticket, updatedFile, error) -> Void in
            if (error == nil) {
                print("File %@", updatedFile)
            } else {
                print("An error occurred: %@", error.localizedDescription)
            }
        }
    }
    
    func createFile(csvString: String) {
        // upload to Google drive
        let file = createFile()
        let mimeType = "text/csv"
        let data = csvString.dataUsingEncoding(NSUTF8StringEncoding)
        let uploadParameters = GTLUploadParameters(data: data, MIMEType: mimeType)
        let query = GTLQueryDrive.queryForFilesInsertWithObject(file, uploadParameters: uploadParameters) as! GTLQueryDrive
        
        service.executeQuery(query) { (ticket, updatedFile, error) -> Void in
            if (error == nil) {
                print("File %@", updatedFile)
            } else {
                print("An error occurred: %@", error.localizedDescription)
            }
        }
    }
    
    func createFile() -> GTLDriveFile {
        let title = "tbiData.csv"
        let file = GTLDriveFile.object() as! GTLDriveFile
        file.title = title
        
        return file
    }
}
