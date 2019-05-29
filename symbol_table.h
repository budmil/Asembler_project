#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define adr_regdir 0
#define adr_regind 1

int rednibroj;
char* curr_section;
int location_counter;
int prvi_prolaz;

int operator1_type;
int operator2_type;
char* operator1_value;
char* operator2_value;
int operator1_turn = 1;

typedef struct symbol_record {
	char* name;
	char* section;
	int offset;
	char binding;
	int order;
	struct symbol_record* next;
} symrec;

symrec* sym_table = NULL;

symrec * putsym (char* sym_name, char binding ) {  //ili void? //mozda dodati i tip labele i velicinu
	//printf("BRATEEEEEEEEEEEEEE: %s\n",sym_name);
	//printf("%d\n",rednibroj);
	symrec* ptr = NULL;
	ptr = (symrec*) malloc (sizeof(symrec));
	ptr->name = (char*) malloc (strlen(sym_name)+1);
	strcpy (ptr->name, sym_name);
	ptr->section = curr_section;
	ptr->offset = location_counter;
	ptr->binding = binding;
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
	fprintf(fp,"order        name                section                value          binding\n");
	symrec* curr = sym_table;
	while (curr) {
		fprintf(fp,"%d        %s                %s                %d          %c\n", curr->order, curr->name, curr->section, curr->offset, curr->binding);		
		curr = curr->next;
	}
	
}

void work_operation(char* mne) {
	if (!strcmp("add",mne)) {
		printf("BOGAMI: %s %s %s\n", mne, operator1_value, operator2_value); 
	}
	if (!strcmp("sub",mne)) {
		printf("BOGAMI: %s %s %s\n", mne, operator1_value, operator2_value); 
	}
	if (!strcmp("equ",mne)) {
		printf("BOGAMI: %s %s %s\n", mne, operator1_value, operator2_value); 
	}
	if (!strcmp("mov",mne)) {
		printf("BOGAMI: %s %s %s\n", mne, operator1_value, operator2_value); 
	}
	
	
}

