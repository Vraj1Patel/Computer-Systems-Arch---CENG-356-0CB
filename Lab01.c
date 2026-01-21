
/*

Name: Vraj Patel

Student ID: N01654057

Course: CENG 356 - Computer Systems Architecture

Lab 1: Data Sizes of x86 Architecture

*/



#include <stdio.h>  // Standard input-output library



// Definition of the Account structure

struct Account {

  unsigned int account_number;  // Stores account number

  char account_type;       // Stores account type

  char *last_name;        // Pointer to last name string

  char *first_name;       // Pointer to first name string

  float balance;         // Stores account balance

  char reserved[6];       // Reserved bytes for alignment/future use

};



int main() {



  // Animal-named variables for basic data types

  char ant;       // char variable

  short cat;       // short variable

  int dog;        // int variable

  long lion;       // long variable

  float tiger;      // float variable

  double whale;     // double variable



  // Pointer variables

  int *eagle;      // pointer to int

  long *horse;      // pointer to long

  float *shark;     // pointer to float

  double *falcon;    // pointer to double



  // Structure variables

  struct Account panda;     // Account structure variable

  struct Account *wolf;     // Pointer to Account structure



  // Display sizes of basic data types

  printf("Size of char: %lu bytes\n", sizeof(ant));

  printf("Size of short: %lu bytes\n", sizeof(cat));

  printf("Size of int: %lu bytes\n", sizeof(dog));

  printf("Size of long: %lu bytes\n", sizeof(lion));

  printf("Size of float: %lu bytes\n", sizeof(tiger));

  printf("Size of double: %lu bytes\n", sizeof(whale));



  // Display sizes of pointer data types

  printf("Size of int pointer: %lu bytes\n", sizeof(eagle));

  printf("Size of long pointer: %lu bytes\n", sizeof(horse));

  printf("Size of float pointer: %lu bytes\n", sizeof(shark));

  printf("Size of double pointer: %lu bytes\n", sizeof(falcon));



  // Display sizes of structure and structure pointer

  printf("Size of struct Account: %lu bytes\n", sizeof(panda));

  printf("Size of struct Account pointer: %lu bytes\n", sizeof(wolf));



  return 0;  // End of program
}
