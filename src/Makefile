



DEPS_PATH=../deps

MARIADB_PATH=$(DEPS_PATH)/mariadb-client-library/mariadb_client
MARIADB_IDIR=$(MARIADB_PATH)/include
MARIADB_LDIR=$(MARIADB_PATH)/libmariadb

SQLITE3_DIR=$(DEPS_PATH)/sqlite3/sqlite3

IDIR=../include
LDIR=../lib
IDIRS=-I$(IDIR) -I$(JEMALLOC_IDIR) -I$(MARIADB_IDIR) $(LIBCONFIG_IDIR) -I$(DAEMONPATH_IDIR) -I$(SQLITE3_DIR)
LDIRS=-L$(LDIR) -L$(JEMALLOC_LDIR) $(LIBCONFIG_LDIR) -L$(RE2_PATH)/obj -L$(MARIADB_LDIR) -L$(DAEMONPATH_LDIR) -L$(PCRE_LDIR)

UNAME_S := $(shell uname -s)

MYCXXFLAGS=-std=c++11 $(IDIRS) $(OPTZ) $(DEBUG)

LDFLAGS+=
NOJEMALLOC := $(shell echo $(NOJEMALLOC))
ifeq ($(NOJEMALLOC),1)
MYLIBS=-Wl,--export-dynamic -lconfig -lproxysql -ldaemon -lconfig++ -lre2 -lpcrecpp -lpcre -lmariadbclient -Wl,-Bdynamic -lpthread -lm -lz -lrt -lcrypto -lssl $(EXTRALINK)
else
MYLIBS=-Wl,--export-dynamic -lconfig -lproxysql -ldaemon -ljemalloc -lconfig++ -lre2 -lpcrecpp -lpcre -lmariadbclient -Wl,-Bdynamic -lpthread -lm -lz -lrt -lcrypto -lssl $(EXTRALINK)
endif

ifeq ($(UNAME_S),Darwin)
	MYLIBS=-lssl -lre2 -lmariadbclient -lpthread -lm -lz -liconv -lcrypto
endif

ifeq ($(UNAME_S),Linux)
	MYLIBS+= -ldl
endif
ifeq ($(UNAME_S),FreeBSD)
	MYLIBS+= -lexecinfo
endif

ODIR= obj

EXECUTABLE=proxysql

_OBJ = main.o proxysql_global.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: %.cpp
	$(CXX) -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS) -Wall

proxysql: $(ODIR) $(OBJ) ../lib/obj/*.oo
	$(CXX) -o $@ -lluajit-5.1 $(OBJ) $(MYCXXFLAGS) $(CXXFLAGS) $(LDIRS) $(LIBS) $(LDFLAGS) $(MYLIBS)

$(ODIR):
	mkdir $(ODIR)

default: $(EXECUTABLE)

clean:
	rm -f *.pid $(ODIR)/*.o *~ core $(EXECUTABLE)



GIT_VERSION := $(shell git describe --long --tags)

DEPS_PATH=../deps


MARIADB_PATH=$(DEPS_PATH)/mariadb-client-library/mariadb_client
MARIADB_IDIR=$(MARIADB_PATH)/include

SQLITE3_DIR=$(DEPS_PATH)/sqlite3/sqlite3

IDIR=../include

IDIRS=-I$(IDIR) -I$(MARIADB_IDIR) -I$(SQLITE3_DIR) -I/usr/local/include -I/usr/include/luajit-2.1/

ODIR= obj

UNAME_S := $(shell uname -s)

MYCFLAGS=$(IDIRS) $(OPTZ) $(DEBUG) -Wall -DGITVERSION=\"$(GIT_VERSION)\" $(NOJEM)
MYCXXFLAGS=-std=c++11 $(MYCFLAGS)

default: libproxysql.a
.PHONY: default

_OBJ = c_tokenizer.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
_OBJ_CXX = ProxySQL_GloVars.oo network.oo debug.oo configfile.oo Query_Cache.oo SpookyV2.oo MySQL_Authentication.oo gen_utils.oo sqlite3db.oo mysql_connection.oo MySQL_HostGroups_Manager.oo mysql_data_stream.oo MySQL_Thread.oo MySQL_Session.oo MySQL_Protocol.oo mysql_backend.oo Query_Processor.oo ProxySQL_Admin.oo MySQL_Monitor.oo MySQL_Logger.oo thread.oo MySQL_PreparedStatement.oo SQLite3_Server.oo ProxySQL_Statistics.oo
OBJ_CXX = $(patsubst %,$(ODIR)/%,$(_OBJ_CXX))

%.ko: %.cpp
	$(CXX) -fPIC -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS)

$(ODIR)/%.o: %.c
	$(CC) -fPIC -c -o $@ $< $(MYCFLAGS) $(CFLAGS)

$(ODIR)/%.oo: %.cpp
	$(CXX) -fPIC -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS)

libproxysql.a: $(ODIR) $(OBJ) $(OBJ_CXX) $(SQLITE3_DIR)/sqlite3.o
	ar rcs $@ $(OBJ) $(OBJ_CXX) $(SQLITE3_DIR)/sqlite3.o

$(ODIR):
	mkdir $(ODIR)

#all: $(EXECUTABLE)


clean:
	rm -f *.pid $(ODIR)/*.oo $(ODIR)/*.o *.ko *.so *~ core libproxysql.a


## self note
# ../deps/protobuf/protobuf/src/protoc -I=. --cpp_out=. ./mysql_logger.proto
# mv mysql_logger.pb.cc mysql_logger.pb.cpp
