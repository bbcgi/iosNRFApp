//
//  ViewController.h
//  TY BLE Tool
//
//  Created by 吳家炘 on 2015/11/5.
//  Copyright © 2015年 RayWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "RWViewController.h"

//Version Control
#define TY_BT_VERSION2
#ifndef TY_BT_VERSION1
#define TY_BT_VERSION2
#endif

//Timer
#define TIMER_READ_INTERVAL         0.1

//Process Control
#define TY_BT_AVANT
#ifndef TY_BT_AVANT
#define TY_BT_NORDIC
#endif

//TY BT Procotol
#define TY_BT_CMD_LEN               4
#define TY_BT_CMD_WRITE             0xC5
#define TY_BT_CMD_WORK              0xA34C
#define TY_BT_CMD_IDLE              0xF7DB


//FLASH MAP
#define FLASH_BLOCK_NUMBER_MAX      255

#define FLASH_BLOCK_SIZE            512
#define FLASH_SUB_BLOCK_SIZE        2
#define FLASH_SUB_BLOCK_NUMBER      FLASH_BLOCK_SIZE/FLASH_SUB_BLOCK_SIZE

//KEYBOARD CODE
#define KEYBOARD_STRING_TAB         @"[tab]"
#define KEYBOARD_STRING_ENTER       @"[enter]"

#define KEYBOARD_CODE_ENTER         40
#define KEYBOARD_CODE_TAB           43
#define KEYBOARD_CODE_AT            31  //@
#define KEYBOARD_CODE_DOT           55  //.
#define KEYBOARD_CODE_0             39  //0

//ASCII
#define ASCII_A_TO_KB_A             61
#define ASCII_a_TO_KB_a             93

#define ASCII_SIGN                  91  //[
#define ASCII_TAB                   116 //t
#define ASCII_ENTER                 101 //e
#define ASCII_AT                    64  //@
#define ASCII_DOT                   46  //.

#define ASCII_0                     48
#define ASCII_9                     57
#define ASCII_A                     65
#define ASCII_Z                     90
#define ASCII_a                     97
#define ASCII_z                     122

//BT
//#define TY_BLE_DEVICE                  @"TAIYUTA-BLE"
#ifdef TY_BT_AVANT
#define MODIFY_KEY_SHIFT                2
#define TY_UUID_SERVICE_FFF0            @"FFF0"
#define TY_UUID_WRITE                   @"FFF2"
#define TY_UUID_READ                    @"FFF1"
#endif
#ifdef TY_BT_NORDIC
#define TY_UUID_WRITE                   @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define TY_UUID_READ                    @"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
#endif
//#define TY_UUID_BLE                 @"CBCC36C7-CCD7-F636-62B7-AF4294E1E445"

//BUTTON
#define SCAN_START                      @"Scan Device"
#define SCAN_STOP                       @"Stop Scan"

//STATUS
#define STATUS_WATTING                  @"Waiting"
#define STATUS_SCAN_DEVICE              @"Scanning..."
#define STATUS_SELECT_CONNECT_TO        @"Select device to connect..."
#define STATUS_SELECT_CHARACTERISTICS   @"Select Characteristics"

typedef uint8_t     BYTE;


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnTest;
//@property (nonatomic,strong) CBCentralManager *CM;
@property (weak, nonatomic) IBOutlet UIButton *btnDiscover;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

