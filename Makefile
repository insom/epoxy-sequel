O0=-O0
O2=-O2
O1=-O1
O3=-O3 -mtune=native
#OPTZ=$(O2)
EXTRALINK=#-pg
ALL_DEBUG=-ggdb -DDEBUG
NO_DEBUG=
DEBUG=${ALL_DEBUG}
#export DEBUG
#export OPTZ
#export EXTRALINK
CURVER?=1.4.15
MAKEOPT=-j 4

.PHONY: default
default: build_deps build_lib build_src

.PHONY: debug
debug: build_deps_debug build_lib_debug build_src_debug

.PHONY: build_deps
build_deps:
	cd deps && OPTZ="${O2} -ggdb" CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: build_lib
build_lib: build_deps
	cd lib && OPTZ="${O2} -ggdb" CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: build_src
build_src: build_deps build_lib
	cd src && OPTZ="${O2} -ggdb" CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: build_deps_debug
build_deps_debug:
	cd deps && OPTZ="${O0} -ggdb -DDEBUG" PROXYDEBUG=1 CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: build_lib_debug
build_lib_debug: build_deps_debug
	cd lib && OPTZ="${O0} -ggdb -DDEBUG" CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: build_src_debug
build_src_debug: build_deps build_lib_debug
	cd src && OPTZ="${O0} -ggdb -DDEBUG" CC=${CC} CXX=${CXX} ${MAKE}

.PHONY: clean
clean:
	cd lib && ${MAKE} clean
	cd src && ${MAKE} clean

.PHONY: cleanall
cleanall:
	cd deps && ${MAKE} cleanall
	cd lib && ${MAKE} clean
	cd src && ${MAKE} clean

install: src/proxysql
	install -m 0755 src/proxysql /usr/bin
	if [ ! -d /var/lib/proxysql ]; then mkdir /var/lib/proxysql ; fi
.PHONY: install
