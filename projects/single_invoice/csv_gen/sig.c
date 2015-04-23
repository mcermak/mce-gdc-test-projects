/* Very simple and easy csv generator for simple invoice project
 * Note the result value are not random, but just inproper increment values
 */
#include <stdlib.h>
#include "simple_invoice_gen.h"

/* *********************************************************************** */
/* Params:
 *    from - int -  the first generating value
 *    to   - in  -  the last generation value
 */
int main(int argc, char *argv[])
{
	unsigned start, end;

 	if (argc != 3) exit(1);

	strtoul_ui(argv[1], 10, &start);
 	strtoul_ui(argv[2], 10, &end);

 	gen_csv(start, end);

	return 0;
}
