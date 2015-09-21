//
//  PhotoSelector.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import AVFoundation
import Bolts

final class PhotoSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private struct Const {
        static let UploadImageSize = CGSizeMake(1242, 1242)
    }

    func show() -> BFTask {
        let completionSource = BFTaskCompletionSource()
        let actionSheet = ActionSheet.Builder()

        // フロントカメラ
        actionSheet.defaultStyle(localizedString("takePicture"), {
            [weak self] in
            if let strongSelf = self {
                strongSelf.showFrontCamera().continueWithBlock({
                    (task) -> AnyObject! in
                    if let error = task.error {
                        completionSource.setError(error)
                        return nil
                    }

                    if let image = task.result as? UIImage {
                        completionSource.setResult(image)
                    } else {
                        completionSource.setError(Error.create())
                    }

                    return nil
                })
            }
        })

        // カメラロール
        actionSheet.defaultStyle(localizedString("selectFromCameraRoll"), {
            [weak self] in
            if let strongSelf = self {
                strongSelf.showImagePicker().continueWithBlock({
                    (task) -> AnyObject! in
                    if let error = task.error {
                        completionSource.setError(error)
                        return nil
                    }

                    if let image = task.result as? UIImage {
                        completionSource.setResult(image)
                    } else {
                        completionSource.setError(Error.create())
                    }

                    return nil
                })
            }
        })

        // キャンセル
        actionSheet.cancelStyle(localizedString("cancel"), {
            () in
            completionSource.setError(Error.create(.TaskCancelled))
        })

        actionSheet.show()
        return completionSource.task
    }

    func showFrontCamera() -> BFTask {
        return showCamera(.Front)
    }

    func showRearCamera() -> BFTask {
        return showCamera(.Rear)
    }

    func showImagePicker() -> BFTask {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            return BFTask(error: Error.create(.PhotoLibraryNotAvailable))
        }

        let completionSource = BFTaskCompletionSource()
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = true
        configureImagePickerController(picker, completionSource: completionSource)
        showImagePickerController(picker)
        return completionSource.task
    }
}

extension PhotoSelector {
    private func showCamera(device: UIImagePickerControllerCameraDevice) -> BFTask {
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            return BFTask(error: Error.create(.CameraNotAvailable))
        }

        // カメラが許可されているかどうか確認
        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case .Restricted, .Denied:
            return BFTask(error: Error.create(.CameraNotAvailable))
        default:
            break
        }

        // カメラが使えるかどうか確認
        if !UIImagePickerController.isCameraDeviceAvailable(device) {
            switch device {
            case .Front, .Rear:
                return BFTask(error: Error.create(.CameraNotAvailable))
            }
        }

        let completionSource = BFTaskCompletionSource()
        let picker = UIImagePickerController()
        picker.sourceType = .Camera
        picker.cameraDevice = device
        picker.allowsEditing = true
        configureImagePickerController(picker, completionSource: completionSource)
        showImagePickerController(picker)
        return completionSource.task
    }

    private func configureImagePickerController(picker: UIImagePickerController, completionSource: BFTaskCompletionSource) {
        picker.bk_didFinishPickingMediaBlock = {
            [weak self] (picker, info) in
            self?.didFinishPickingMediaBlock(picker, info: info, completionSource: completionSource)
            return
        }

        picker.bk_didCancelBlock = {
            (picker) in
            GCD.runOnMainThread({
                picker.dismissViewControllerAnimated(true, completion: {
                    () in
                    completionSource.setError(Error.create(.TaskCancelled))
                })
            })
        }
    }

    private func didFinishPickingMediaBlock(picker: UIImagePickerController, info: [NSObject: AnyObject], completionSource: BFTaskCompletionSource) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {

            let resizedImage = image.resizeAspectFit(Const.UploadImageSize)

            GCD.runOnMainThread({
                picker.dismissViewControllerAnimated(true, completion: {
                    () in
                    completionSource.setResult(resizedImage)
                })
            })
        } else {
            picker.dismissViewControllerAnimated(true, completion: {
                () in
                completionSource.setError(Error.create())
            })
        }
    }

    private func showImagePickerController(picker: UIImagePickerController) {
        if let topViewController = currentTopViewController() {
            topViewController.presentViewController(picker, animated: true, completion: nil)
        } else {
            BFTask(error: Error.create())
        }
    }
}
