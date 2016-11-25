//
//  mouTableViewController.m
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/21.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "mouTableViewController.h"
#import "CoreDataManager.h"
#import "Mou+CoreDataClass.h"

@interface mouTableViewController ()
{
    CoreDataManager * mouDataManager;
    Boolean cellColor;
    UITableViewCell *cell;
}
@end
@implementation mouTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //create BarButtonItem  in navigationItem
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Do any additional setup after loading the view.
    mouDataManager = [[CoreDataManager alloc]initWithModel:@"Traveldiary" dbFileName:@"oudiary.sqlite" dbFilePathURL:nil sortKey:@"mouinfo" entityName:@"Mou"];

    
}
- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
}

- (void)insertNewObject:(id)sender
{
    //insert event
    [self editInfoWithDefault:nil withCompletion:^(bool success, Mou *result) {
        if (success == false) {
            return ;
        }
        [mouDataManager saveContextWithCompletion:^(BOOL success) {
            [self.tableView reloadData];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // how many row
    return [mouDataManager count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // SelectRow can change color

    Mou * mou = (Mou* )[mouDataManager getByIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    
    cell.textLabel.text = mou.mouinfo;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cellColor == NO) {
        cell.backgroundColor = [UIColor redColor];
        [self didSelectIndexPath:indexPath];
        cellColor = YES;
    }else{
        cell.backgroundColor = [UIColor blueColor];
        [self didSelectIndexPath:indexPath];

        cellColor = NO;
    }
    // judgment SelectRow
    Mou * mou = (Mou* )[mouDataManager getByIndex:indexPath.row];
    
    // codedatamodel -change
    [self editInfoWithDefault:mou withCompletion:^(bool success, Mou *result) {
        //data no change
        if (success == false) {
            return ;
        }
        //if data change
        [mouDataManager saveContextWithCompletion:^(BOOL success) {
            [self.tableView reloadData];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // judgment SelectRow
        Mou * mou = (Mou* )[mouDataManager getByIndex:indexPath.row];
        // delete data
        [mouDataManager deleteItem:mou];
        //save again
        [mouDataManager saveContextWithCompletion:^(BOOL success) {
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
// block
typedef void (^EditInfoCompletion)(bool success, Mou * result);

-(void) editInfoWithDefault:(Mou*)defaultInfo
             withCompletion:(EditInfoCompletion)completion
{
    // add new alertcontroller
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"新增事件" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // add mouinfo field
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"請輸入備忘清單";
        textField.text = defaultInfo.mouinfo;
    }];
    // add new ok Btn
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        Mou * mouInfo = defaultInfo;
        if (mouInfo == nil) {
            //create new item necessary
            mouInfo = (Mou* ) [mouDataManager createItem];
          
        }
        mouInfo.mouinfo = alert.textFields[0].text;
        completion(true,mouInfo);
    }];
    [alert addAction:ok];
    //add cancel button
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(false,nil);
    }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
    
}
-(void)didSelectIndexPath:(NSIndexPath *)indexPath{
    // judgment SelectRow
    Mou * mou = (Mou* )[mouDataManager getByIndex:indexPath.row];
    // codedatamodel -change
    [self editInfoWithDefault:mou withCompletion:^(bool success, Mou *result) {
        //data no change
        if (success == false) {
            return ;
        }
        //if data change
        [mouDataManager saveContextWithCompletion:^(BOOL success) {
            [self.tableView reloadData];
        }];
    }];
}

@end
