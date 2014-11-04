//
//  MenuViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    
    [self initHeaderButton];
    
    _menuTable.delegate = self;
    _menuTable.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"MenuTableCell" bundle:nil];
    [_menuTable registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    _srcArray = [NSArray arrayWithObjects:
                  [Menu initMenu:0 title:@"title0" type:@"type0" price:100 isSoldout:YES isSelect:NO],
                  [Menu initMenu:1 title:@"title1" type:@"type1" price:200 isSoldout:YES isSelect:NO],
                  [Menu initMenu:2 title:@"title2" type:@"type2" price:300 isSoldout:NO isSelect:NO],
                  [Menu initMenu:3 title:@"title3" type:@"type3" price:400 isSoldout:NO isSelect:NO],
                  [Menu initMenu:4 title:@"title4" type:@"type0" price:500 isSoldout:NO isSelect:NO],
                  [Menu initMenu:5 title:@"title5" type:@"type1" price:600 isSoldout:NO isSelect:NO],
                  [Menu initMenu:6 title:@"title6" type:@"type2" price:700 isSoldout:NO isSelect:NO],
                  [Menu initMenu:7 title:@"title7" type:@"type3" price:800 isSoldout:NO isSelect:NO],
                  [Menu initMenu:8 title:@"title8" type:@"type0" price:900 isSoldout:NO isSelect:NO],
                  [Menu initMenu:9 title:@"title9" type:@"type1" price:1000 isSoldout:NO isSelect:NO],
                  [Menu initMenu:10 title:@"title10" type:@"type2" price:1100 isSoldout:NO isSelect:NO],
                  nil];
    _menuArray = _srcArray;
    
    [self reloadViewAll];
}

- (void)initHeaderButton {
    // shopping button
    [_shoppingButton setBackgroundImage:[UIImage imageNamed:@"shoppingcart128.png"] forState:UIControlStateNormal];
    [_shoppingButton setBackgroundColor:[UIColor whiteColor]];
    _shoppingButton.tag = 6;
    [_shoppingButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // all button
    // FFA846
    [_allButton setBackgroundColor:[UIColor colorWithRed:1.0 green:0.659 blue:0.275 alpha:1.0]];
    _allButton.tag = 1;
    [_allButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // don button
    // DB766F
    [_donButton setBackgroundColor:[UIColor colorWithRed:0.859 green:0.463 blue:0.435 alpha:1.0]];
    _donButton.tag = 2;
    [_donButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // maindish button
    // A8E06E
    [_maindishButton setBackgroundColor:[UIColor colorWithRed:0.659 green:0.878 blue:0.431 alpha:1.0]];
    _maindishButton.tag = 3;
    [_maindishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // sidedish button
    // DB766F
    [_sidedishButton setBackgroundColor:[UIColor colorWithRed:0.859 green:0.463 blue:0.435 alpha:1.0]];
    _sidedishButton.tag = 4;
    [_sidedishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // other button
    // 6E7EDB
    [_otherButton setBackgroundColor:[UIColor colorWithRed:0.431 green:0.494 blue:0.859 alpha:1.0]];
    _otherButton.tag = 5;
    [_otherButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_menuArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Menu *menu = [_menuArray objectAtIndex:indexPath.row];
    
    // set menu title
    cell.menuTitle.text = menu.title;
    
    // set menu picture
    UIImage *srcImage = [UIImage imageNamed:@"image.jpg"];
    
    if (menu.isSoldout) {
        [cell.menuImageButton setBackgroundImage:[self getBrightnessImage:srcImage] forState:UIControlStateNormal];
        [cell.menuImageButton setTitle:@"売り切れ" forState:UIControlStateNormal];
        [cell.menuImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [cell.menuImageButton setBackgroundImage:srcImage forState:UIControlStateNormal];
    }
    [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
    
    // set menu type
    cell.menuType.text = menu.type;
    cell.menuType.backgroundColor = [UIColor blueColor];
    cell.menuType.textColor = [UIColor whiteColor];
    cell.menuType.layer.cornerRadius = 6;
    
    // set menu price
    NSString *price = [NSString stringWithFormat:@"%ld", (long)menu.price];
    cell.menuPrice.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
    
    [cell.menuSelectButton addTarget:self action:@selector(selectMenuItem:event:) forControlEvents:UIControlEventTouchUpInside];

    if (menu.isSelect) {
        [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
    } else {
        [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)calcSumPrice {
    Menu *menu = nil;
    NSInteger sumPrice = 0;
    for (int i=0; i<[_srcArray count]; i++) {
        menu = [_srcArray objectAtIndex:i];
        if (menu.isSelect) {
            sumPrice += menu.price;
        }
    }

    NSString *price = [NSString stringWithFormat:@"%ld", (long)sumPrice];
    _sumPriceLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
}

-(void)reloadViewAll {
    [self calcSumPrice];
    [_menuTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
}

- (UIImage *)getBrightnessImage:(UIImage *)srcImage {
    // UIImage -> GPUImage
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:srcImage];
    // grayscale filter alloc
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    // set brightness value
    [brightnessFilter setBrightness:-0.3];
    // add filter
    [imagePicture addTarget:brightnessFilter];
    // run filter
    [imagePicture processImage];
    // get UIImage
    UIImage *outputImage = [brightnessFilter imageByFilteringImage:srcImage];
    
    return outputImage;
}



- (void)transToDetail:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    _selectedMenu = indexPath.row;
    [self performSegueWithIdentifier:@"toDetailSegue" sender:self];
}


- (void)selectMenuItem:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    Menu *menu = [_menuArray objectAtIndex:indexPath.row];
    menu.isSelect = !menu.isSelect;
    
    [self reloadViewAll];
}

- (NSIndexPath *)indexPathForControlEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:_menuTable];
    NSIndexPath *indexPath = [_menuTable indexPathForRowAtPoint:p];
    return indexPath;
}

- (void)selectCategory:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSPredicate *predicate;
    _menuArray = _srcArray;
    switch (button.tag) {
        case 1:
            break;
        case 2:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", @"type0"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 3:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", @"type1"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 4:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", @"type2"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 5:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"type", @"type3"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 6:
            predicate = [NSPredicate predicateWithFormat:@"isSelect = YES"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        default:
            break;
    }
    
    [_menuTable reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toDetailSegue"]) {
//        Menu *menu = [_srcArray objectAtIndex:_selectedMenu];
        Menu *menu = [_menuArray objectAtIndex:_selectedMenu];
        DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
        vc.detailMenu = menu;
    }
}

- (IBAction)saveButton:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelect = YES"];
    NSArray *selectedArray = [_menuArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", selectedArray);
}

- (void)getDataFromServer {
    
    if (![PDUtils isConnectNetwork]) {
        [PDUtils alertDialog:NOT_CONNECT_NETWORK delegate:self];
        return;
    }
    
    [ExtendedPDAPIConnection getMessages:10.0f completeBlock:^(NSArray *messages) {
        _messageArray = messages;
        MenuList *menus = _messageArray[0];
        NSLog(@"%@", menus);
        
        

    } errorBlock:^(int errorCode, NSString *errorMessage) {
        
    } cancelBlock:^{
        
    }];
}

@end
