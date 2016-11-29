//
//  DiaryViewController.m
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/22.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "DiaryViewController.h"
#import "Diary+CoreDataClass.h"
#import "CoreDataManager.h"
#import "CellTableViewController.h"


@interface DiaryViewController (){
    CoreDataManager * diaryManager;
    Diary * diaryInfo;
    
}
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *diaryTextView;

@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(BackMainvc:)];
    self.navigationItem.leftBarButtonItem = back;
    
    // Do any additional setup after loading the view.
    diaryManager = [[CoreDataManager alloc]initWithModel:@"Traveldiary" dbFileName:@"diary.sqlite" dbFilePathURL:nil sortKey:@"title" entityName:@"Diary"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)getLocationBtn:(id)sender {


    
}
//typedef void (^EditInfoCompletion)(bool success, Mou * result);

- (IBAction)saveBtnPressed:(id)sender {

    // 判斷有無內文
    if ([self.titleTextField.text isEqualToString:@""] || [self.diaryTextView.text isEqualToString:@""]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"沒有內容"message:@"輸入點什麼吧" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"明白了"style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
    }else{

        // save & go to cellTableView
        if (diaryInfo == nil) {
            //create new item necessary
            diaryInfo = (Diary* ) [diaryManager createItem];
        }
        
        diaryInfo.title = self.titleTextField.text;
        diaryInfo.adress = self.locationLabel.text;
        diaryInfo.text = self.diaryTextView.text;
        [self.delegate passValue:diaryInfo.title location:diaryInfo.adress diaryInfo:diaryInfo.text];


        
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"儲存中"message:@"回憶增加中" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"明白了"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];

            // 會有等待畫面 有空放個動畫
            
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];

        self.titleTextField.text = @"";
        self.diaryTextView.text = @"";
    }
     
}
// 返回
- (void)BackMainvc: (UIBarButtonItem *)barItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
