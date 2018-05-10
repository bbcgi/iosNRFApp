//
//  RWViewController.m
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/11/25.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import "RWViewController.h"

@interface RWViewController ()
{
}

@end

@implementation RWViewController

@synthesize swHex;
@synthesize tvWrtDly;
@synthesize tvData;
@synthesize tvMsg;
@synthesize tvBlkNo;
@synthesize btnTab;
@synthesize btnEnter;
@synthesize btnMsgClr;
@synthesize btnWork;
@synthesize btnIdle;
@synthesize btnWrt;

@synthesize characteristic_write;
@synthesize characteristic_read;
@synthesize device_mode;
@synthesize didConnectPeripheral;
@synthesize didConnectCentral;

//================================================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[UI Initiallize]
    [self init_UI];
     
    //[BT Initiallize]
    //[self init_BT];
}

//================================================================================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --Sub Function
//================================================================================
- (void)init_UI {
    //[UI Initiallize]
    self.title = [NSString stringWithFormat:@"%@", characteristic_write.UUID];
    //[self setMode:MODE_WORK];
    //[self textViewMSG_Clear];
    //[self textViewMSG_Display:[NSString stringWithFormat:@"[%@]", didConnectPeripheral.name]];
}

//================================================================================
- (void)init_BT {
    NSLog(@"didConnectPeripheral.name: %@", didConnectPeripheral.name);
    NSLog(@"characteristic_read.name: %@", characteristic_read.UUID);
    //[set receive notify]
    //if (characteristic_read) {
        [didConnectPeripheral setNotifyValue:YES forCharacteristic:characteristic_read];
    //}
}

#pragma mark --BlueTooth centralManager
//-(void)centralManagerDidUpdateState:(CBCentralManager*)cManager
//{
//    NSMutableString* nsmstring=[NSMutableString stringWithString:@"UpdateState:"];
//    BOOL isWork=FALSE;
//    switch (cManager.state) {
//        case CBCentralManagerStateUnknown:
//            [nsmstring appendString:@"Unknown\n"];
//            break;
//        case CBCentralManagerStateUnsupported:
//            [nsmstring appendString:@"Unsupported\n"];
//            break;
//        case CBCentralManagerStateUnauthorized:
//            [nsmstring appendString:@"Unauthorized\n"];
//            break;
//        case CBCentralManagerStateResetting:
//            [nsmstring appendString:@"Resetting\n"];
//            break;
//        case CBCentralManagerStatePoweredOff:
//            [nsmstring appendString:@"PoweredOff\n"];
//            break;
//        case CBCentralManagerStatePoweredOn:
//            [nsmstring appendString:@"PoweredOn\n"];
//            isWork=TRUE;
//            
//            //Ray BLE
//            //[self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:KServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
//            
//            break;
//        default:
//            [nsmstring appendString:@"none\n"];
//            break;
//    }
//    NSLog(@"%@",nsmstring);
//}

#pragma mark --BlueTooth peripheral
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


#pragma mark --UI Control
//================================================================================
//- (void)setMode:(NSString*)mode
//{
//    device_mode = mode;
//    if ([mode isEqual: MODE_WORK]) {
//        [self.bntWork setHighlighted:true];
//        [self.bntWork setHighlighted:false];
//        [self.bntWork setHighlighted:false];
//    }
//    else if ([mode isEqual: MODE_WAIT]) {
//        [self.bntWork setHighlighted:false];
//        [self.bntWork setHighlighted:true];
//        [self.bntWork setHighlighted:false];
//    }
//    else { //MODE_IDLE
//        [self.bntWork setHighlighted:false];
//        [self.bntWork setHighlighted:false];
//        [self.bntWork setHighlighted:true];
//    }
//}

//================================================================================
- (void)textViewData_Add:(NSString *)nssMessage
{
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *nssText = [[self tvData] text];
    [[self tvData] setText:[nssText stringByAppendingFormat:@"%@", nssMessage]];
    [[self tvData] scrollRangeToVisible:NSMakeRange([[[self tvData] text] length], 0)];
    //});
}

//================================================================================
- (void)textViewData_Display:(NSString *)nssMessage
{
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *nssText = [[self tvData] text];
    [[self tvData] setText:[nssText stringByAppendingFormat:@"\r%@", nssMessage]];
    [[self tvData] scrollRangeToVisible:NSMakeRange([[[self tvData] text] length], 0)];
    //});
}

//================================================================================
- (void)textViewData_Clear
{
    //dispatch_async(dispatch_get_main_queue(), ^{
        [[self tvData] setText:@""];
    //});
}

//================================================================================
- (void)textViewMsg_Display:(NSString *)nssMessage
{
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *nssText = [[self tvMsg] text];
    [[self tvMsg] setText:[nssText stringByAppendingFormat:@"\r%@", nssMessage]];
    [[self tvMsg] scrollRangeToVisible:NSMakeRange([[[self tvMsg] text] length], 0)];
    //});
}

//================================================================================
- (void)textViewMsg_Clear
{
    //dispatch_async(dispatch_get_main_queue(), ^{
        [[self tvMsg] setText:@""];
    //});
}

#pragma mark --Sub Function
//================================================================================

#pragma mark --Event
//================================================================================
- (IBAction)btnWork:(id)sender {
    [self sendSetWork];
}

//================================================================================
- (IBAction)btnIdle:(id)sender {
    if (![tvBlkNo.text  isEqual: @""]) {
        [self sendSetIdle:[tvBlkNo.text integerValue]];
    }
}

//================================================================================
- (IBAction)btnWrt:(id)sender {
    //Keyboard disable
    [tvData resignFirstResponder];

    NSLog(@"%@",@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //NSLog(@"[Send]-->%@", tfWrtData.text);
    
    //[Send Write]
    NSString *iStr = tvData.text;
    if(swHex.on) {
        //[Hex Mode]
        NSLog(@"[Hex Mode]");
        NSArray *stringArray = [iStr componentsSeparatedByString: @","];
        int len = (int)stringArray.count;
        Byte *byt = (Byte *)malloc(len);
        byt = [self str2Byte_Decimal:iStr];
        NSData *valData = [NSData dataWithBytes:byt length:len];
        [didConnectPeripheral writeValue:valData forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
        [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %@", tvData.text]];
    }
    else {
        //[String Mode]
        NSLog(@"[String OFF]");
        
#ifdef TY_BT_VERSION1
        [self sendWriteDataVer1:iStr];
#endif
#ifdef TY_BT_VERSION2
        [self sendWriteDataVer2:iStr];
#endif
        
    }
    
#if 0
    //[Delay]
    [NSThread sleepForTimeInterval:DELAY_FOR_RECEIVE];
    
    //[Receive Write]
    NSString *str = [self nsData2Str_byte:characteristic_read.value];
    [self textViewMSG_Display:@"[Receive]<--"];
    [self textViewMSG_Display:str];
    NSLog(@"%@",@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    NSLog(@"[Receive]<--%@", str);
#endif
    
#if 0
    BYTE byDataBuf[] = {160, 160, 16, 16, 0, 1, 0, 1, 4, 3, 2, 1, 5, 6, 7, 8, 9, 10, 11, 12};
    //NSData *valData = [NSData dataWithBytes:byDataBuf length:sizeof(byDataBuf)];
    NSData *valData = [NSData dataWithBytes:byDataBuf length:20];
    //Send Write
    [didConnectPeripheral writeValue:valData forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
#endif
}


//================================================================================
- (IBAction)btnTab:(id)sender {
    [self textViewData_Add:KEYBOARD_STRING_TAB];
}

//================================================================================
- (IBAction)btnEnter:(id)sender {
    [self textViewData_Add:KEYBOARD_STRING_ENTER];
}

//================================================================================
- (IBAction)btnMsgClr:(id)sender {
    [self textViewMsg_Clear];
}

//================================================================================
- (IBAction)swHex:(id)sender {
    if(swHex.on) {
        //[Switch ON]
        [tvData setText:TEXTVIEW_HEX];
    }
    else {
        //[Switch OFF]
        [tvData setText:TEXTVIEW_STRING];
    }
}

//================================================================================
- (IBAction)btnDataClr:(id)sender {
    [self textViewData_Clear];
}

/*--------------------------------------------------------------*/
#pragma mark --AVANT BT Module
/*--------------------------------------------------------------*/

//===============================================================
- (bool)sendWriteDataVer1:(NSString *)nsStr {
    NSLog(@"[Function]--> sendWriteDataVer1:%@", nsStr);
    
    NSData *nsData = [nsStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSString *newString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    UInt16 len = (int)nsData.length;
    if ((len == 0)||(len > FLASH_SUB_BLOCK_NUMBER)) {
        return false;
    }
    NSLog(@"len(%d)", len);

    UInt16 cnt;
    
    //[Send valid in Block]
    NSLog(@"\n\n[Send valid in Block]");
    BYTE sblk[] = { 0, 0, 0, 0};
    uint dataLen = len;// - 10;//10:[tab] and [enter]
    
    //[check tab]
    if ([self checkStringExisted:nsStr target:KEYBOARD_STRING_TAB]) {
        dataLen -= 4;
    }
    
    //[check tab]
    if ([self checkStringExisted:nsStr target:KEYBOARD_STRING_ENTER]) {
        dataLen -= 6;
    }
    
    sblk[0] = dataLen;
    sblk[1] = dataLen >> 8;
    sblk[2] = dataLen >> 16;
    sblk[3] = dataLen >> 24;
    
    NSLog(@"sblk[3]= %x", sblk[3]);
    NSLog(@"sblk[2]= %x", sblk[2]);
    NSLog(@"sblk[1]= %x", sblk[1]);
    NSLog(@"sblk[0]= %x", sblk[0]);
    
    //Byte *kbBytArray = (Byte *)malloc(len);
    //Byte *bytCmd = (Byte *)malloc(4);
    //BYTE bytCmd;

    NSData *sblk0Data = [NSData dataWithBytes:sblk length:FLASH_SUB_BLOCK_SIZE];
    [didConnectPeripheral writeValue:sblk0Data forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    cnt++;
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", sblk[0], sblk[1], sblk[2], sblk[3]]];
    
    Byte *ascBytArray = (Byte *)malloc(len);
    [nsData getBytes:ascBytArray length:len];
    for (UInt32 i = 0; i < len; i++) {
        BYTE ascByt = *(ascBytArray + i);
        NSLog(@"\n\nascBytArray[%d]= %x", i, *(ascBytArray + i));
        BYTE tmpkbByt[] = { 3, 1, 0, 0};
        if ((ascByt >= ASCII_0) && (ascByt <= ASCII_9)){
            (ascByt != ASCII_0) ? (tmpkbByt[3] = ascByt - 19):(tmpkbByt[3] = KEYBOARD_CODE_0);
        }
        //A~Z
        else if ((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)){
            tmpkbByt[2] = MODIFY_KEY_SHIFT;
            tmpkbByt[3] = ascByt - ASCII_A_TO_KB_A;
        }
        //a~z
        else if ((ascByt >= ASCII_a) && (ascByt <= ASCII_z)){
            tmpkbByt[3] = ascByt - ASCII_a_TO_KB_a;
        }
        //@
        else if (ascByt == ASCII_AT){
            tmpkbByt[2] = MODIFY_KEY_SHIFT;
            tmpkbByt[3] = KEYBOARD_CODE_AT;
        }
        //.
        else if (ascByt == ASCII_DOT){
            tmpkbByt[3] = KEYBOARD_CODE_DOT;
        }
        //[ Special Sign
        else if (ascByt == ASCII_SIGN){
            i++;
            ascByt = *(ascBytArray + i);
            if (ascByt == ASCII_TAB) {
                tmpkbByt[3] = KEYBOARD_CODE_TAB;
                i += 3;  //[tab]
            }
            else if(ascByt == ASCII_ENTER) {
                tmpkbByt[3] = KEYBOARD_CODE_ENTER;
                i += 5;  //[enter]
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
        //[self asc2KeycodeCmd:byt SubBlock:bytCmd];

        NSLog(@"tmpkbByt[0]= %x", *(tmpkbByt + 0));
        NSLog(@"tmpkbByt[1]= %x", *(tmpkbByt + 1));
        NSLog(@"tmpkbByt[2]= %x", *(tmpkbByt + 2));
        NSLog(@"tmpkbByt[3]= %x", *(tmpkbByt + 3));
        
        NSData *sblkData = [NSData dataWithBytes:tmpkbByt length:FLASH_SUB_BLOCK_SIZE];
        [didConnectPeripheral writeValue:sblkData forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
        cnt++;
        [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", *(tmpkbByt + 0), *(tmpkbByt + 1), *(tmpkbByt + 2), *(tmpkbByt + 3)]];
//        NSString *iStr = tvWrtDly.text;
//        double value = [iStr doubleValue];
        //[NSThread sleepForTimeInterval:DELAY_FOR_NEXT_WRITE];
        [NSThread sleepForTimeInterval:[tvWrtDly.text doubleValue]];
    }
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send Count]--> %d", cnt]];

    return true;
}

//===============================================================
- (bool)sendWriteDataVer2:(NSString *)nsStr {
    NSLog(@"[Function]--> sendWriteDataVer2:%@", nsStr);
    
    //Check over sub block
    NSData *nsData = [nsStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    UInt16 len = (int)nsData.length;
    NSLog(@"len(%d)", len);
    if ((len == 0)||(len > FLASH_SUB_BLOCK_NUMBER)) {
        return false;
    }
    
    //Check over block number
    uint dataLen = len;
    dataLen -= [self getTabEnterLengthDifference:nsStr];
    UInt8 blkNo = [tvBlkNo.text integerValue];
    if (blkNo > FLASH_BLOCK_NUMBER_MAX) {
        return false;
    }

    UInt16 cnt;
    BYTE checksum[] = { 0, 0, 0, 0};

    //[TY BLE Protocol - Write Data]
    NSLog(@"\n\n[TY BLE Protocol - Write Data]");

    //[Step1] - Command
    //Send length(1B) + Write cmd (1B) + Random(2B)
    NSLog(@"\n\n[Step1] - Command");
    BYTE cmd[] = { TY_BT_CMD_LEN, TY_BT_CMD_WRITE, arc4random() % 16, arc4random() % 16};
    //NSData *nsdCmd = [NSData dataWithBytes:cmd length:TY_BT_CMD_LEN];
    [didConnectPeripheral writeValue:[NSData dataWithBytes:cmd length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    cnt++;
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]]];
    NSLog(@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]);
    [self checkSumAdd:checksum buffer:cmd length:TY_BT_CMD_LEN];
    NSLog(@"[checksum]--> %x,%x,%x,%x", checksum[0], checksum[1], checksum[2], checksum[3]);
    
    //[Step2] - Information
    //Send length(1B) + BLK number(1B) + Vaild length(1B) + Random(1B)
    NSLog(@"\n\n[Step2] - Information");
    BYTE info[] = { TY_BT_CMD_LEN, [tvBlkNo.text integerValue], dataLen, arc4random() % 16};
    [didConnectPeripheral writeValue:[NSData dataWithBytes:info length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    cnt++;
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", info[0], info[1], info[2], info[3]]];
    NSLog(@"[Send]--> %x,%x,%x,%x", info[0], info[1], info[2], info[3]);
    [self checkSumAdd:checksum buffer:info length:TY_BT_CMD_LEN];
    NSLog(@"[checksum]--> %x,%x,%x,%x", checksum[0], checksum[1], checksum[2], checksum[3]);
    
    //[Step3] - Data1~DataN
    //Send length(1B) + Modify key(1B) + Keyboard code(1B) + Random(1B)
    NSLog(@"\n\n[Step3] - Data1~DataN");
    Byte *ascBytArray = (Byte *)malloc(len);
    [nsData getBytes:ascBytArray length:len];
    for (UInt32 i = 0; i < len; i++) {
        BYTE ascByt = *(ascBytArray + i);
        NSLog(@"\n\nascBytArray[%d]= %x", i, *(ascBytArray + i));
        BYTE data[] = { TY_BT_CMD_LEN, 0, 0, arc4random() % 16};
        if ((ascByt >= ASCII_0) && (ascByt <= ASCII_9)){
            (ascByt != ASCII_0) ? (data[2] = ascByt - 19):(data[2] = KEYBOARD_CODE_0);
        }
        //A~Z
        else if ((ascByt >= ASCII_A) && (ascByt <= ASCII_Z)){
            data[1] = MODIFY_KEY_SHIFT;
            data[2] = ascByt - ASCII_A_TO_KB_A;
        }
        //a~z
        else if ((ascByt >= ASCII_a) && (ascByt <= ASCII_z)){
            data[2] = ascByt - ASCII_a_TO_KB_a;
        }
        //@
        else if (ascByt == ASCII_AT){
            data[1] = MODIFY_KEY_SHIFT;
            data[2] = KEYBOARD_CODE_AT;
        }
        //.
        else if (ascByt == ASCII_DOT){
            data[2] = KEYBOARD_CODE_DOT;
        }
        //[ Special Sign
        else if (ascByt == ASCII_SIGN){
            i++;
            ascByt = *(ascBytArray + i);
            if (ascByt == ASCII_TAB) {
                data[2] = KEYBOARD_CODE_TAB;
                i += 3;  //[tab]
            }
            else if(ascByt == ASCII_ENTER) {
                data[2] = KEYBOARD_CODE_ENTER;
                i += 5;  //[enter]
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
        
//        NSLog(@"tmpkbByt[0]= %x", *(tmpkbByt + 0));
//        NSLog(@"tmpkbByt[1]= %x", *(tmpkbByt + 1));
//        NSLog(@"tmpkbByt[2]= %x", *(tmpkbByt + 2));
//        NSLog(@"tmpkbByt[3]= %x", *(tmpkbByt + 3));
        
        [didConnectPeripheral writeValue:[NSData dataWithBytes:data length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
        cnt++;
        [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", *(data + 0), *(data + 1), *(data + 2), *(data + 3)]];
        NSLog(@"[Send]--> %x,%x,%x,%x", *(data + 0), *(data + 1), *(data + 2), *(data + 3));
        [self checkSumAdd:checksum buffer:data length:TY_BT_CMD_LEN];
        NSLog(@"[checksum]--> %x,%x,%x,%x", checksum[0], checksum[1], checksum[2], checksum[3]);
        
        [NSThread sleepForTimeInterval:[tvWrtDly.text doubleValue]];
    }
    
    //[Step4] - Check Sum(8 bits)
    //Send length(1B) + Check Sum1(1B) + Check Sum2(1B) + Check Sum3(1B)
    //1's complement
    for (UInt8 i = 0; i < TY_BT_CMD_LEN; i++) {
        checksum[i] = 0xFF - checksum[i];
    }
    [didConnectPeripheral writeValue:[NSData dataWithBytes:checksum length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    cnt++;
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send Count]--> %d", cnt]];
    NSLog(@"[Send Count]--> %d", cnt);
    
    return true;
}

//===============================================================
- (bool)sendSetWork {
    NSLog(@"[Function]--> sendSetWork");
    
    //[TY BLE Protocol - Set Idle]
    NSLog(@"\n\n[TY BLE Protocol - Set Work]");
    
    //[Step1] - Command
    //Send length(1B) + Random(1B) + Set work cmd (2B)
    NSLog(@"\n\n[Step1] - Command");
    BYTE cmd[] = { TY_BT_CMD_LEN, arc4random() % 16, (BYTE)(TY_BT_CMD_WORK >> 8), (BYTE)TY_BT_CMD_WORK};
    [didConnectPeripheral writeValue:[NSData dataWithBytes:cmd length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]]];
    NSLog(@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]);
    
    return true;
}

//===============================================================
- (bool)sendSetIdle:(UInt8)blkNo {
    NSLog(@"[Function]--> sendSetIdle:%d", blkNo);
    
    //[TY BLE Protocol - Set Idle]
    NSLog(@"\n\n[TY BLE Protocol - Set Idle]");

    //[Step1] - Command
    //Send length(1B) + Block Number(1B) + Set Idle cmd(2B)
    NSLog(@"\n\n[Step1] - Command");
    BYTE cmd[] = { TY_BT_CMD_LEN, (BYTE)blkNo, (BYTE)(TY_BT_CMD_IDLE >> 8), (BYTE)TY_BT_CMD_IDLE};
    [didConnectPeripheral writeValue:[NSData dataWithBytes:cmd length:TY_BT_CMD_LEN] forCharacteristic:characteristic_write type:CBCharacteristicWriteWithResponse];
    [self textViewMsg_Display:[NSString stringWithFormat:@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]]];
    NSLog(@"[Send]--> %x,%x,%x,%x", cmd[0], cmd[1], cmd[2], cmd[3]);

    return true;
}

//================================================================================
- (uint)getTabEnterLengthDifference:(NSString *)nsStr {
    uint dataLen;
    
    //[check tab]
    if ([self checkStringExisted:nsStr target:KEYBOARD_STRING_TAB]) {
        dataLen += 4;
    }
    
    //[check tab]
    if ([self checkStringExisted:nsStr target:KEYBOARD_STRING_ENTER]) {
        dataLen += 6;
    }

    return dataLen;
}

//================================================================================
-(void)checkSumAdd:(Byte *)sum buffer:(Byte *)add length:(UInt8)len
{
    //Byte *byt = (Byte*)malloc(len);
    for (UInt8 i = 0; i < len; i++) {
        *(sum+i) += *(add+i);
    }
}

#pragma mark --[Tool] String Operation Function

//================================================================================
//check string exist?
- (Boolean)checkStringExisted:(NSString *)srcStr target:(NSString *)nsStr{
    NSRange search = [srcStr rangeOfString:nsStr];
    
    if (search.location < srcStr.length) {
        return true;
    }
    return false;
}

/*---------------------------------------------------------*/
#pragma mark --[Tool] Type Convert Function
/*---------------------------------------------------------*/

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
          
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
