#ifndef __SIMPLE_INVOICE_GEN__
#define __SIMPLE_INVOICE_GEN__

int strtoul_ui(char const *s, int base, unsigned int *result);
void print_row(unsigned i);
void gen_csv(unsigned start, unsigned end);

#endif
