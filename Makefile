##########################################################
# ---Définition des variables---
##########################################################
# Les noms choisis sont des conventions pouvant être utilisées dans des règles dites implicites.

# Nom de l'interprète à utiliser pour lancer les commandes
SHELL=/bin/bash

# Nom du traducteur LEX utilisé
LEX=/usr/local/Cellar/flex/2.6.1/bin/flex

# Options du compilateur LEX
# -D_POSIX_SOURCE : définit la macro _POSIX_SOURCE, activant le standard POSIX.1 (IEEE Standard 1003.1)
# -o : modifie le nom du fichier créé par LEX (par défaut lex.yy.c)
# $@ : le nom de la cible de la règle où est utilisée cette option
# --nounput: ne génère pas la fonction yyunput() inutile
# --DYY_NO_INPUT: ne prend pas en compte la fonction input() inutile 
LFLAGS=-D_POSIX_SOURCE -o $@ -DYY_NO_INPUT --nounput

# Nom du compilateur C à utiliser
CC=gcc-6

# Options du compilateur C
CFLAGS=-std=c99 -pedantic -Wall

# Options du compilateur C lors de l'édition des liens
# -lfl : utilise la bibliothèque "fl" pour FLEX
LDFLAGS=-lfl -L "/usr/local/Cellar/flex/2.6.1/lib"

# Nom du fichier à générer
EXEC=exo1

##########################################################
# ---Règles de compilation---
##########################################################
# Une règle est de la forme :
#
# Cible:Dépendance1 Dépendance2 ... DépendanceN
# [tabulation]Commande1
# [tabulation]Commande2
# ...
# [tabulation]CommandeM
#
# Une variable nommée VAR s'utilise en notant $(VAR).
#
# Pour créer le fichier exec, on a besoin de exec.o, et on le génère par la commande:
# gcc -o exec exec.o -lfl
# Le fichier exec est la "cible" (le fichier que l'on souhaite générer).
# Cette cible dépends du fichier exec.o (exec.o est une "dépendance". Ici il n'y en a qu'une, elles peuvent être multiples).
# La cible de la règle peut se noter $@.
# La première dépendance de la règle peut se noter $<.
# Ainsi les commandes suivantes sont équivalentes
# gcc   -o exec exec.o -lfl 
# $(CC) -o $@   $<     $(LDFLAGS)
exo1: exo1.o
	$(CC) -o $@ $< $(LDFLAGS)

exo2: exo2.o
	$(CC) -o $@ $< $(LDFLAGS)

exo3: exo3.o list.o

list_test: list.o list_test.o

# On veut alors générer exec.o (nouvelle cible) qui dépend de exec.c.
# On peut définir une règle "implicite" en utilisant le même motif pour la règle et la dépendance en utilisant %.
# Ainsi %.o: %.c définit, entre autres, une règle exec.o: exec.c
# et les commandes suivantes sont équivalentes
# $(CC) $(CFLAGS)                -c $< 
# gcc   -std=c99 -pedantic -Wall -c exec.c
%.o: %.c
	$(CC) $(CFLAGS) -c $<


# Finalement on doit générer exec.c (nouvelle cible) depuis exec.l par la commande
# flex -D_POSIX_SOURCE -o exec.c exec.l
%.c: %.l
	$(LEX) $(LFLAGS) $<

# $(EXEC): $(EXEC).o
#	$(CC) -o $@ $< $(LDFLAGS)
# par
# %: %.o
#	$(CC) -o $@ $< $(LDFLAGS)
# on peut compiler tout fichier truc.l en un exécutable truc
# en tapant make truc dans le terminal.
# Tous les fichiers intermédiaires (.c et .o), qui n'apparaissent alors que dans des règles implicites, sont effacés.

# Un Makefile permet de compiler en économisant les ressources. Ainsi, il ne régénère que le nécessaire.
# En particulier, si un fichier .c n'a pas été modifié depuis le génération du .o correspondant, alors
# le .o n'est pas régénéré. Pour décider de cette re-génération, Make se base sur les dates de dernière modification
# fournies par le système de fichiers.
# Le fonctionnement interne de Make est basé sur un graphe de dépendance, parcouru en profondeur. Les cibles
# sont générées (si nécessaire) lors de la remontée récursive.
