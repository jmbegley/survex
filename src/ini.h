/* > ini.h
 * .ini file routines
 * Copyright (C) 1995 Olly Betts
 */

/*
1995.06.23 written
*/

#include <stdio.h>

/* section is the section of the ini file to read from
 * vars is a list of variables to read (terminated by NULL)
 * returns a list of values with NULL for "not found" (not terminated)
 */
char **ini_read( FILE *fh, char *section, char **vars );

/* very similar to ini_read, but recursively tries the section indicated
 * by "like=..." until it finds the variable or finds no "like=..."
 */
char **ini_read_hier( FILE *fh, char *section, char **vars );
