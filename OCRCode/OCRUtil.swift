/**
**  OCRUtil.swift
**  OCRCode
**
**  Created by Ege Kaan Gürkan on 16.06.2021.
*/

import Foundation
import Vision
import SwiftUI
import AVFoundation

class OCRUtil {
    
    var strings: [String]
    var tempdir: String!
    
    init() {
        strings = []
        tempdir = NSTemporaryDirectory()
    }
    
    func getStrings(image: NSImage) -> [String] {
        
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage!)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
            return strings
            
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        return []
    }
    
    private func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        // Process the recognized strings.
//        processResults(recognizedStrings: recognizedStrings)
        strings = recognizedStrings
    }
    
    private func processResults(recognizedStrings: [String]) {
        recognizedStrings.forEach{ strings in
            print(strings)
        }
    }
    
    @objc func screenCapture() {
        
        let captureTask = Process()
        
//        let timestamp: Int = lround(NSDate().timeIntervalSince1970 * 1000)
        
        captureTask.launchPath = "/usr/sbin/screencapture"
        
        let arguments = ["-x","-i", "-r"]
        
        captureTask.arguments = arguments
        
        captureTask.launch()
        captureTask.waitUntilExit()
    }
    
}
