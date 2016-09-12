#ifndef LIST_H
#define LIST_H

#include "stdlib.h"
#include "stdio.h"
#include "string.h"

#define LIST_ELEM const char*

typedef struct __node {
  struct __node* next;
  LIST_ELEM key;
  LIST_ELEM value;
} node;
typedef node* node_ptr;

typedef struct {
  node* head;
  node* tail;
} list;
typedef list* list_ptr;

int list_elem_compare(LIST_ELEM left, LIST_ELEM right);

void list_node_free(const node_ptr node);

void list_init(const list_ptr list);
list_ptr list_new(void);
void list_add(const list_ptr list, LIST_ELEM elem);
void list_print(const list_ptr list);
void list_clear(const list_ptr list);

void multimap_add(const list_ptr list, LIST_ELEM key, LIST_ELEM value);
void multimap_print(const list_ptr list);

#endif//LIST_H
