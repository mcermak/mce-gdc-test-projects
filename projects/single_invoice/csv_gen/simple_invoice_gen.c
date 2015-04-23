/* Library for generating simple and dummy csv for simple_invoice project */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include "simple_invoice_gen.h"

/* Manage provided parameters */
inline int strtoul_ui(char const *s, int base, unsigned int *result)
{
       unsigned long ul;
       char *p;

       errno = 0;
       ul = strtoul(s, &p, base);
       if (errno || *p || p == s || (unsigned int) ul != ul)
               return -1;
       *result = ul;
       return 0;
}

/* print simple row */
#ifndef SPARSE_ROW
inline void print_row(unsigned i)
{
       printf("%u,%u,%u,inv_%u,\"2015-03-03\",%u,%u,%u\n",
              i, i, i, i, i, i, i);
}
#else
inline void print_row(unsigned i)
{
       printf(",,,inv_%u,\"2015-03-03\",,,\n",i);
}
#endif

/* generate dummy csv file */
/* Params:
 *    start: start line
 *    end:   finish with this line
 */
void gen_csv(unsigned start, unsigned end)
{
	if (start > end) {
		fprintf(stderr, "ERROR: From cannot be greater than to.\n");
		exit(1);
	}

       printf("tab_inv_item.col_quantity,"
              "tab_inv_item.col_total,"
              "tab_inv.col_total,"
              "tab_inv.col_name,"
              "tab_inv.dt_invoice,"
              "tab_pers.col_bn,"
              "tab_pers.col_fn,"
              "tab_pers.col_sn\n");

       for (unsigned i = start; i <= end; i++)
               print_row(i);
}

