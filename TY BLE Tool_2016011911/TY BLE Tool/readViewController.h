//
//  readViewController.h
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/12/24.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "mainViewController.h"


@interface readViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>


@property (weak, nonatomic) CBCharacteristic *characteristic_read;
@property (weak, nonatomic) CBPeripheral *didConnectPeripheral;
@property (nonatomic,strong) CBCentralManager *didConnectCentral;

@property (weak, nonatomic) IBOutlet UISwitch *swHex;
@property (weak, nonatomic) IBOutlet UIButton *btnClr;
@property (weak, nonatomic) IBOutlet UITextView *tvMsg;

@end
