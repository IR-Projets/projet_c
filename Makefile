#	Modifier ici
#	-fichier .c			#
#	-nom executable			#
#	-nom des tests	(fin du fichier)#
FILE = main.c intervalle_list.c intervalle.c entier/entier.c entier/byte.c list/list.c list/cell.c
EXE = projet
TEST = test_main test_list test_cell test_entier test_byte

#	Les nom de repertoires:	#
#	-sources		#
#	-objets			#
#	-tests			#
SRC_DIR = src/
OBJ_DIR = obj/
TEST_DIR = test/

#	Principaux mode de création	#
#	-all: executables + tests	#
#	-exe: executable seul		#
#	-test: tests seul		#
#	-clean: clean_all + clean_test	#
all : exe test help
test: clean_test $(TEST)
clean: clean_obj clean_test
help: h

#	les paramètres de compilation	#
CC = gcc
FLAGS = -Wall -ansi -Werror
DEBUG = -g
OBJECTS = $(FILE:%.c=$(OBJ_DIR)%.o)



# 	Le projet	 #
exe : $(OBJECTS) 
	 $(CC) $(DEBUG) $(FLAGS) $(OBJECTS) -o $(EXE)
	@echo "Le projet: $(EXE) s'est correctement compilé"

$(OBJ_DIR)%.o : $(SRC_DIR)%.c
	$(CC) $(DEBUG) $(FLAGS) -c $< -o $@
	@echo "Le fichier $< s'est correctement compilé"



#	Les tests	#
#ne passe pas par les .o#
#cree un executable/test# 
define TEST_COMPILE
	@echo ""
	@echo "TEST: $@"
	$(CC) $(DEBUG) $(FLAGS) $^ -D $@=1 -o $(TEST_DIR)$(@) 
	@echo "Le test: $(@) s'est correctement compilé"
	./$(TEST_DIR)$(@)
	@echo "Le test: $(@) s'est correctement executé"
endef

#	Ecrire les make pour les test ici	#
#	-<nom du test>: <dépendances>, <...>,	#
#	-rajouter <le nom du test> dans $(TEST)	#
test_main: src/main.c src/intervalle_list.c src/intervalle.c src/entier/entier.c src/entier/byte.c src/list/list.c src/list/cell.c 
	$(TEST_COMPILE)
test_list: src/list/list.c src/list/cell.c
	$(TEST_COMPILE)
test_cell: src/list/cell.c
	$(TEST_COMPILE)
test_entier: src/entier/entier.c src/list/list.c src/list/cell.c
	$(TEST_COMPILE)
test_byte: src/entier/byte.c
	$(TEST_COMPILE)




#	Les cleans	#
clean_obj : 
	rm -f $(OBJECTS) $(EXE)
	@echo "Les Objets et exécutables ont bien étés supprimés"

clean_test :
	-rm -f $(TEST_DIR)*
	@echo "Tests supprimés"




#	help		#
h:
	@echo "Utilisation: make [all|exe|test|clean|clean_obj|clean_test]"