#include <stdlib.h>
#include <stdio.h>

int rednibroj;


typedef struct symbol_record {
	char* name;
	char* section;
	int offset;
	char locality;
	int order;
	struct symbol_record* next;
} symrec;

void putsym (char* sym_name) {
	//printf("BRATEEEEEEEEEEEEEE: %s\n",sym_name);
	printf("%d\n",rednibroj);
	symrec* ptr = NULL;
};