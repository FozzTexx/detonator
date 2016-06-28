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

#import "Relay.h"

@implementation Relay

+(Relay *) relayForColumn:(int) aCol row:(int) aRow
{
  return [CLDefaultContext loadObjectWithClass:self primaryKey:
			     [CLDictionary dictionaryWithObjectsAndKeys:
						[CLNumber numberWithInt:aRow], @"row",
						[CLNumber numberWithInt:aCol], @"col",
					   nil]];
}

-(id) read:(CLStream *) stream
{
  int val;


  [super read:stream];
  [stream readTypes:@"i", &val];
  isOn = val;
  return self;
}

-(void) write:(CLStream *) stream
{
  int val;


  [super write:stream];
  val = isOn;
  [stream writeTypes:@"i", &val];
  return;
}

-(BOOL) isOn
{
  return isOn;
}

-(void) setOn:(BOOL) flag
{
  isOn = flag;
  [self setUsed:YES];
  [CLDefaultContext saveChanges];
  return;
}

-(CLString *) td
{
  return [CLString stringWithFormat:@"<td bgcolor=\"%s\">", isOn ? "#f00" :
		     ([self used] ? "#ff0" : "#0f0")];
}

-(CLString *) triggerLabel
{
  CLString *aString = [self label];


  if (![aString length])
    aString = @"trigger";
  return aString;
}

-(void) trigger:(id) sender
{
  [self setOn:!isOn];
  return;
}
  
@end
