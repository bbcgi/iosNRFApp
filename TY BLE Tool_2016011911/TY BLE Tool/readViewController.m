//
//  readViewController.m
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/12/24.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import "readViewController.h"

@interface readViewController ()
{
    //Timer
    NSTimer *timer;
    
    //BT
    CBCentralManager *central;
    CBPeripheral *peripheral;
    CBMutableCharacteristic *characteristic;
    //CBCharacteristic *characteristic;
    
}

@end

@implementation readViewController

@synthesize characteristic_read;
@synthesize didConnectPeripheral;
@synthesize didConnectCentral;


@synthesize swHex;
@synthesize btnClr;
@synthesize tvMsg;


- (void)viewDidLoad {
    [super viewDidLoad];

    //[UI Initiallize]
    [self init_UI];
    
    //[BT Initiallize]
    [self init_BT];
    
    //[Timer Initiallize]
    timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_READ_INTERVAL
                                                target:self
                                              selector:@selector(readNotify)
                                              userInfo:nil
                                               repeats:YES];
}


- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[viewDidDisappear]");

    [timer invalidate];
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

#pragma mark --Sub Function
//================================================================================
- (void)init_UI {
    //[UI Initiallize]
    self.title = [NSString stringWithFormat:@"%@", characteristic_read.UUID];
    //[self setMode:MODE_WORK];
    //[self textViewMSG_Clear];
    //[self textViewMSG_Display:[NSString stringWithFormat:@"[%@]", didConnectPeripheral.name]];
}

//================================================================================
- (void)init_BT {
    NSLog(@"didConnectPeripheral.name: %@", didConnectPeripheral.name);
    NSLog(@"characteristic_read.name: %@", characteristic_read.UUID);
    central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    central = didConnectCentral;
    //[set receive notify]
    //if (characteristic_read) {
    peripheral = didConnectPeripheral;
    characteristic = characteristic_read;
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    //}

}

//================================================================================
- (void)readNotify {
    NSString *str1 = characteristic.value;

    if (characteristic.value != nil) {
        NSString *str = [self nsData2Str_byte:characteristic.value];
        
        NSLog(@"%@",@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        NSLog(@"[Receive]<--%@", str);
        
        [self textViewMsg_Add:[NSString stringWithFormat:@"[Receive]<--%@", str]];
        
        characteristic.value = nil;    }
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

            break;
        default:
            [nsmstring appendString:@"none\n"];
            break;
    }
    NSLog(@"%@",nsmstring);
}

#pragma mark --BlueTooth peripheral
#if 1
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@",@"didUpdateValueForCharacteristic");
    NSLog(@"%@",@"Ray     ***********************************************************************");
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
- (void)textViewMsg_Add:(NSString *)nssMessage
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
#pragma mark --Event
//================================================================================
- (IBAction)btnClr:(id)sender {
    [self textViewMsg_Clear];
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

@end
