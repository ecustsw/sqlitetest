
CC=gcc
LIBPATH= -L ../lib
LIBS= -lpthread -ldl
CDEFS = -Wall  -g -D_MT  -O2

BUILDPATH=../lib

sqlitesrc=shell sqlite3

sqlitelibsrc=sqlite3

all:sqlite libsqlite.a libsqlite.so
	@echo "all is updated"

sqlite:$(sqlitesrc:=.o)
	$(CC) $(sqlitesrc:=.o) -o ./$@ $(LIBS)

libsqlite.a:$(sqlitelibsrc:=.o)
	ar -crus $(BUILDPATH)/$@ $(sqlitelibsrc:=.o)

libsqlite.so:$(sqlitelibsrc:=.o)
	$(CC) -shared $(sqlitelibsrc:=.o) -o $(BUILDPATH)/$@ $(LIBS)

.SUFFIXES:.c .o

.c.o:
	$(CC) -c -fPIC $(CDEFS) $< -o $@

clean:
	rm -f $(BUILDPATH)/libsqlite* sqlite *.o