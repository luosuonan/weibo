//
//  SNComposeViewController.m
//  weibo
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNComposeViewController.h"
#import "SNTextView.h"
#import "SNComposeToolbar.h"
#import "SNComposePhotosView.h"
#import "SNAccount.h"
#import "SNAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "SNHttpTool.h"
#import "SNStatusTool.h"
#import "SNEmotionKeyboard.h"

@interface SNComposeViewController ()<SNComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) SNTextView *textView;
@property (nonatomic, weak) SNComposeToolbar *toolbar;
@property (nonatomic, weak) SNComposePhotosView *photosView;
@property (nonatomic, strong) SNEmotionKeyboard *emotionKeyboard;

@property (nonatomic, assign, getter=isChangingKeyboard) BOOL changingKeyboard;
@end

@implementation SNComposeViewController

- (SNEmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [SNEmotionKeyboard keyboard];
        _emotionKeyboard.bounds = CGRectMake(0, 0, SNScreenWidth, 216);
//        _emotionKeyboard.backgroundColor = [UIColor blueColor];
    }
    return _emotionKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏的内容
    [self setupNavBar];
    // 添加文本框
    [self setupTextView];
    // 添加工具条
    [self setupToolBar];
    
    [self setupPhotosView];
}

- (void)setupPhotosView
{
    SNComposePhotosView *photosView = [[SNComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    
    photosView.y = 100;
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
    
}

- (void)setupToolBar
{
    SNComposeToolbar *toolBar = [[SNComposeToolbar alloc] init];
    toolBar.width = self.view.width;
    toolBar.height = 44;

//    self.textView.inputAccessoryView = toolBar;
    
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolbar = toolBar;
    
    toolBar.delegate = self;
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    
    if (self.isChangingKeyboard) {
        self.changingKeyboard = NO;
        return;
    }
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

- (void)composeTool:(SNComposeToolbar *)toolbar didClickedButton:(SNComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case SNComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case SNComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case SNComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

- (void)openCamera
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    //    UIImagePickerControllerSourceTypePhotoLibrary,
    //    UIImagePickerControllerSourceTypeCamera,
    //    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openAlbum
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openEmotion
{
    
    self.changingKeyboard = YES;
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        self.toolbar.showEmotionButton = YES;
    } else {
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showEmotionButton = NO;
    }
    
    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
    });
}

#pragma mark -- UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    SNLog(@"%@", info);
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    [self.photosView addImage:(UIImage *)image];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTextView
{
    SNTextView *textView = [[SNTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    textView.placehoder = @"分享新鲜事...";
    textView.placehoderColor = [UIColor lightGrayColor];
    // 垂直方向可以拖动
    textView.alwaysBounceVertical = YES;
    
    self.textView = textView;
    
    textView.delegate = self;
    [textView becomeFirstResponder];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:(UIBarButtonItemStyleDone) target:self action:@selector(send)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


- (void)send
{
    if (self.photosView.images.count) {
        [self setStatusWithImage];
    } else {
        [self setStatusWithOutImage];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setStatusWithImage
{
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    params[@"access_token"] = [SNAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [self.photosView.images firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发布失败"];
    }];
    
    
}

- (void)setStatusWithOutImage
{
    SNSendStatusParam *params = [[SNSendStatusParam alloc] init];
    params.access_token = [SNAccountTool account].access_token;
    params.status = self.textView.text;
    
    
    
    [SNStatusTool sendStatusWithParam:params success:^(SNSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发布失败"];
    }];
    
    
    
    
}

- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 当用户开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

@end
