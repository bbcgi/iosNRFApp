//
//  ViewController.m
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/11/5.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import "mainViewController.h"

@interface ViewController ()
{
    //Test
    //BOOL did;

    //Next View Data
    CBCharacteristic *mainToRW_characteristic_write;
    CBCharacteristic *mainToRW_characteristic_read;
    CBPeripheral *didConnectPeripheral;
    CBCentralManager *mainToRW_Central;
    
    //Bluetooth
    CBCentralManager *CM;
    CBPeripheral *needConnectPeripheral;
#ifndef TY_BLE_DEVICE
    //NSMutableArray *discoveryPeripheralList;
    NSMutableArray<CBPeripheral *> *discoveryPeripheralList;
#endif

    //tableView
    UInt16 titleIndex, titleIndexEnd;
    NSMutableArray *titleArray;
    NSMutableArray *subtitleArray;
}
@end

@implementation ViewController

@synthesize lbStatus;
@synthesize btnDiscover;
@synthesize myTableView;
//@synthesize CM;

- (void)viewDidLoad {
//    BYTE checksum[] = { 1, 3, 5, 7};
//    BYTE add[] = { 255, 255, 255, 255};
//    [self checkSumAdd:checksum buffer:add length:4];
//    NSLog(@"[checksum]--> %x,%x,%x,%x", checksum[0], checksum[1], checksum[2], checksum[3]);

    
    /*
    int value1 = arc4random() % 16;
    NSLog(@"value1(%d)", value1);
    
    int value2 = arc4random() % 16;
    NSLog(@"value1(%d)", value2);
    
    int value3 = arc4random() % 16;
    NSLog(@"value1(%d)", value3);

    int value4 = arc4random() % 16;
    NSLog(@"value1(%d)", value4);
    
    int value5 = arc4random() % 16;
    NSLog(@"value1(%d)", value5);
    
    int value1 = arc4random() % 16;
    NSLog(@"value1(%d)", value1);
    
    int value2 = arc4random() % 16;
    NSLog(@"value1(%d)", value2);
    
    int value3 = arc4random() % 16;
    NSLog(@"value1(%d)", value3);
    
    int value4 = arc4random() % 16;
    NSLog(@"value1(%d)", value4);
    
    int value5 = arc4random() % 16;
    NSLog(@"value1(%d)", value5);
     */
    
    
    //CM = [CBCentralManager sharedInstance];
    //CoreBluetooth *bb = [CoreBluetooth sharedInstance];
    
    
//    //搜尋字串
//    //NSString *str =@"TYTT@tytt.com.tw[tab]123456[enter]";
//    NSString *str =@"tw[tab]123456[]";
//
//    //有區分大小寫
//    NSRange search = [str rangeOfString:@"[enter]"];
//    
//    //數字表示第幾字元開始有符合（從0開始）
//    NSLog(@"str.length(%lu)", (unsigned long)str.length);
//
//    NSLog(@"search.location(%lu)", (unsigned long)search.location);
//    
//    if (search.location < str.length) {
//        NSLog(@"if");
//    }
//    else {
//        NSLog(@"else");
//    }
//    NSLog(@"%lu", (unsigned long)search.location);
    
    
    //furnacedigital.blogspot.tw/2011/04/nsstring.html#sthash.hQVrn3WC.dpuf
    //[NSString To ASCII]
//    NSString *iStr = @"TYTT@tytt.com.tw[tab]123456[enter]";
//    [self sendKeyboardCode:iStr];
    
    
//    NSData *data = [iStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    //NSString *newString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    int len = (int)data.length;
//    Byte *byt = (Byte *)malloc(len);
//    //volatile BYTE byt[len];
//    NSData *nsdDataBuf;
//    [data getBytes:byt];
    
//    BYTE bbb[4];
//    bbb[0] = *(byt+1);
//    bbb[1] = byt[1];
//    bbb[2] = byt[2];
//    bbb[3] = byt[3];

//    [self reflashStatus:STATUS_WATTING];
    //[Send Write]
    //NSString *iStr = @"160, 160, 16, 16, 0, 1, 0, 1, 4, 3, 2, 1, 5, 6, 7, 8, 9, 10, 11, 12";
//    NSString *iStr = @"1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20";
//    NSArray *stringArray = [iStr componentsSeparatedByString: @","];
//    int len = (int)stringArray.count;
//    Byte *bytTotal = (Byte *)malloc(len);
//    bytTotal = [self str2Byte_Decimal:iStr];
//    UInt16 index = 0;
//    while (index < len) {
//        UInt16 sendLen = (((len - index) >= SEND_BYTE_LENGTH_MAX) ? SEND_BYTE_LENGTH_MAX : len - index);
//        if (sendLen <= SEND_BYTE_LENGTH_MAX) {
//            Byte *bytSend = (Byte *)malloc(sizeof(Byte)*sendLen);
//            memcpy(bytSend, &bytTotal[index], sizeof(Byte)*sendLen);
//            //NSData *valData = [NSData dataWithBytes:bytSend length:len];
//            //[didConnectPeripheral writeValue:valData forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
//            NSLog(@"************************************************");
//            NSLog(@"sendLen(%d)", sendLen);
//            for (UInt16 i = 0; i< sendLen; i++) {
//                NSLog(@"===============================================");
//                NSLog(@"index(%d)", index);
//                NSLog(@"bytSend[%d]=%x", i, bytSend[i]);
//                NSLog(@" ");
//            }
//            if (index >= 0) {
//                NSLog(@" ");
//            }
//            index += sendLen;
//        }
//    }
    
    
    //for (UInt16 index = 0; index < len; index++) {
    //}

//    BYTE bytTotal[] = {160, 160, 16, 16, 0, 1, 0, 1, 4, 3, 2, 1, 5, 6, 7, 8, 9, 10, 11, 12};
//    BYTE bytSend[] = {160, 160, 16, 16, 01};
//    UInt16 index = 2;
//    UInt16 sendLen = 5;
//    //Byte *bytSend = (Byte *)malloc(5);
//    memcpy(bytSend, &bytTotal[index], sendLen);
    
    [super viewDidLoad];

    //[UI Initiallize]
    [self reflashStatus:STATUS_WATTING];
    [btnDiscover setTitle:SCAN_START forState:UIControlStateNormal];
    
    //[tableView]
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    titleArray = [[NSMutableArray alloc] initWithObjects:@"Device Name", nil];
    subtitleArray = [[NSMutableArray alloc] initWithObjects:@"Service(0) RSSI(0)", nil];

#ifndef TY_BLE_DEVICE
    discoveryPeripheralList = [[NSMutableArray alloc] initWithObjects: nil];
#endif

    //[BT initialize]
    CM= [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

//-(void)checkSumAdd:(Byte *)sum buffer:(Byte *)add length:(UInt8)len
//{
//    //Byte *byt = (Byte*)malloc(len);
//    for (UInt8 i = 0; i < len; i++) {
//        *(sum+i) += *(add+i);
//    }
//}


- (void)viewDidUnload {
    lbStatus.text = nil;
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --BlueTooth centralManager
-(void)centralManagerDidUpdateState:(CBCentralManager*)cManager
{
    NSMutableString* nsmstring=[NSMutableString stringWithString:@"UpdateState:"];
    BOOL isWork=FALSE;
    switch (cManager.state) {
        case CBCentralManagerStateUnknown:
            [nsmstring appendString:@"Unknown\n"];
            break;
        case CBCentralManagerStateUnsupported:
            [nsmstring appendString:@"Unsupported\n"];
            break;
        case CBCentralManagerStateUnauthorized:
            [nsmstring appendString:@"Unauthorized\n"];
            break;
        case CBCentralManagerStateResetting:
            [nsmstring appendString:@"Resetting\n"];
            break;
        case CBCentralManagerStatePoweredOff:
            [nsmstring appendString:@"PoweredOff\n"];
            break;
        case CBCentralManagerStatePoweredOn:
            [nsmstring appendString:@"PoweredOn\n"];
            isWork=TRUE;
            
            //Ray BLE
            //[self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:KServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
            mainToRW_Central = CM;
            break;
        default:
            [nsmstring appendString:@"none\n"];
            break;
    }
    NSLog(@"%@",nsmstring);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
//    NSLog(@"%@", @"didDiscoverPeripheral");
//    NSLog(@"%@", peripheral.name);
//    NSLog(@"%@", [NSString stringWithFormat:@"Service(%lu) RRSI(%@)", peripheral.services.count, RSSI]);

    if (peripheral.name) {
#ifdef TY_BLE_DEVICE
        if ([peripheral.name isEqual:TY_BLE_DEVICE]) {
            needConnectPeripheral = peripheral;
            [self addOneCell:peripheral.name Subtitle:[NSString stringWithFormat:@"Service(%lu) RRSI(%@)", peripheral.services.count, RSSI]];
        }
#else
        if (![self searchInArray:titleArray key:peripheral.name]) {
            [discoveryPeripheralList addObject:peripheral];
            [self addOneCell:peripheral.name Subtitle:[NSString stringWithFormat:@"Service(%lu) RRSI(%@)", peripheral.services.count, RSSI]];
//            NSLog(@"\n\n000000000000000000000000000000000000000000000000");
//            NSLog(@"%@", peripheral.name);
        }
#endif
    }
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [self reflashStatus:STATUS_SELECT_CHARACTERISTICS];
    [self removeAllCell];
    didConnectPeripheral = needConnectPeripheral;
    NSLog(@"[Connected]: %@",peripheral.name);
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"[disconnect]");
}


#pragma mark --BlueTooth peripheral
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //NSLog(@"%@",@"didDiscoverServices");
    
    if(error)
    {
        //self.console.text = [NSString stringWithFormat:@"%@\n%@ %@", self.console.text, @"Error discovering service: ", [error localizedDescription]];
        NSLog(@"Error discovering service: %@", [error localizedDescription]);
        //[self cleanup];
        return;
    }

    for(CBService *service in peripheral.services)
    {
        //NSLog(@"Found service with UUID: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    //NSLog(@"%@",@"didDiscoverCharacteristicsForService");
    
    if(error)
    {
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }

    NSString *serviceName = [NSString stringWithFormat:@"%@", service.UUID];
    NSLog(@"service UUID: %@", serviceName);
    if ([serviceName isEqual:TY_UUID_SERVICE_FFF0]) {
        for(CBCharacteristic *characteristic in service.characteristics)
        {
            NSLog(@"Discovered characteristic with UUID: %@", characteristic.UUID);
            NSString *characteristicName = [NSString stringWithFormat:@"%@", characteristic.UUID];
            [self addOneCell:characteristicName Subtitle:[NSString stringWithFormat:@"%@", characteristic.UUID.UUIDString]];
            //[self addOneCell:@"FFF1" Subtitle:@"fff1"];
            
            //[Write]
            if ([characteristicName isEqual:TY_UUID_WRITE]) {
                mainToRW_characteristic_write = characteristic;
                //NSLog(@"[characteristicName isEqual:TY_UUID_WRITE]");
            }
            //[Read]
            if ([characteristicName isEqual:TY_UUID_READ]) {
                mainToRW_characteristic_read = characteristic;
                //NSLog(@"[characteristicName isEqual:TY_UUID_READ]");
                //[didConnectPeripheral setNotifyValue:YES forCharacteristic:mainToRW_characteristic_read];
            }
        }
#if 0
        if ([characteristicName isEqual:TY_UUID_WRITE]) {
            //BYTE byDataBuf[] = {160, 160, 16, 16, 0, 1, 0, 1, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};//, 21, 22, 23, 24, 25, 26, 27, 28, 29};
            BYTE byDataBuf[] = {3, 1, 2, 3};
            NSData *valData = [NSData dataWithBytes:byDataBuf length:4];
            //Send - Write
            NSLog(@"%@",@"-----[send]");
            [didConnectPeripheral writeValue:valData forCharacteristic:mainToRW_characteristic_write type:CBCharacteristicWriteWithResponse];
        }
#endif
        
#if 0
        if ([characteristicName isEqual:TY_UUID_READ]) {
            //receive - Write
            [didConnectPeripheral setNotifyValue:YES forCharacteristic:mainToRW_characteristic_read];
        }
#endif
    }
}

#if 0
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@",@"didUpdateValueForCharacteristic");
    NSLog(@"%@",@"***********************************************************************");
    NSLog(@"characteristic.UUID: %@", characteristic.UUID);
    
    //test
    //NSString *strData = [[NSString alloc] initWithData:[characteristic.value encoding:NSUTF8StringEncoding]];
    NSString *strData = [[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding];
    NSLog(@"strData(%@)", strData);
    
    NSData *nsData = characteristic.value;
    int len = (int)nsData.length;
    Byte *byt = (Byte*)malloc(len);
    memcpy(byt, [nsData bytes], len);
//    Byte *byt = (Byte*)malloc(len);
//    [nsData getBytes:byt length:len];
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];;
    //NSString *strAppend;
    for (UInt8 i=0; i<len; i++) {
        //NSLog(@"byt[%d]: %02x", i, byt[i]);
        [str appendString:[NSString stringWithFormat:@"%02x,", byt[i]]];
    }
    NSLog(@"[Receive]:%@", str);
    //
    
    NSLog(@"characteristic.value.length(%d)", len);
    
    //[Decode]
}
#endif

#pragma mark --TableView
- (void)addOneCell:(NSString *)title Subtitle:(NSString *)subtitle {
    if (title && subtitle) {
        NSLog(@"addOneCell:(%@) :(%@)", title, subtitle);
        [titleArray addObject:title];
        [subtitleArray addObject:subtitle];

//        [self.myTableView beginUpdates];
//        //[titleArray insertObject:@"new" atIndex:0];
//        NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:titleArray.count-1 inSection:0]];
//        [self.myTableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationNone];
//        [self.myTableView endUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }
}

- (void)removeAllCell {
    [titleArray removeAllObjects];
    [subtitleArray removeAllObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"\n～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～");
//    NSLog(@"\n\nnumberOfSectionsInTableView");
//    NSLog(@"didConnectPeripheral.services.count(%ld)", didConnectPeripheral.services.count);

//    if (didConnectPeripheral.services.count < 1) {
//        return 1;
//    }
//    return didConnectPeripheral.services.count;
    
    return 1;

}

#if 1
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSLog(@"\n\n11111111111111111111111111111111111111111111111111111111111");
//    NSLog(@"\n\ntitleForHeaderInSection");
//    NSLog(@"titleForHeaderInSection:section(%ld)", section);
#if 0
    switch (section) {
//        case 0:
//            //Wait to connect
//            if (didConnectPeripheral.services.count < 1) {
//                return @"Device Name";
//            }
        default:
            //Wait to connect
            if (didConnectPeripheral.services.count < 1) {
                return @"Device Name";
            }
            NSLog(@"didConnectPeripheral.services[%ld].UUID(%@)", section, [NSString stringWithFormat:@"%@", didConnectPeripheral.services[section].UUID]);
            return [NSString stringWithFormat:@"%@", didConnectPeripheral.services[section].UUID];
            break;
    }
#else
    return @"Service Name";
#endif
}
#endif

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"\n\nnumberOfRowsInSection");

//    NSLog(@"\n\n222222222222222222222222222222222222222222222222222222222222");
//    NSLog(@"numberOfRowsInSection:section(%ld)", section);

//    switch (section) {
////        case 0:
////            //Wait to connect
////            if (didConnectPeripheral.services.count < 1) {
////                //NSLog(@"titleArray count(%lu)", titleArray.count);
////                return titleArray.count;
////            }
//        default:
//            //Wait to connect
//            if (didConnectPeripheral.services.count < 1) {
//                //NSLog(@"titleArray count(%lu)", titleArray.count);
//                return titleArray.count;
//            }
//            return didConnectPeripheral.services[section].characteristics.count;
//            break;
//    }
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"\n\n333333333333333333333333333333333333333333333333333333333333");
//    NSLog(@"cellForRowAtIndexPath:indexPath.row(%ld)", indexPath.row);
//    NSLog(@"titleArray.count(%ld)", titleArray.count);
//    NSLog(@"titleIndex(%d)", titleIndex);
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
#if 1
    if ([lbStatus.text  isEqual: STATUS_SELECT_CHARACTERISTICS]) {
        if(indexPath.row == 0){
            titleIndexEnd = titleArray.count;
//            NSLog(@"titleIndexEnd(%d)", titleIndexEnd);
        }
        //if (titleIndex < titleIndexEnd) {
//        NSLog(@"\n\n333333333333333333333333333333333333333333333333333333333333");
//        NSLog(@"indexPath.row(%ld)", indexPath.row);
//        NSLog(@"titleIndex(%d)", titleIndex);

        if (indexPath.row == titleIndex) {
//            NSLog(@"\n\n44444444444444444444444444444444444444444444444444444444");
            //NSLog(@"indexPath.row(%ld)", indexPath.row);
            //NSLog(@"titleIndex(%d)", titleIndex);
//            NSLog(@"[titleArray objectAtIndex:titleIndex](%@)", [titleArray objectAtIndex:titleIndex]);
//            NSLog(@"[subtitleArray objectAtIndex:titleIndex](%@)", [subtitleArray objectAtIndex:titleIndex]);
            cell.textLabel.text = [titleArray objectAtIndex:titleIndex];
            //cell.textLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [subtitleArray objectAtIndex:titleIndex];
            titleIndex++;
        }
     }
    else {
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    }
#else
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
#endif
    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    return cell;
}

//UITableViewCell click event
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"[TableViewCell Click]: index(%ld)", indexPath.row);
    if ([lbStatus.text  isEqual: STATUS_SELECT_CONNECT_TO]) {
        NSLog(@"[Stop Scan]");
        [CM stopScan];
#ifndef TY_BLE_DEVICE
        needConnectPeripheral = [discoveryPeripheralList objectAtIndex:indexPath.row];
#endif
        //NSLog(@"needConnectPeripheral(%@)", needConnectPeripheral.name);
        NSLog(@"[Connect To]: %@",needConnectPeripheral.name);
        [CM connectPeripheral:needConnectPeripheral options:nil];
    }
    else if ([lbStatus.text isEqual: STATUS_SELECT_CHARACTERISTICS]) {
        if ([titleArray[indexPath.row] isEqual: TY_UUID_WRITE]) {
            [self performSegueWithIdentifier:@"ToDetail" sender:self];
        }
        if ([titleArray[indexPath.row] isEqual: TY_UUID_READ]) {
            [self performSegueWithIdentifier:@"ToReadView" sender:self];
        }

    }
    else {
        //Stop Search
        [self scanStop];
        NSLog(@"[Stop Scan]");
//        NSLog(@"[Stop Scan]");
//        [CM stopScan];
    }
}

#pragma mark --Event
//================================================================================
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RWViewController *view = segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"ToDetail"])
    {
        view.characteristic_write = mainToRW_characteristic_write;
        view.characteristic_read = mainToRW_characteristic_read;
        view.didConnectPeripheral = didConnectPeripheral;
        view.didConnectCentral = mainToRW_Central;
    }
    if ([[segue identifier] isEqualToString:@"ToReadView"])
    {
        //view.characteristic_write = mainToRW_characteristic_write;
        view.characteristic_read = mainToRW_characteristic_read;
        view.didConnectPeripheral = didConnectPeripheral;
        view.didConnectCentral = mainToRW_Central;
    }

}

//================================================================================
- (IBAction)btnTest:(id)sender {
    NSLog(@"[Button Click]:%@", @"btnTest");
    //[self addOneCell:@"Test" Subtitle:@"Test"];
    [self performSegueWithIdentifier:@"ToReadView" sender:self];
#if 0
    //BYTE byDataBuf[] = {160, 160, 16, 16, 0, 1, 0, 1, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};//, 21, 22, 23, 24, 25, 26, 27, 28, 29};
    BYTE byDataBuf[] = {3, 1, 2};
    NSData *valData = [NSData dataWithBytes:byDataBuf length:3];
    //Send - Write
    NSLog(@"%@",@"-----[send]");
    [didConnectPeripheral writeValue:valData forCharacteristic:mainToRW_characteristic_write type:CBCharacteristicWriteWithResponse];
#endif
}

//================================================================================
- (IBAction)btnDiscover:(id)sender {
    NSLog(@"[Button Click]:%@", @"btnDiscover");
#if 1
    if ([btnDiscover.titleLabel.text isEqual: SCAN_START]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [btnDiscover setTitle:SCAN_STOP forState:UIControlStateNormal];
        });

        //Search Device
        [self scanDevice];
        
        //NSLog(@"%@", SCAN_STOP);
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [btnDiscover setTitle:SCAN_START forState:UIControlStateNormal];
        });
        
        //Stop Search
        [self scanStop];
        
        //NSLog(@"%@", SEARCH_START);
    }
#else
    [self performSegueWithIdentifier:@"ToDetail" sender:self];
#endif
}
#pragma mark --Sub Function
//================================================================================
- (void)scanDevice {
    NSLog(@"--scanDevice");
    [self removeAllCell];
    [self reflashStatus:STATUS_SELECT_CONNECT_TO];
    [CM stopScan];
    [CM scanForPeripheralsWithServices:nil options:nil];
}

//================================================================================
- (void)scanStop {
    NSLog(@"--scanStop");
    [self reflashStatus:STATUS_SELECT_CONNECT_TO];
    [CM stopScan];
    if (didConnectPeripheral.state == CBPeripheralStateConnected) {
        [CM cancelPeripheralConnection:didConnectPeripheral];
    }
}

//================================================================================
- (void)reflashStatus:(NSString *)str {
    dispatch_async(dispatch_get_main_queue(), ^{
        lbStatus.text = str;
    });
}

//#pragma mark --AVANT BT Module
//================================================================================
//- (bool)sendKeyboardCode:(NSString *)nsStr {
//    NSLog(@"[Function]--> getKeyboardCode:");
//    NSLog(@"nsStr(%@)", nsStr);
//
//    NSData *nsData = [nsStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    //NSString *newString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    uint len = (int)nsData.length;
//    if ((len == 0)||(len > FLASH_SUB_BLOCK_NUMBER)) {
//        return false;
//    }
//    //[Send valid in Block]
//    NSLog(@"\n\n[Send valid in Block]");
//    BYTE sblk[] = { 0, 0, 0, 0};
//    uint lastLen = len - 2;
//    sblk[0] = lastLen;
//    sblk[1] = lastLen >> 8;
//    sblk[2] = lastLen >> 16;
//    sblk[3] = lastLen >> 24;
//    NSLog(@"sblk[3]= %x", sblk[3]);
//    NSLog(@"sblk[2]= %x", sblk[2]);
//    NSLog(@"sblk[1]= %x", sblk[1]);
//    NSLog(@"sblk[0]= %x", sblk[0]);
//
//    Byte *ascBytArray = (Byte *)malloc(len);
//    //Byte *kbBytArray = (Byte *)malloc(len);
//    //Byte *bytCmd = (Byte *)malloc(4);
//    //BYTE bytCmd;
//    //NSData *nsdDataBuf;
//    [nsData getBytes:ascBytArray];
//    for (UInt32 i = 0; i < len; i++) {
//        BYTE ascByt = *(ascBytArray + i);
//        NSLog(@"\n\nascBytArray[%d]= %x", i, *(ascBytArray + i));
//
////        BYTE bbb;
////        if (i>=16) {
////            bbb = ascByt;
////        }
//        BYTE tmpkbByt[] = { 3, 1, 0, 0};
//        if ((ascByt >= ASCII_0) && (ascByt <= ASCII_9)){
//            (ascByt != ASCII_0) ? (tmpkbByt[3] = ascByt - 19):(tmpkbByt[3] = ASCII_0);
//        }
//        else if (((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)) || ((ascByt >= ASCII_a) && (ascByt <= ASCII_z))){
//            if ((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)) {
//                tmpkbByt[2] = MODIFY_KEY_SHIFT;
//            }
//            tmpkbByt[3] = ascByt - 61;
//        }
//        //@
//        else if (ascByt == ASCII_AT){
//            tmpkbByt[2] = MODIFY_KEY_SHIFT;
//            tmpkbByt[3] = KEYBOARD_CODE_AT;
//        }
//        //.
//        else if (ascByt == ASCII_DOT){
//            tmpkbByt[3] = KEYBOARD_CODE_DOT;
//        }
//        //Special Sign
//        else if (ascByt == ASCII_SIGN){
//            i++;
//            ascByt = *(ascBytArray + i);
//            if (ascByt == ASCII_TAB) {
//                tmpkbByt[3] = KEYBOARD_CODE_TAB;
//                i += 3;  //[tab]
//            }
//            else if(ascByt == ASCII_ENTER) {
//                tmpkbByt[3] = KEYBOARD_CODE_ENTER;
//                i += 5;  //[enter]
//            }
//            else {
//                return false;
//            }
//        }
//        else {
//            return false;
//        }
//        //[self asc2KeycodeCmd:byt SubBlock:bytCmd];
//        NSLog(@"tmpkbByt[0]= %x", *(tmpkbByt + 0));
//        NSLog(@"tmpkbByt[1]= %x", *(tmpkbByt + 1));
//        NSLog(@"tmpkbByt[2]= %x", *(tmpkbByt + 2));
//        NSLog(@"tmpkbByt[3]= %x", *(tmpkbByt + 3));
//        NSData *nsdCmd;
//        [nsdCmd getBytes:tmpkbByt];
//    }
////    byt[0] = *(kbBytArray + 0);
////    byt[1] = *(kbBytArray + 1);
////    byt[2] = *(kbBytArray + 2);
//    
//    return true;
//}

//================================================================================
//AVANT uart command
//ASCII(byte) to BLE Keyboard Code(byte)
//- (bool)asc2KeycodeCmd:(Byte)ascByt SubBlock:(Byte *)kbByt{
//    //BYTE *ascBytArray = (BYTE *)malloc(4);
//    BYTE tmpkbByt[] = { 3, 1, 0, 0};
//    if ((ascByt >= ASCII_0) && (ascByt <= ASCII_9)){
//        (ascByt != ASCII_0) ? (tmpkbByt[3] = ascByt - 19):(tmpkbByt[3] = ASCII_0);
//    }
//    else if (((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)) || ((ascByt >= ASCII_a) && (ascByt <= ASCII_z))){
//        if ((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)) {
//            tmpkbByt[2] = MODIFY_KEY_SHIFT;
//        }
//        tmpkbByt[3] = ascByt - 61;
//    }
//    else {
//    }
//    kbByt = &tmpkbByt;
//    
//    return true;
//}

#pragma mark --Type Convert Function
//================================================================================
//Search in the array
//true: String is exist in array
//false: String is't exist in array
- (bool)searchInArray:(NSMutableArray *)array key:(NSString *)str {
    //NSDictionary *resultDic = nil;
    for(NSString *obj in array){
        if([obj isEqualToString:str] ){
            return true;
        }
    }
    return false;
}

//================================================================================
//NSData(byte) to NSString
- (NSString *)nsData2Str_byte:(NSData *)nsData {
    int len = (int)nsData.length;
    Byte *byt = (Byte*)malloc(len);
    memcpy(byt, [nsData bytes], len);
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];;
    for (UInt8 i=0; i<len; i++) {
        [str appendString:[NSString stringWithFormat:@"%02x,", byt[i]]];
    }
    //free(byt);
    return str;
}

//================================================================================
//NSString(Decimal) to Byte array
- (Byte *)str2Byte_Decimal:(NSString *)iStr {
    NSArray *stringArray = [iStr componentsSeparatedByString: @","];
    int len = (int)stringArray.count;
    //BYTE byt[20];
    Byte *byt = (Byte*)malloc(len);
    uint32_t singleNumber = 0;
    for (int i = 0; i<stringArray.count; i++) {
        //sscanf(stringArray[i], "%x", &singleNumber);
        singleNumber = [stringArray[i] intValue];
        uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
        byt[i] = (Byte)tmp;
    }
    //free(byt);
    return byt;
}

@end
