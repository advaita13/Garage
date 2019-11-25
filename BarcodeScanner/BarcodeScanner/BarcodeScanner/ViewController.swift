//
//  ViewController.swift
//  BarcodeScanner
//
//  Created by Pandya, Advaita | Adi | RP on 2019/11/25.
//  Copyright © 2019 AdiPadi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var previewView: PreviewView!

    private let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        configureAVSession()
        previewView.videoPreviewLayer.session = captureSession
        captureSession.startRunning()
    }

    func configureAVSession() {
        captureSession.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)

        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoDeviceInput)
            else { return }

        captureSession.addInput(videoDeviceInput)

        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(captureMetadataOutput) {
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
        }

        captureSession.commitConfiguration()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard
            metadataObjects.count != 0,
            let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            else {
            // No QR code is detected.
            return
        }

        if metadataObject.type == .qr,
            let metadataStringValue = metadataObject.stringValue {
            print("String Value for QR: \(metadataStringValue)")
        }
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

