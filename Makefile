#
# Makefile for TINY
# Gnu C Version
# K. Louden 2/3/98

CC = gcc

CFLAGS = 

OBJS = main.o util.o lex.yy.o tiny.tab.o  

tinyc: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o tinyc -lfl

main.o: main.c globals.h util.h scan.h parse.h tiny.tab.h 
	$(CC) $(CFLAGS) -c main.c

util.o: util.c util.h globals.h tiny.tab.h
	$(CC) $(CFLAGS) -c util.c

lex.yy.o: tiny.tab.h lex.yy.c scan.h util.h globals.h
	$(CC) $(CFLAGS) -c lex.yy.c

tiny.tab.o: tiny.tab.h
	$(CC) $(CFLAGS) -c tiny.tab.c

tiny.tab.h: tiny.y
	bison -dv tiny.y

lex.yy.c: tiny.l
	flex tiny.l

tags: *.c Makefile
	ctags -R

clean:
	-rm tinyc
	-rm $(OBJS)
	-rm tiny.tab.*
	-rm lex.yy.c
	-rm tiny.output

all: tinyc

