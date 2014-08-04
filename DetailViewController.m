//
//  DetailViewController.m
//  iActiviti
//
//  Created by Selcuk Turhan on 21.06.10.
//  Copyright 2010 own. All rights reserved.
//

#import "DetailViewController.h"



enum TableRowType 
{
	kDisplayAgeLabel = 0,
	kDisplayDateLabel,
	kDisplayLocationLabel,
	kDisplayCountryLabel,
	kDisplayAreaLabel,
	kDisplayActivityLabel,
	kDisplayGenderLabel,
	kDisplaySpeciesLabel,
	kDisplayInjuryLabel,
	kDisplayAddInfoLabel
};

#pragma GCC diagnostic ignored "-Wwarning-flag"
@implementation DetailViewController

@synthesize incident;
@synthesize sharkSpeciesToInfoUrl;


- (id) initWithIncident: (Incident *) aIncident andStyle: (UITableViewStyle) aTableViewStyle{
	if (self = [super initWithStyle:aTableViewStyle]) {
        self.incident = aIncident;
		sharkSpeciesToInfoUrl = [[NSMutableDictionary alloc] init];
		[sharkSpeciesToInfoUrl setObject:  [wikipediaURL stringByAppendingString: @"White_Shark"] forKey: @"White Shark"];
		[sharkSpeciesToInfoUrl setObject:  [wikipediaURL stringByAppendingString: @"Bull_Shark"]  forKey: @"Bull Shark"];
		[sharkSpeciesToInfoUrl setObject:  [wikipediaURL stringByAppendingString: @"Tiger_Shark"] forKey: @"Tiger Shark"];
	}
	return self;
}

- (void) loadView {
	[super loadView];
	self.navigationItem.title = @"Incident Details";
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0){
		return @"Incident Details";
	}
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

#pragma GCC diagnostic ignored "-Wwarning-flag"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellID] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	
	switch ([indexPath row])
	{
		case kDisplayAgeLabel:
			cell.textLabel.text = @"Age";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.age];
			break;
		case kDisplayDateLabel:
			cell.textLabel.text = @"Date";
			cell.detailTextLabel.text = [self optionalCharacterRequired: [Utilities getFormattedDate: incident.attackDate]];
			break;
		case kDisplayLocationLabel:
			cell.textLabel.text = @"Location";
            cell.detailTextLabel.text = [self optionalCharacterRequired:
                                         [[[[incident.location stringByAppendingString: [self whitespaceRequired:incident.location]] 
                                                    stringByAppendingString: incident.area]  
                                                                stringByAppendingString:[self whitespaceRequired: incident.area]]
                                                                    stringByAppendingString: incident.country]
                                         ];
			break;
		case kDisplayCountryLabel:
			cell.textLabel.text = @"Country";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.country];
			break;
		case kDisplayAreaLabel:
			cell.textLabel.text = @"Area";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.area];
			break;
		case kDisplayActivityLabel:
			cell.textLabel.text = @"Acitivity";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.activity];
			break;
		case kDisplayGenderLabel:
			cell.textLabel.text = @"Gender";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.sex];
			break;
		case kDisplaySpeciesLabel:
			cell.textLabel.text = @"Species";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.species];
			if(![cell.detailTextLabel.text isEqualToString: @"-"]){
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			break;
		case kDisplayInjuryLabel:
			cell.textLabel.text = @"Injury";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.injury];
			break;
		case kDisplayAddInfoLabel:
			cell.textLabel.text = @"Category";
			cell.detailTextLabel.text = [self optionalCharacterRequired: incident.addInfo];
			break;
	}	
	
	cell.textLabel.textAlignment = UITextAlignmentLeft;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLabel.numberOfLines = 0;
	cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.detailTextLabel.numberOfLines = 0;

	return cell;
}

- (NSString*) optionalCharacterRequired:(NSString*) string{
	return [self isEmpty:string] ? @"-" : string;
}

- (NSString*) whitespaceRequired:(NSString*) string{
	return [self isEmpty:string] ? @"" : @" ";
}

- (BOOL) isEmpty:(NSString*) string{
	return (string == nil || [string isEqualToString: @""]);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.row == 0) return 40.0f;
	if (indexPath.row == 1) return 40.0f;
	if (indexPath.row == 2) return 100.0f;
	if (indexPath.row == 3) return 40.0f;
	if (indexPath.row == 4) return 100.0f;
	if (indexPath.row == 5) return 100.0f;
	if (indexPath.row == 6) return 40.0f;
	if (indexPath.row == 7) return 80.0f;
	if (indexPath.row == 8) return 100.0f;
	if (indexPath.row == 9) return 40.0f;
	
	return 0.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(kDisplaySpeciesLabel == [indexPath row] && self.incident.species && ![self.incident.species isEqualToString: @""]){
		SharkWebViewController* webView = [[[SharkWebViewController alloc]initWithUrl: [self.sharkSpeciesToInfoUrl objectForKey:self.incident.species]]autorelease];
		[((UINavigationController*)self.parentViewController) pushViewController: webView animated: YES];
		 
	}
}





- (void)dealloc {
	[incident release];
    [super dealloc];
}


@end
