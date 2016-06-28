/* Copyright 2006-2015 by Chris Osborn <fozztexx@fozztexx.com>
 * http://insentricity.com/a.cl/243
 *
 * This file is part of detonator.
 *
 * detonator is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2.1, or (at your option) any later
 * version.
 *
 * detonator is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with detonator; see the file COPYING. If not see
 * <http://www.gnu.org/licenses/>.
 */

#import "Controller.h"
#import "Relay.h"
#import "RelayRow.h"

#include <string.h>

#define PAGE_INDEX	@"index"
#define PAGE_EDIT	@"edit"

@implementation Controller

-(CLString *) fireworks
{
  int i, j;
  Relay *aRelay;
  CLMutableString *mString;
  

  mString = [CLMutableString stringWithString:@"sudo fireworks"];
  for (i = 0; i < MAX_ROWS; i++)
    for (j = 0; j < MAX_COLS; j++) {
      aRelay = [Relay relayForColumn:j+1 row:i+1];
      if ([aRelay isOn])
	[mString appendFormat:@" %i", i + j * MAX_COLS];
    }

  [mString appendString:@" &"];
  system([mString UTF8String]);
  return mString;
}

-(CLBlock *) relayRows
{
  CLBlock *aBlock;
  Relay *aRelay;
  int i, j;


  aBlock = [[CLBlock alloc] init];
  [aBlock addObject:@"<tr><th>&nbsp;</th>"];
  for (j = 0; j < MAX_COLS; j++)
    [aBlock addObject:[CLString stringWithFormat:@"<th>%c</th>", j+'A']];
  [aBlock addObject:@"</tr>"];
  
  for (i = 0; i < MAX_ROWS; i++) {
    [aBlock addObject:[CLString stringWithFormat:@"<tr><th>%i</th>", i+1]];
    for (j = 0; j < MAX_COLS; j++) {
      aRelay = [Relay relayForColumn:j+1 row:i+1];
      [aBlock addObject:[aRelay tableCell]];
    }
    [aBlock addObject:@"</tr>"];
  }
  
  return [aBlock autorelease];
}

-(CLArray *) editRows
{
  CLMutableArray *mArray;
  int i;


  mArray = [[CLMutableArray alloc] init];
  for (i = 0; i < MAX_ROWS; i++)
    [mArray addObject:[[[RelayRow alloc] initFromRow:i] autorelease]];
  
  return [mArray autorelease];
}

-(void) edit:(id) sender
{
  int i, j;
  Relay *aRelay;


  
  if ([sender isKindOfClass:[CLForm class]]) {
    for (i = 0; i < MAX_ROWS; i++) {
      for (j = 0; j < MAX_COLS; j++) {
	aRelay = [Relay relayForColumn:j+1 row:i+1];
	[aRelay setLabel:[sender valueOfFieldNamed:
				   [CLString stringWithFormat:@"label_%i_%i", j+1, i+1]]];
	[aRelay setUsed:NO];
	[CLDefaultContext saveChanges];
      }
    }

    [sender setPage:[CLPage pageFromFile:PAGE_INDEX owner:self]];
  }
  else
    [sender setPage:[CLPage pageFromFile:PAGE_EDIT owner:self]];

  return;
}

@end
