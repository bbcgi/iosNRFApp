//
//  RWViewController.h
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/11/25.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "mainViewController.h"

//Process Control
#define TEXTVIEW_HEX                @"03,01,02"
#define TEXTVIEW_STRING             @"TYTT@tytt.com.tw[tab]123456[enter]"

//BT
#define SEND_BYTE_LENGTH_MAX        2
#define DELAY_FOR_RECEIVE           0.5
#define DELAY_FOR_NEXT_WRITE        0.1

#define MODE_WORK                   @"WORK"
#define MODE_WAIT                   @"WAIT"
#define MODE_IDLE                   @"IDLE"

@interface RWViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>

typedef uint8_t BYTE;

@property (weak, nonatomic) CBCharacteristic *characteristic_write;
@property (weak, nonatomic) CBCharacteristic *characteristic_read;
//@property (weak, nonatomic) NSString *characteristic_write_UUID;
//@property (weak, nonatomic) NSString *characteristic_read_UUID;

@property (weak, nonatomic) NSString *device_mode;
@property (weak, nonatomic) CBPeripheral *didConnectPeripheral;
@property (nonatomic,strong) CBCentralManager *didConnectCentral;

@property (weak, nonatomic) IBOutlet UISwitch *swHex;
@property (weak, nonatomic) IBOutlet UITextView *tvData;
@property (weak, nonatomic) IBOutlet UITextField *tvWrtDly;
@property (weak, nonatomic) IBOutlet UITextField *tvBlkNo;
@property (weak, nonatomic) IBOutlet UITextView *tvMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnMsgClr;
@property (weak, nonatomic) IBOutlet UIButton *btnTab;
@property (weak, nonatomic) IBOutlet UIButton *btnEnter;
@property (weak, nonatomic) IBOutlet UIButton *btnDataClr;
@property (weak, nonatomic) IBOutlet UIButton *btnWork;
@property (weak, nonatomic) IBOutlet UIButton *btnIdle;
@property (weak, nonatomic) IBOutlet UIButton *btnWrt;




@end
