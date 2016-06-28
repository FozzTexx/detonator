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

#import <ClearLake/ClearLake.h>

#define MAX_ROWS	8
#define MAX_COLS	8

@interface Controller:CLObject
{
}

-(CLBlock *) relayRows;

@end
