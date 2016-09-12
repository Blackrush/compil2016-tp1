/*
 * list_test.c
 * Copyright (C) 2016 antoinechauvin <antoinechauvin@Antoines-MacBook-Pro.local>
 *
 * Distributed under terms of the MIT license.
 */

#include "list.h"

int main(void) {
  list_ptr list = list_new();
  list_add(list, "hello");
  list_add(list, "world");
  list_print(list);
  list_clear(list);
  free(list);

  list_ptr mm = list_new();
  multimap_add(mm, "bonjour", "monde");
  multimap_add(mm, "foo", "bar");
  multimap_print(mm);
  list_clear(mm);
  free(mm);
}

