//
//  CellTableViewController.m
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/22.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "CellTableViewController.h"
#import "DiaryViewController.h"
#import "CoreDataManager.h"
#import "Diary+CoreDataClass.h"


@interface CellTableViewController ()<PassValueDelegate>{
    CoreDataManager * diaryManager;
    UITableViewCell * cell;
}
//@property (strong,nonatomic)    NSString * titiles;
//@property (strong,nonatomic)    NSString * adres;
//@property (strong,nonatomic)    NSString * texts;


@end

@implementation CellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem * plus = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(nextView)];
    self.navigationItem.rightBarButtonItem = plus;
    diaryManager = [[CoreDataManager alloc]initWithModel:@"Traveldiary" dbFileName:@"diary.sqlite" dbFilePathURL:nil sortKey:@"title" entityName:@"Diary"];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (cell ==  nil) {
//
//        [self.tableView reloadData];
//        
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"沒有日記" message:@"開始記錄回憶" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self nextView];
//        }];
//        
//        [alert addAction:ok];
//        [self presentViewController:alert animated:true completion:nil];
//    }
    
}

-(void)passValue:(NSString *)titile location:(NSString *)location diaryInfo:(NSString *)diartInfo{
    Diary* item = [diaryManager createItem];
    item.title = titile;
    item.adress = location;
    item.text = diartInfo;
    [diaryManager saveContextWithCompletion:^(BOOL success) {
        [self.tableView reloadData];
    }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];

    // SelectRow can change color
    Diary * diary = (Diary* )[diaryManager getByIndex:indexPath.row];



    
    cell.textLabel.text = diary.title;
    NSLog(@"ASDSDAD:%@",diary.title);
    
    cell.detailTextLabel.text = diary.adress;
    NSLog(@"ASDSDAD:%@",diary.adress);
  
    //if data change
    [diaryManager saveContextWithCompletion:^(BOOL success) {
        [self.tableView reloadData];
}];

    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
//       // judgment SelectRow
//    Diary * diarycell = (Diary* )[diaryManager getByIndex:indexPath.row];
//    
//    // codedatamodel -change
//    [self editInfoWithDefault:diarycell withCompletion:^(bool success, Diary *result) {
//        //data no change
//        if (success == false) {
//            return ;
//        }
//        //if data change
//        [diaryManager saveContextWithCompletion:^(BOOL success) {
//            [self.tableView reloadData];
//        }];
//    }];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // judgment SelectRow
        Diary * diarycell = (Diary* )[diaryManager getByIndex:indexPath.row];
        // delete data
        [diaryManager deleteItem:diarycell];
        //save again
        [diaryManager saveContextWithCompletion:^(BOOL success) {
            //reload view
            [self.tableView reloadData];
            
        }];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [diaryManager count];
}



- (void) nextView{
    
    DiaryViewController * diarycell = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryViewController"];
    diarycell.delegate  = self;
    [self showViewController:diarycell sender:nil];
    
}
//typedef void (^EditInfoCompletion)(bool success, Diary * result);
//
//-(void) editInfoWithDefault:(Diary*)defaultInfo
//             withCompletion:(EditInfoCompletion)completion
//{
//    // add new alertcontroller
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"修改日記" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    // add mouinfo field
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//
//        textField.text = defaultInfo.title;
//    }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.sizeToFit;
//        textField.text = defaultInfo.text;
//    }];
//    // add new ok Btn
//    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        Diary * diaryInfo = defaultInfo;
//        if (diaryInfo == nil) {
//            //create new item necessary
//            diaryInfo = (Diary* ) [diaryManager createItem];
//            
//        }
//        diaryInfo.title = alert.textFields[0].text;
//        diaryInfo.text = alert.textFields[1].text;
//
//        completion(true,diaryInfo);
//    }];
//    [alert addAction:ok];
//    //add cancel button
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completion(false,nil);
//    }];
//    
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:true completion:nil];
//    
//}

@end
