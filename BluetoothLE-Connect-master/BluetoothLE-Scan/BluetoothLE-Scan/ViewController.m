//
//  ViewController.m
//  BluetoothLE-Connect
//
//  Created by danny on 2014/04/1.
//  Copyright (c) 2014年 danny. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    CBPeripheral *connectPeripheral;
}
@end

static NSString* const TYsrvUUID = @"CBCC36C7-CCD7-F636-62B7-AF4294E1E445";

@implementation ViewController

@synthesize CM;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CM= [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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



- (IBAction)buttonScanAndConnect:(id)sender {
    [CM stopScan];
    [CM scanForPeripheralsWithServices:nil options:nil];
    NSLog(@"Scan And Connect");
    
}

- (IBAction)buttonStop:(id)sender {
    
    [CM stopScan];
    NSLog(@"stopScan");
    
    if (connectPeripheral == NULL){
        NSLog(@"connectPeripheral == NULL");
        return;
    }
    
    if (connectPeripheral.state == CBPeripheralStateConnected) {
        [CM cancelPeripheralConnection:connectPeripheral];
        NSLog(@"disconnect-1");

    }
/*
    if ([connectPeripheral isConnected]) {
        [CM cancelPeripheralConnection:connectPeripheral];
        NSLog(@"disconnect-1");
    }
*/
}



- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    //Ray BLE
    NSLog(@"%@",@"111111111111111111111111111111111111111111111111111111111111");
    //NSLog(@"peripheral\n%@\n",peripheral);
    NSLog(@"advertisementData\n%@\n",advertisementData);
    NSLog(@"RSSI(%@)\n",RSSI);
//    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
//    NSLog(@"localName:%@",localName);
    
    NSLog(@"peripheral.name:(%@)",peripheral.name);
    if ([peripheral.name length] && [peripheral.name rangeOfString:@"TAIYUTA-BLE"].location != NSNotFound) {
//    if ([localName length] && [localName rangeOfString:@"DannySimpleBLE"].location != NSNotFound) {
        [CM stopScan];
        NSLog(@"stopScan");
        connectPeripheral = peripheral;
        [CM connectPeripheral:peripheral options:nil];
        NSLog(@"connect to(%@)",peripheral.name);
    }
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"%@",@"222222222222222222222222222222222222222222222222222222222222");
    NSLog(@"%@",@"[connected]");
    [peripheral setDelegate:self];
    //[peripheral discoverServices:@[[CBUUID UUIDWithString:TYsrvUUID]]];
    [peripheral discoverServices:nil];

}

//Ray BLE
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"%@",@"3333333333333333333333333333333333333333333333333333333333333333");

    if(error)
    {
        //self.console.text = [NSString stringWithFormat:@"%@\n%@ %@", self.console.text, @"Error discovering service: ", [error localizedDescription]];
        NSLog(@"Error discovering service: %@", [error localizedDescription]);
        //[self cleanup];
        return;
    }
    
    for(CBService *service in peripheral.services)
    {
        //self.console.text = [NSString stringWithFormat:@"%@\n%@ %@", self.console.text, @"Found service with UUID: ", service.UUID];
        NSLog(@"%@",@"44444444444444444444444444444444444444444444444444444444444444444");
        NSLog(@"Found service with UUID: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];

//        if([service.UUID isEqual:[CBUUID UUIDWithString:KServiceUUID]])
//        {
//            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:KCharacteristicReadableUUID]] forService:service];
//            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:KCharacteristicWriteableUUID]] forService:service];
//            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:KCharacteristicDataUUID]] forService:service];
//        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if(error)
    {
        //self.console.text = [NSString stringWithFormat:@"%@\n%@ %@", self.console.text, @"Error discovering characteristic: ", [error localizedDescription]];
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }
    
//    if([service.UUID isEqual:[CBUUID UUIDWithString:KServiceUUID]])
//    {
        for(CBCharacteristic *characteristic in service.characteristics)
        {
            //self.console.text = [NSString stringWithFormat:@"%@\n%@ %@", self.console.text, @"Discovered characteristic with UUID: ", characteristic.UUID];
            NSLog(@"Discovered characteristic with UUID: %@", characteristic.UUID);
            
//            if([characteristic.UUID isEqual:[CBUUID UUIDWithString:KCharacteristicReadableUUID]])
//            {
//                //self.console.text = [NSString stringWithFormat:@"%@\n%@", self.console.text, @"Discovered READABLE characteristic."];
//                NSLog(@"Discovered READABLE characteristic");
//                self.peripheralCharacteristic = characteristic;
//                [peripheral setNotifyValue:YES forCharacteristic:self.peripheralCharacteristic];
//            }
//            else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:KCharacteristicWriteableUUID]])
//            {
//                //self.console.text = [NSString stringWithFormat:@"%@\n%@", self.console.text, @"Discovered WRITEABLE characteristic."];
//                NSLog(@"Discovered WRITEABLE characteristic");
//                self.writebackCharacteristic = characteristic;
//                [peripheral setNotifyValue:YES forCharacteristic:self.writebackCharacteristic];
//            }
//            else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:KCharacteristicDataUUID]])
//            {
//                //self.console.text = [NSString stringWithFormat:@"%@\n%@", self.console.text, @"Discovered DATA characteristic."];
//                NSLog(@"Discovered DATA characteristic");
//                self.dataCharacteristic = characteristic;
//                [peripheral setNotifyValue:YES forCharacteristic:self.dataCharacteristic];
//            }
        }
//    }
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"%@",@"disconnect-2");
}

@end
