# FSPicker for iOS

[![CocoaPods](https://img.shields.io/cocoapods/v/FSPicker.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/p/FSPicker.svg)]()

FSPicker is a Filestack's reimplementation of [iOS-picker](https://github.com/Ink/ios-picker).
If you have any feature request or bug to report, please open an issue or PR.

## Requirements

iOS 8.4 or later

## Installation
### Using CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

```bash
$ gem install cocoapods
```
To integrate FSPicker into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod "FSPicker", "~> 0.1.0"
```
Then, run the following command:

```bash
$ pod install
```

```FSPicker``` depends on [Filestack pod](https://github.com/filestack/filestack-ios) and this pod will be installed for you automatically.

## Documentation

### Basic Initialization

To begin using FSPicker you need to import the module:

```objectivec
@import FSPicker;
```

Initialize [config](#fsconfig), (optionally [theme](#fstheme) and [store options](#fsstoreoptions)) and finally FSPickerController:

```objectivec
FSConfig *config = [[FSConfig alloc] initWithApiKey:@"YOUR_API_KEY"];

FSStoreOptions *storeOptions = [[FSStoreOptions alloc] init];
storeOptions.location = FSStoreLocationS3;

config.storeOptions = storeOptions;

FSTheme *theme = [FSTheme filestackTheme];

FSPickerController *fsPickerController = [[FSPickerController alloc] initWithConfig:config theme:theme];
fsPickerController.fsDelegate = self;

// present the controller
[self presentViewController:fsPickerController animated:YES completion:nil];
```
### FSPickerDelegate

```objectivec
// Called when user dismisses the picker controller.
- (void)fsPickerDidCancel:(FSPickerController *)picker;

// Called when picking of a single file resulted in error.
// This does not mean that picking of the rest of the files (in case of multiple files available) is interrupted.
// All files of multiple files pick, that resulted in error will call this method.
- (void)fsPicker:(FSPickerController *)picker pickingDidError:(NSError *)error;

// Called when picking of a single file completed with success.
// If you are picking multiple files this will be called for each of successfully picked file.
- (void)fsPicker:(FSPickerController *)picker pickedMediaWithBlob:(FSBlob *)blob;

// Called when "files picking" is finished. Blobs array will contain blobs of all successfully picked files.
- (void)fsPicker:(FSPickerController *)picker didFinishedPickingMediaWithBlobs:(NSArray<FSBlob *> *)blobs;
```

### FSConfig

#### Available properties:

```objectivec
NSString *apiKey;
NSArray<NSString *> *sources;
NSArray<FSMimeType> *mimeTypes;
NSInteger maxFiles;
BOOL selectMultiple;
BOOL shouldDownload;
BOOL shouldUpload;
FSStoreOptions *storeOptions;
```

#### "Configuring the config"

The most important property is ```apiKey``` also it is the only property you need to provide for FSPicker to actually work. You can find your application's api key in developer portal.

```sources``` array allows you to configure sources you'd like to have available in your application. You can find sources names [below](#sources-names-constants). If no or empty array is set - all sources are displayed on the list.

```mimeTypes``` array is used to constraining displayed files to certain types. There are typedefs [defined](#mimetypes-typedef) for your convenience. If this property is not provided all file types will be available for uploading (*/*).

```maxFiles``` sets maximum number of files to upload simultaneously. Unlimited by default.

```shouldUpload``` & ```shouldDownload``` #TODO

```storeOptions``` [FSStoreOptions](#fsstoreoptions)

#### Sources names constants:

```objectivec
FSSourceBox
FSSourceCameraRoll
FSSourceDropbox
FSSourceFacebook
FSSourceGithub
FSSourceGmail
FSSourceImageSearch
FSSourceCamera
FSSourceGoogleDrive
FSSourceInstagram
FSSourceFlickr
FSSourcePicasa
FSSourceSkydrive
FSSourceEvernote
FSSourceCloudDrive
```

#### MimeTypes typedef:

```objectivec
typedef NSString * FSMimeType;

FSMimeTypeAll @"*/*"
FSMimeTypeVideoAll @"video/*"
FSMimeTypeVideoQuickTime @"video/quicktime"
FSMimeTypeImageAll @"image/*"
FSMimeTypeImagePNG @"image/png"
FSMimeTypeImageJPEG @"image/jpeg"
```

### FSTheme

#### Available properties:
(with numbers that they represent in images below)

```objectivec
UIBarStyle navigationBarStyle
NSAttributedString *refreshControlAttributedTitle (11)
UIColor *navigationBarBackgroundColor (6)
UIColor *navigationBarTintColor (1)
UIColor *headerFooterViewTintColor (2)
UIColor *headerFooterViewTextColor (3)
UIColor *tableViewBackgroundColor
UIColor *tableViewSeparatorColor (5)
UIColor *tableViewCellBackgroundColor (13b)
UIColor *tableViewCellTextColor (13c)
UIColor *cellIconTintColor (4, 17)
UIColor *tableViewCellIconTintColor (4)
UIColor *tableViewCellSelectedBackgroundColor (13)
UIColor *tableViewCellSelectedTextColor (13a)
UIColor *tableViewCellImageViewBorderColor (14)
UIColor *collectionViewBackgroundColor
UIColor *collectionViewCellBackgroundColor
UIColor *collectionViewCellBorderColor (15)
UIColor *collectionViewCellTitleTextColor (16)
UIColor *uploadButtonTextColor (10)
UIColor *uploadButtonBackgroundColor (9)
UIColor *refreshControlTintColor (12)
UIColor *refreshControlBackgroundColor (12a)
UIColor *searchBarBackgroundColor (19)
UIColor *searchBarTintColor (18)
UIColor *activityIndicatorColor
UIColor *progressCircleTrackColor (7)
UIColor *progressCircleProgressColor (8)
```

![Fig1](/ReadmeImages/1a.png)
![Fig2](/ReadmeImages/2a.png)
![Fig3](/ReadmeImages/3a.png)
![Fig4](/ReadmeImages/4a.png)
![Fig5](/ReadmeImages/5a.png)
![Fig6](/ReadmeImages/6a.png)
![Fig7](/ReadmeImages/7a.png)

```objectivec
// Example
FSTheme *theme = [[FSTheme alloc] init];
theme.uploadButtonTextColor = [UIColor redColor];
theme.progressCircleTrackColor = [UIColor blueColor];
theme.progressCircleProgressColor = [UIColor whiteColor];

NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
theme.refreshControlAttributedTitle = [[NSAttributedString alloc] initWithString:@"Loading stuff" attributes:attributes];
```

### FSStoreOptions

Convenience class to create an optional object that configures how to store the data. FSStoreOptions can be initialized with either ```NSDictionary``` or by default ```[[FSStoreOptions alloc] init]``` and then setting the values "by hand".

```objectivec
// Example
FSStoreOptions *options = [[FSStoreOptions alloc] init];
options.location = FSStoreLocationS3;

// "fileName" and "mimeType" properties are omitted while uploading files using FSPicker.

// Example
FSStoreOptions *options = [[FSStoreOptions alloc] initWithDictionary:@{@"location": FSStoreLocationS3}];
```

Available dictionary keys (and properties):
- **location** (FSStoreLocation typedef of NSString, FSStoreLocationAzure, FSStoreLocationDropbox, FSStoreLocationRackspace or FSStoreLocationGoogleCloud)
  - Where to store the file. **If no location is provided FSPicker will use "pick" method to create a symlink to your file, or the file (local) will be stored on Filestack's S3**. Other options are 's3', 'azure', 'dropbox', 'rackspace' and 'gcs' (```FSStoreLocationS3```, ```FSStoreLocationAzure```, ```FSStoreLocationDropbox```, ```FSStoreLocationRackspace``` and ```FSStoreLocationGoogleCloud```). You must have configured your storage in the developer portal to enable this feature.
- **path** (NSString)
  - The path to store the file at within the specified file store. For S3, this is the key where the file will be stored at. By default, Filestack stores the file at the root at a unique id, followed by an underscore, followed by the filename, for example "3AB239102DB_myphoto.png". If the provided path ends in a '/', it will be treated as a folder, so if the provided path is "myfiles/" and the uploaded file is named "myphoto.png", the file will be stored at "myfiles/909DFAC9CB12_myphoto.png".
- **container** (NSString)
  - The bucket or container in the specified file store where the file should end up. This is especially useful if you have different containers for testing and production and you want to use them both on the same Filestack app. If this parameter is omitted, the file is stored in the default container specified in your developer portal. Note that this parameter does not apply to the Dropbox file store.
- **access** (FSAccess typedef of NSString, either FSAccessPublic or FSAccessPrivate)
  - Indicates that the file should be stored in a way that allows public access going directly to the underlying file store. For instance, if the file is stored on S3, this will allow the S3 url to be used directly. This has no impact on the ability of users to read from the Filestack file URL. Defaults to 'private'.
- **base64decode** (BOOL)
  - Specify that you want the data to be first decoded from base64 before being written to the file. For example, if you have base64 encoded image data, you can use this flag to first decode the data before writing the image file.
- **security** (FSSecurity)
  - If you have security enabled, you'll need to have a valid Filestack policy and signature in order to perform the requested call. This allows you to select who can and cannot perform certain actions on your site. [Read more about security and how to generate policies and signatures](https://www.filestack.com/docs/security)

### FSSecurity class

A simple class to store your security policy and signature. **FSSecurity** instance is a ```security``` parameter in **FSStoreOptions**.
[Read more about security and how to generate policies and signatures](https://www.filestack.com/docs/security)

```- initWithPolicy:signature:```

## License

FSPicker is released under the MIT license. See LICENSE for details.
