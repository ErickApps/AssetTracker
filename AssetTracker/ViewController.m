//
//  ViewController.m
//  AssetTracker
//
//  Created by Erick Barbosa on 4/27/15.
//  Copyright (c) 2015 Erick_Barbosa. All rights reserved.
//

#import "ViewController.h"
#import "Track.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *assetNameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *macAddressField;
@property (weak, nonatomic) IBOutlet UITextField *costField;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialLabel;
@property (weak, nonatomic) IBOutlet UILabel *macAddessLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    Track *newRecord;
    newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Track" inManagedObjectContext:context];
    [newRecord setValue:self.assetNameField.text forKey:@"assetName"];
    [newRecord setValue: self.serialField.text forKey:@"serialNumber"];
    [newRecord setValue:self.macAddressField.text forKey:@"macAddress"];
    [newRecord setValue:self.costField.text forKey:@"cost"];
    
    
    NSError *error;
    [context save:&error];
    self.nameLabel.text = @"new record saved";
    [self cleaLabels];
    }
- (IBAction)track:(id)sender {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Track"  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(assetName = %@) OR (serialNumber = %@)OR (macAddress = %@)", self.assetNameField.text,self.serialField.text,self.macAddressField.text];
    
    
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    [self cleaLabels];
    
    if ([objects count] ==0)
    {
        self.nameLabel.text = @"No matches found";
    }
    else if ([objects count] >1){
        matches = objects[0];
        self.nameLabel.text = [NSString stringWithFormat:@"%lu matches found", (unsigned long)[objects count]];
    }
    else
    {
        matches = objects[0];
        self.nameLabel.text = [matches valueForKey:@"assetName"];
        self.serialLabel.text = [matches valueForKey:@"serialNumber"];
        self.macAddessLabel.text = [matches valueForKey:@"macAddress"];
        self.costLabel.text = [matches valueForKey:@"cost"];
        
        
    }
    }
-(void)cleaLabels{
    
    self.nameLabel.text = @"";
    self.serialLabel.text = @"";
    self.macAddessLabel.text = @"";
    self.costLabel.text = @"";
    
    self.serialField.text = @"";
    self.assetNameField.text = @"";
    self.macAddressField.text = @"";
    self.costField.text = @"";
}


@end
