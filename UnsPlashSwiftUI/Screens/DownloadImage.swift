//
//  DownloadImage.swift
//  ZhylienkovStock
//
//  Created by Girish Parate on 03/05/22.
//

import SwiftUI
import AlertToast

struct DownloadImage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var url1: DownlodClass
    var url2: DownlodClass
    var url3: DownlodClass
    var url4: DownlodClass
    
    @State private var presentingAlert = false
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    @State private var isSharePresented: Bool = false
    @State private var isDownloading: Bool = false
    
    //    var url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
    //    var url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
    //    var url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
    //    var url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
    //
    @State private var selectedUrl : DownlodClass = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
    
    var body: some View {
        NavigationView {
            List {
                ForEach([url1,url2,url3,url4], id: \.self){ item in
                    DownloadListItem(title: item.title, des: item.subTitle, size: item.size,color: item.color)
                        .onTapGesture {
                            selectedUrl = item
                            presentingAlert.toggle()
                        }
                }
            }
            .navigationTitle("Download Image")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .scaledToFit()
                    })
            )
            .confirmationDialog("Change background", isPresented: $presentingAlert) {
                Button("Camera Roll") { saveToPhonePhotos() }
                Button("App Storage") { saveToAppStoreage() }
                Button("Save to Files") { saveToFiles() }
            } message: {
                Text("Select where to save image")
            }
            //Save to File
            .sheet(isPresented: $isSharePresented,
                   onDismiss: {
                isDownloading = false
            }, content: {
                ActivityViewController(activityItems: [createImageData(imageUrl: selectedUrl.url)])
            })
        }
        .overlay {
            if isDownloading == true {
                LoadingIndicator()
            } else {
                VStack{}
            }
        }
    }
    
    func screecesMessage () {
        isDownloading = false
        viewModel.title = "Image Saved"
        viewModel.subTitle = "Image is saved on your Camera Roll"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: Save to App
    func saveToAppStoreage(){
        isDownloading = true
        AppFileManager.saveImage(urlString: selectedUrl.url, fileName: selectedUrl.title)
        screecesMessage()
    }
    // MARK: Save to Files
    func saveToFiles() {
        isSharePresented.toggle()
    }
    // MARK: Save to Phots app
    func saveToPhonePhotos()  {
        isDownloading = true
        let imageServer = ImageSaver()
        let imageData = createImageData(imageUrl: selectedUrl.url)
        imageServer.successHandler = {
            print("Its working")
            screecesMessage()
        }
        imageServer.errorsHandler = {
            print("Oops! \($0.localizedDescription)")
            isDownloading = true
        }
        imageServer.writeToPhotoAlbum(image: imageData)
    }
    
    func createImageData(imageUrl: String) -> UIImage {
        var imageData : UIImage!;
        do {
            let imageUrl = try Data(contentsOf: URL(string: imageUrl)!)
            imageData =  UIImage(data: imageUrl)
        } catch {
            print("Error loading image : \(error)")
        }
        return imageData
    }
}

//struct DownloadImage_Previews: PreviewProvider {
//
//    var url1 = DownlodClass(title: "Small", subTitle: "Smallest size", url: "", size: "1MB+",color: .blue)
//    var url2 = DownlodClass(title: "Regular", subTitle: "For mobile wallpaper", url:"", size: "3MB+",color: .yellow)
//    var url3 = DownlodClass(title: "Full", subTitle: "For Desktop", url:  "", size: "6MB+",color: .orange)
//    var url4 = DownlodClass(title: "Raw", subTitle: "Original file", url:  "", size: "10MB+",color: .red)
//
//    static var previews: some View {
//        DownloadImage()
//        //        DownloadImage(url1: url1, url2: url1, url3: url1, url4: url1)
//    }
//}
