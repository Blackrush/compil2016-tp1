/*
 * list.c
 * Copyright (C) 2016 antoinechauvin <antoinechauvin@Antoines-MacBook-Pro.local>
 *
 * Distributed under terms of the MIT license.
 */

#include "list.h"


int list_elem_compare(LIST_ELEM left, LIST_ELEM right) {
  return strcmp(left, right);
}

void list_node_free(const node_ptr node) {
  if (node->next != NULL) {
    list_node_free(node->next);
  }
  free(node);
}

void list_init(const list_ptr list) {
  list->head = NULL;
  list->tail = NULL;
}

list_ptr list_new(void) {
  list_ptr list = malloc(sizeof(list));
  list_init(list);
  return list;
}

void list_add(const list_ptr list, LIST_ELEM value) {
  multimap_add(list, NULL, value);
}

void list_print(const list_ptr list) {
  int first = 1;
  printf("[");
  for (node_ptr it = list->head; it != NULL; it = it->next) {
    if (first) {
      first = 0;
    } else {
      printf(", ");
    }
    printf("\"%s\"", it->value);
  }
  printf("]\n");
}

void list_clear(const list_ptr list) {
  if (list->head != NULL) {
    list_node_free(list->head);
  }
  list_init(list);
}

void multimap_add(const list_ptr list, LIST_ELEM key, LIST_ELEM value) {
  node_ptr n = malloc(sizeof(node));
  n->next = NULL;
  n->key = key;
  n->value = value;

  if (list->head == NULL) {
    list->head = n;
    list->tail = n;
  } else {
    list->tail->next = n;
  }
  list->tail = n;
}

void multimap_print(const list_ptr list) {
  int first = 1;
  printf("{");
  for (node_ptr it = list->head; it != NULL; it = it->next) {
    if (first) {
      first = 0;
    } else {
      printf(", ");
    }
    printf("\"%s\": \"%s\"", it->key, it->value);
  }
  printf("}\n");
}
