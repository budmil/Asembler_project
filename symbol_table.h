#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int rednibroj;
char* curr_section;
int location_counter;

typedef struct symbol_record {
	char* name;
	char* section;
	int offset;
	char locality;
	int order;
	struct symbol_record* next;
} symrec;

symrec* sym_table = NULL;

symrec * putsym (char* sym_name, char locality ) {  //ili void?
	//printf("BRATEEEEEEEEEEEEEE: %s\n",sym_name);
	//printf("%d\n",rednibroj);
	symrec* ptr = NULL;
	ptr = (symrec*) malloc (sizeof(symrec));
	ptr->name = (char*) malloc (strlen(sym_name)+1);
	strcpy (ptr->name, sym_name);
	ptr->section = curr_section;
	ptr->offset = location_counter;
	ptr->locality = locality;
	ptr->order = rednibroj;
	ptr->next = (struct symbol_record*) sym_table;
	sym_table = ptr;
	return ptr;	
};

symrec* getsym (char* sym_name) {
	symrec* curr = NULL;
	while (curr){
		if (strcmp(curr->name, sym_name)==0) return curr;
		curr = curr->next;
	}
	return NULL;
}



void ispisi(FILE* fp) {
	fprintf(fp,"=================================TABLE SYMBOL==================================\n");
	fprintf(fp,"order        name                section                value          locality\n");
	symrec* curr = sym_table;
	while (curr) {
		fprintf(fp,"%d        %s                %s                %d          %c\n", curr->order, curr->name, curr->section, curr->offset, curr->locality);		
		curr = curr->next;
	}
	
}