Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeDYLqk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:46:40 -0400
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21129 "EHLO
        sender-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeDYLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:46:37 -0400
In-Reply-To: <20180425112415.12327-4-pagupta@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
Message-ID: <152465676653.2268.10658685496022280558@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
From: no-reply@patchew.org
To: pagupta@redhat.com
Cc: famz@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org,
        kwolf@redhat.com, haozhong.zhang@intel.com, jack@suse.cz,
        xiaoguangrong.eric@gmail.com, riel@surriel.com, pagupta@redhat.com,
        niteshnarayanlal@hotmail.com, david@redhat.com, ross.zwisler@intel.com,
        lcapitulino@redhat.com, hch@infradead.org, mst@redhat.com,
        stefanha@redhat.com, imammedo@redhat.com, marcel@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com, nilal@redhat.com
Date: Wed, 25 Apr 2018 04:46:08 -0700 (PDT)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PBkmTc024048

Hi,

This series failed docker-build@min-glib build test. Please find the testing commands and
their output below. If you have Docker installed, you can probably reproduce it
locally.

Type: series
Message-id: 20180425112415.12327-4-pagupta@redhat.com
Subject: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device

=== TEST SCRIPT BEGIN ===
#!/bin/bash
set -e
git submodule update --init dtc
# Let docker tests dump environment info
export SHOW_ENV=1
export J=8
time make docker-test-build@min-glib
=== TEST SCRIPT END ===

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
Switched to a new branch 'test'
303e952759 qemu: Add virtio pmem device

=== OUTPUT BEGIN ===
Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
Cloning into '/var/tmp/patchew-tester-tmp-sqsog4o6/src/dtc'...
Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
  BUILD   min-glib
make[1]: Entering directory '/var/tmp/patchew-tester-tmp-sqsog4o6/src'
  GEN     /var/tmp/patchew-tester-tmp-sqsog4o6/src/docker-src.2018-04-25-07.43.07.4422/qemu.tar
Cloning into '/var/tmp/patchew-tester-tmp-sqsog4o6/src/docker-src.2018-04-25-07.43.07.4422/qemu.tar.vroot'...
done.
Your branch is up-to-date with 'origin/test'.
Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
Cloning into '/var/tmp/patchew-tester-tmp-sqsog4o6/src/docker-src.2018-04-25-07.43.07.4422/qemu.tar.vroot/dtc'...
Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registered for path 'ui/keycodemapdb'
Cloning into '/var/tmp/patchew-tester-tmp-sqsog4o6/src/docker-src.2018-04-25-07.43.07.4422/qemu.tar.vroot/ui/keycodemapdb'...
Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
  COPY    RUNNER
    RUN test-build in qemu:min-glib 
Environment variables:
HOSTNAME=ba95bf6d7097
MAKEFLAGS= -j8
J=8
CCACHE_DIR=/var/tmp/ccache
EXTRA_CONFIGURE_OPTS=
V=
SHOW_ENV=1
PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
TARGET_LIST=
SHLVL=1
HOME=/root
TEST_DIR=/tmp/qemu-test
FEATURES= dtc
DEBUG=
_=/usr/bin/env

Configure options:
--enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install
No C++ compiler available; disabling C++ specific optional code
Install prefix    /tmp/qemu-test/install
BIOS directory    /tmp/qemu-test/install/share/qemu
firmware path     /tmp/qemu-test/install/share/qemu-firmware
binary directory  /tmp/qemu-test/install/bin
library directory /tmp/qemu-test/install/lib
module directory  /tmp/qemu-test/install/lib/qemu
libexec directory /tmp/qemu-test/install/libexec
include directory /tmp/qemu-test/install/include
config directory  /tmp/qemu-test/install/etc
local state directory   /tmp/qemu-test/install/var
Manual directory  /tmp/qemu-test/install/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /tmp/qemu-test/src
GIT binary        git
GIT submodules    
C compiler        cc
Host C compiler   cc
C++ compiler      
Objective-C compiler cc
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g 
QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-all -Wno-missing-braces
LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g 
make              make
install           install
python            python -B
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       x86_64-softmmu aarch64-softmmu
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       yes (1.2.14)
GTK support       no 
GTK GL support    no
VTE support       no 
TLS priority      NORMAL
GNUTLS support    no
GNUTLS rnd        no
libgcrypt         no
libgcrypt kdf     no
nettle            no 
nettle kdf        no
libtasn1          no
curses support    no
virgl support     no
curl support      no
mingw32 support   no
Audio drivers     oss
Block whitelist (rw) 
Block whitelist (ro) 
VirtFS support    no
Multipath support no
VNC support       yes
VNC SASL support  no
VNC JPEG support  no
VNC PNG support   no
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               yes
vde support       no
netmap support    no
Linux AIO support no
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support yes
RDMA support      no
fdt support       yes
membarrier        no
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
posix_memalign    yes
libcap-ng support no
vhost-net support yes
vhost-crypto support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no 
rbd support       no
xfsctl support    no
smartcard support no
libusb            no
usb net redir     no
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh2 support   no
TPM passthrough   yes
TPM emulator      yes
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    no
bzip2 support     no
NUMA host support no
libxml2           no
tcmalloc support  no
jemalloc support  no
avx2 optimization no
replication support yes
VxHS block device no
capstone          no

WARNING: Use of SDL 1.2 is deprecated and will be removed in
WARNING: future releases. Please switch to using SDL 2.0
  GEN     x86_64-softmmu/config-devices.mak.tmp
  GEN     aarch64-softmmu/config-devices.mak.tmp
mkdir -p dtc/libfdt
mkdir -p dtc/tests
  GEN     config-host.h
  GEN     qemu-options.def
  GEN     qapi-gen
  GEN     trace/generated-tcg-tracers.h
  GEN     trace/generated-helpers-wrappers.h
  GEN     x86_64-softmmu/config-devices.mak
  GEN     trace/generated-helpers.h
  GEN     trace/generated-helpers.c
  GEN     module_block.h
  GEN     aarch64-softmmu/config-devices.mak
  GEN     ui/input-keymap-atset1-to-qcode.c
  GEN     ui/input-keymap-linux-to-qcode.c
  GEN     ui/input-keymap-qcode-to-atset1.c
  GEN     ui/input-keymap-qcode-to-atset2.c
  GEN     ui/input-keymap-qcode-to-atset3.c
  GEN     ui/input-keymap-qcode-to-linux.c
  GEN     ui/input-keymap-qcode-to-qnum.c
  GEN     ui/input-keymap-qcode-to-sun.c
  GEN     ui/input-keymap-usb-to-qcode.c
  GEN     ui/input-keymap-qnum-to-qcode.c
  GEN     ui/input-keymap-win32-to-qcode.c
  GEN     ui/input-keymap-x11-to-qcode.c
  GEN     ui/input-keymap-xorgevdev-to-qcode.c
  GEN     ui/input-keymap-xorgkbd-to-qcode.c
  GEN     ui/input-keymap-xorgxquartz-to-qcode.c
  GEN     ui/input-keymap-xorgxwin-to-qcode.c
  GEN     tests/test-qapi-gen
  GEN     trace-root.h
  GEN     util/trace.h
  GEN     crypto/trace.h
  GEN     io/trace.h
  GEN     migration/trace.h
  GEN     block/trace.h
  GEN     chardev/trace.h
  GEN     hw/block/trace.h
  GEN     hw/block/dataplane/trace.h
  GEN     hw/char/trace.h
  GEN     hw/intc/trace.h
  GEN     hw/net/trace.h
  GEN     hw/rdma/trace.h
  GEN     hw/rdma/vmw/trace.h
  GEN     hw/virtio/trace.h
  GEN     hw/audio/trace.h
  GEN     hw/misc/trace.h
  GEN     hw/misc/macio/trace.h
  GEN     hw/usb/trace.h
  GEN     hw/scsi/trace.h
  GEN     hw/nvram/trace.h
  GEN     hw/display/trace.h
  GEN     hw/input/trace.h
  GEN     hw/timer/trace.h
  GEN     hw/dma/trace.h
  GEN     hw/sparc/trace.h
  GEN     hw/sparc64/trace.h
  GEN     hw/sd/trace.h
  GEN     hw/isa/trace.h
  GEN     hw/mem/trace.h
  GEN     hw/i386/trace.h
  GEN     hw/i386/xen/trace.h
  GEN     hw/9pfs/trace.h
  GEN     hw/ppc/trace.h
  GEN     hw/pci/trace.h
  GEN     hw/pci-host/trace.h
  GEN     hw/s390x/trace.h
  GEN     hw/vfio/trace.h
  GEN     hw/acpi/trace.h
  GEN     hw/arm/trace.h
  GEN     hw/alpha/trace.h
  GEN     hw/hppa/trace.h
  GEN     hw/xen/trace.h
  GEN     hw/ide/trace.h
  GEN     hw/tpm/trace.h
  GEN     ui/trace.h
  GEN     audio/trace.h
  GEN     net/trace.h
  GEN     target/arm/trace.h
  GEN     target/i386/trace.h
  GEN     target/mips/trace.h
  GEN     target/sparc/trace.h
  GEN     target/s390x/trace.h
  GEN     target/ppc/trace.h
  GEN     qom/trace.h
  GEN     linux-user/trace.h
  GEN     qapi/trace.h
  GEN     accel/tcg/trace.h
  GEN     accel/kvm/trace.h
  GEN     nbd/trace.h
  GEN     trace-root.c
  GEN     scsi/trace.h
  GEN     util/trace.c
  GEN     crypto/trace.c
  GEN     io/trace.c
  GEN     migration/trace.c
  GEN     block/trace.c
  GEN     chardev/trace.c
  GEN     hw/block/trace.c
  GEN     hw/block/dataplane/trace.c
  GEN     hw/char/trace.c
  GEN     hw/intc/trace.c
  GEN     hw/net/trace.c
  GEN     hw/rdma/trace.c
  GEN     hw/rdma/vmw/trace.c
  GEN     hw/virtio/trace.c
  GEN     hw/audio/trace.c
  GEN     hw/misc/trace.c
  GEN     hw/misc/macio/trace.c
  GEN     hw/usb/trace.c
  GEN     hw/scsi/trace.c
  GEN     hw/nvram/trace.c
  GEN     hw/display/trace.c
  GEN     hw/input/trace.c
  GEN     hw/timer/trace.c
  GEN     hw/dma/trace.c
  GEN     hw/sparc/trace.c
  GEN     hw/sparc64/trace.c
  GEN     hw/sd/trace.c
  GEN     hw/isa/trace.c
  GEN     hw/mem/trace.c
  GEN     hw/i386/trace.c
  GEN     hw/i386/xen/trace.c
  GEN     hw/9pfs/trace.c
  GEN     hw/ppc/trace.c
  GEN     hw/pci/trace.c
  GEN     hw/pci-host/trace.c
  GEN     hw/s390x/trace.c
  GEN     hw/vfio/trace.c
  GEN     hw/acpi/trace.c
  GEN     hw/arm/trace.c
  GEN     hw/alpha/trace.c
  GEN     hw/hppa/trace.c
  GEN     hw/xen/trace.c
  GEN     hw/ide/trace.c
  GEN     hw/tpm/trace.c
  GEN     ui/trace.c
  GEN     audio/trace.c
  GEN     net/trace.c
  GEN     target/arm/trace.c
  GEN     target/i386/trace.c
  GEN     target/mips/trace.c
  GEN     target/sparc/trace.c
  GEN     target/s390x/trace.c
  GEN     target/ppc/trace.c
  GEN     qom/trace.c
  GEN     linux-user/trace.c
  GEN     qapi/trace.c
  GEN     accel/tcg/trace.c
  GEN     accel/kvm/trace.c
  GEN     nbd/trace.c
  GEN     scsi/trace.c
  GEN     config-all-devices.mak
	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
	 DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
	 DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
	 DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
	 DEP /tmp/qemu-test/src/dtc/tests/check_path.c
	 DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
	 DEP /tmp/qemu-test/src/dtc/tests/overlay.c
	 DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
	 DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
	 DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
	 DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
	 DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
	 DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
	 DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
	 DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
	 DEP /tmp/qemu-test/src/dtc/tests/incbin.c
	 DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
	 DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
	 DEP /tmp/qemu-test/src/dtc/tests/path-references.c
	 DEP /tmp/qemu-test/src/dtc/tests/references.c
	 DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
	 DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
	 DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
	 DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
	 DEP /tmp/qemu-test/src/dtc/tests/del_node.c
	 DEP /tmp/qemu-test/src/dtc/tests/del_property.c
	 DEP /tmp/qemu-test/src/dtc/tests/setprop.c
	 DEP /tmp/qemu-test/src/dtc/tests/set_name.c
	 DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
	 DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
	 DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
	 DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
	 DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
	 DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
	 DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
	 DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
	 DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
	 DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
	 DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
	 DEP /tmp/qemu-test/src/dtc/tests/notfound.c
	 DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
	 DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
	 DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
	 DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
	 DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
	 DEP /tmp/qemu-test/src/dtc/tests/find_property.c
	 DEP /tmp/qemu-test/src/dtc/tests/root_node.c
	 DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
	 DEP /tmp/qemu-test/src/dtc/util.c
	 DEP /tmp/qemu-test/src/dtc/fdtput.c
	 DEP /tmp/qemu-test/src/dtc/fdtoverlay.c
	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
	 DEP /tmp/qemu-test/src/dtc/fdtget.c
	 LEX convert-dtsv0-lexer.lex.c
make[1]: flex: Command not found
	 DEP /tmp/qemu-test/src/dtc/srcpos.c
	 BISON dtc-parser.tab.c
make[1]: bison: Command not found
	 LEX dtc-lexer.lex.c
make[1]: flex: Command not found
	 DEP /tmp/qemu-test/src/dtc/treesource.c
	 DEP /tmp/qemu-test/src/dtc/livetree.c
	 DEP /tmp/qemu-test/src/dtc/fstree.c
	 DEP /tmp/qemu-test/src/dtc/flattree.c
	 DEP /tmp/qemu-test/src/dtc/dtc.c
	 DEP /tmp/qemu-test/src/dtc/data.c
	 DEP /tmp/qemu-test/src/dtc/checks.c
	CHK version_gen.h
	 BISON dtc-parser.tab.c
	 LEX dtc-lexer.lex.c
make[1]: bison: Command not found
make[1]: flex: Command not found
	 LEX convert-dtsv0-lexer.lex.c
	UPD version_gen.h
make[1]: flex: Command not found
	 DEP /tmp/qemu-test/src/dtc/util.c
	 LEX convert-dtsv0-lexer.lex.c
	 BISON dtc-parser.tab.c
	 LEX dtc-lexer.lex.c
make[1]: flex: Command not found
make[1]: flex: Command not found
make[1]: bison: Command not found
	 CC libfdt/fdt.o
	 CC libfdt/fdt_ro.o
	 CC libfdt/fdt_wip.o
	 CC libfdt/fdt_rw.o
	 CC libfdt/fdt_sw.o
	 CC libfdt/fdt_strerror.o
	 CC libfdt/fdt_empty_tree.o
	 CC libfdt/fdt_addresses.o
	 CC libfdt/fdt_overlay.o
	 AR libfdt/libfdt.a
ar: creating libfdt/libfdt.a
a - libfdt/fdt.o
a - libfdt/fdt_ro.o
a - libfdt/fdt_wip.o
a - libfdt/fdt_sw.o
a - libfdt/fdt_rw.o
a - libfdt/fdt_strerror.o
a - libfdt/fdt_empty_tree.o
a - libfdt/fdt_addresses.o
a - libfdt/fdt_overlay.o
mkdir -p dtc/libfdt
mkdir -p dtc/tests
	 LEX convert-dtsv0-lexer.lex.c
make[1]: flex: Command not found
	 BISON dtc-parser.tab.c
make[1]: bison: Command not found
	 LEX dtc-lexer.lex.c
make[1]: flex: Command not found
  CC      tests/qemu-iotests/socket_scm_helper.o
  GEN     qga/qapi-generated/qapi-gen
  CC      qapi/qapi-types.o
  CC      qapi/qapi-builtin-types.o
  CC      qapi/qapi-types-block-core.o
  CC      qapi/qapi-types-common.o
  CC      qapi/qapi-types-char.o
  CC      qapi/qapi-types-block.o
  CC      qapi/qapi-types-crypto.o
  CC      qapi/qapi-types-introspect.o
  CC      qapi/qapi-types-migration.o
  CC      qapi/qapi-types-misc.o
  CC      qapi/qapi-types-net.o
  CC      qapi/qapi-types-rocker.o
  CC      qapi/qapi-types-run-state.o
  CC      qapi/qapi-types-sockets.o
  CC      qapi/qapi-types-tpm.o
  CC      qapi/qapi-types-trace.o
  CC      qapi/qapi-types-transaction.o
  CC      qapi/qapi-types-ui.o
  CC      qapi/qapi-builtin-visit.o
  CC      qapi/qapi-visit.o
  CC      qapi/qapi-visit-block-core.o
  CC      qapi/qapi-visit-block.o
  CC      qapi/qapi-visit-char.o
  CC      qapi/qapi-visit-common.o
  CC      qapi/qapi-visit-crypto.o
  CC      qapi/qapi-visit-introspect.o
  CC      qapi/qapi-visit-migration.o
  CC      qapi/qapi-visit-misc.o
  CC      qapi/qapi-visit-net.o
  CC      qapi/qapi-visit-rocker.o
  CC      qapi/qapi-visit-run-state.o
  CC      qapi/qapi-visit-sockets.o
  CC      qapi/qapi-visit-tpm.o
  CC      qapi/qapi-visit-trace.o
  CC      qapi/qapi-visit-transaction.o
  CC      qapi/qapi-visit-ui.o
  CC      qapi/qapi-events.o
  CC      qapi/qapi-events-block.o
  CC      qapi/qapi-events-block-core.o
  CC      qapi/qapi-events-char.o
  CC      qapi/qapi-events-common.o
  CC      qapi/qapi-events-crypto.o
  CC      qapi/qapi-events-introspect.o
  CC      qapi/qapi-events-migration.o
  CC      qapi/qapi-events-misc.o
  CC      qapi/qapi-events-net.o
  CC      qapi/qapi-events-rocker.o
  CC      qapi/qapi-events-run-state.o
  CC      qapi/qapi-events-sockets.o
  CC      qapi/qapi-events-tpm.o
  CC      qapi/qapi-events-trace.o
  CC      qapi/qapi-events-transaction.o
  CC      qapi/qapi-events-ui.o
  CC      qapi/qapi-introspect.o
  CC      qapi/qapi-visit-core.o
  CC      qapi/qapi-dealloc-visitor.o
  CC      qapi/qobject-input-visitor.o
  CC      qapi/qobject-output-visitor.o
  CC      qapi/qmp-registry.o
  CC      qapi/qmp-dispatch.o
  CC      qapi/string-input-visitor.o
  CC      qapi/string-output-visitor.o
  CC      qapi/opts-visitor.o
  CC      qapi/qapi-clone-visitor.o
  CC      qapi/qmp-event.o
  CC      qapi/qapi-util.o
  CC      qobject/qnull.o
  CC      qobject/qstring.o
  CC      qobject/qnum.o
  CC      qobject/qdict.o
  CC      qobject/qlist.o
  CC      qobject/qbool.o
  CC      qobject/qlit.o
  CC      qobject/qjson.o
  CC      qobject/qobject.o
  CC      qobject/json-lexer.o
  CC      qobject/json-streamer.o
  CC      qobject/json-parser.o
  CC      trace/control.o
  CC      trace/qmp.o
  CC      util/osdep.o
  CC      util/unicode.o
  CC      util/cutils.o
  CC      util/qemu-timer-common.o
  CC      util/bufferiszero.o
  CC      util/aiocb.o
  CC      util/lockcnt.o
  CC      util/async.o
  CC      util/aio-wait.o
  CC      util/thread-pool.o
  CC      util/qemu-timer.o
  CC      util/main-loop.o
  CC      util/iohandler.o
  CC      util/aio-posix.o
  CC      util/compatfd.o
  CC      util/event_notifier-posix.o
  CC      util/mmap-alloc.o
  CC      util/oslib-posix.o
  CC      util/qemu-openpty.o
  CC      util/qemu-thread-posix.o
  CC      util/memfd.o
  CC      util/envlist.o
  CC      util/path.o
  CC      util/module.o
  CC      util/host-utils.o
  CC      util/bitmap.o
  CC      util/bitops.o
  CC      util/hbitmap.o
  CC      util/fifo8.o
  CC      util/acl.o
  CC      util/error.o
  CC      util/cacheinfo.o
  CC      util/qemu-error.o
  CC      util/id.o
  CC      util/iov.o
  CC      util/qemu-config.o
  CC      util/uri.o
  CC      util/qemu-sockets.o
  CC      util/notify.o
  CC      util/qemu-option.o
  CC      util/qemu-progress.o
  CC      util/keyval.o
  CC      util/hexdump.o
  CC      util/crc32c.o
  CC      util/uuid.o
  CC      util/throttle.o
  CC      util/getauxval.o
  CC      util/readline.o
  CC      util/rcu.o
  CC      util/qemu-coroutine.o
  CC      util/qemu-coroutine-lock.o
  CC      util/qemu-coroutine-io.o
  CC      util/coroutine-ucontext.o
  CC      util/qemu-coroutine-sleep.o
  CC      util/buffer.o
  CC      util/timed-average.o
  CC      util/base64.o
  CC      util/log.o
  CC      util/pagesize.o
  CC      util/qdist.o
  CC      util/qht.o
  CC      util/range.o
  CC      util/stats64.o
  CC      util/systemd.o
  CC      util/vfio-helpers.o
  CC      trace-root.o
  CC      util/trace.o
  CC      crypto/trace.o
  CC      io/trace.o
  CC      migration/trace.o
  CC      block/trace.o
  CC      chardev/trace.o
  CC      hw/block/trace.o
  CC      hw/block/dataplane/trace.o
  CC      hw/char/trace.o
  CC      hw/intc/trace.o
  CC      hw/net/trace.o
  CC      hw/rdma/vmw/trace.o
  CC      hw/rdma/trace.o
  CC      hw/virtio/trace.o
  CC      hw/audio/trace.o
  CC      hw/misc/trace.o
  CC      hw/misc/macio/trace.o
  CC      hw/usb/trace.o
  CC      hw/scsi/trace.o
  CC      hw/nvram/trace.o
  CC      hw/display/trace.o
  CC      hw/input/trace.o
  CC      hw/timer/trace.o
  CC      hw/dma/trace.o
  CC      hw/sparc/trace.o
  CC      hw/sd/trace.o
  CC      hw/sparc64/trace.o
  CC      hw/isa/trace.o
  CC      hw/mem/trace.o
  CC      hw/i386/trace.o
  CC      hw/i386/xen/trace.o
  CC      hw/9pfs/trace.o
  CC      hw/ppc/trace.o
  CC      hw/pci/trace.o
  CC      hw/pci-host/trace.o
  CC      hw/s390x/trace.o
  CC      hw/vfio/trace.o
  CC      hw/acpi/trace.o
  CC      hw/arm/trace.o
  CC      hw/alpha/trace.o
  CC      hw/hppa/trace.o
  CC      hw/xen/trace.o
  CC      hw/ide/trace.o
  CC      hw/tpm/trace.o
  CC      ui/trace.o
  CC      audio/trace.o
  CC      net/trace.o
  CC      target/arm/trace.o
  CC      target/i386/trace.o
  CC      target/mips/trace.o
  CC      target/sparc/trace.o
  CC      target/s390x/trace.o
  CC      target/ppc/trace.o
  CC      qom/trace.o
  CC      linux-user/trace.o
  CC      qapi/trace.o
  CC      accel/tcg/trace.o
  CC      accel/kvm/trace.o
  CC      nbd/trace.o
  CC      scsi/trace.o
  CC      crypto/pbkdf-stub.o
  CC      stubs/arch-query-cpu-def.o
  CC      stubs/arch-query-cpu-model-expansion.o
  CC      stubs/arch-query-cpu-model-comparison.o
  CC      stubs/arch-query-cpu-model-baseline.o
  CC      stubs/bdrv-next-monitor-owned.o
  CC      stubs/blk-commit-all.o
  CC      stubs/blockdev-close-all-bdrv-states.o
  CC      stubs/clock-warp.o
  CC      stubs/cpu-get-clock.o
  CC      stubs/cpu-get-icount.o
  CC      stubs/dump.o
  CC      stubs/error-printf.o
  CC      stubs/fdset.o
  CC      stubs/gdbstub.o
  CC      stubs/get-vm-name.o
  CC      stubs/iothread.o
  CC      stubs/iothread-lock.o
  CC      stubs/is-daemonized.o
  CC      stubs/machine-init-done.o
  CC      stubs/migr-blocker.o
  CC      stubs/change-state-handler.o
  CC      stubs/monitor.o
  CC      stubs/notify-event.o
  CC      stubs/qtest.o
  CC      stubs/replay.o
  CC      stubs/set-fd-handler.o
  CC      stubs/runstate-check.o
  CC      stubs/slirp.o
  CC      stubs/sysbus.o
  CC      stubs/tpm.o
  CC      stubs/trace-control.o
  CC      stubs/uuid.o
  CC      stubs/vm-stop.o
  CC      stubs/vmstate.o
  CC      stubs/qmp_pc_dimm.o
  CC      stubs/target-monitor-defs.o
  CC      stubs/target-get-monitor-def.o
  CC      stubs/pc_madt_cpu_entry.o
  CC      stubs/vmgenid.o
  CC      stubs/xen-common.o
  CC      stubs/xen-hvm.o
  CC      stubs/pci-host-piix.o
  CC      stubs/ram-block.o
  CC      contrib/ivshmem-client/ivshmem-client.o
  CC      contrib/ivshmem-client/main.o
  CC      contrib/ivshmem-server/ivshmem-server.o
  CC      contrib/ivshmem-server/main.o
  CC      qemu-nbd.o
  CC      block.o
  CC      blockjob.o
  CC      qemu-io-cmds.o
  CC      replication.o
  CC      block/raw-format.o
  CC      block/qcow.o
  CC      block/vdi.o
/tmp/qemu-test/src/blockjob.c: In function 'block_job_state_transition':
/tmp/qemu-test/src/blockjob.c:75: warning: comparison of unsigned expression >= 0 is always true
/tmp/qemu-test/src/blockjob.c: In function 'block_job_apply_verb':
/tmp/qemu-test/src/blockjob.c:86: warning: comparison of unsigned expression >= 0 is always true
  CC      block/vmdk.o
  CC      block/cloop.o
  CC      block/bochs.o
  CC      block/vpc.o
  CC      block/vvfat.o
  CC      block/dmg.o
  CC      block/qcow2.o
  CC      block/qcow2-refcount.o
  CC      block/qcow2-cluster.o
  CC      block/qcow2-snapshot.o
  CC      block/qcow2-cache.o
  CC      block/qed.o
  CC      block/qcow2-bitmap.o
  CC      block/qed-l2-cache.o
  CC      block/qed-table.o
  CC      block/qed-cluster.o
  CC      block/qed-check.o
  CC      block/vhdx.o
  CC      block/vhdx-endian.o
  CC      block/vhdx-log.o
  CC      block/quorum.o
  CC      block/parallels.o
  CC      block/blkdebug.o
  CC      block/blkverify.o
  CC      block/blkreplay.o
  CC      block/block-backend.o
  CC      block/snapshot.o
  CC      block/qapi.o
  CC      block/file-posix.o
  CC      block/null.o
  CC      block/commit.o
  CC      block/mirror.o
  CC      block/io.o
  CC      block/create.o
  CC      block/throttle-groups.o
  CC      block/nvme.o
  CC      block/nbd.o
  CC      block/nbd-client.o
  CC      block/sheepdog.o
  CC      block/accounting.o
  CC      block/dirty-bitmap.o
  CC      block/write-threshold.o
  CC      block/backup.o
  CC      block/replication.o
  CC      block/throttle.o
  CC      block/crypto.o
  CC      nbd/server.o
  CC      nbd/client.o
  CC      nbd/common.o
  CC      scsi/utils.o
  CC      scsi/pr-manager.o
  CC      scsi/pr-manager-helper.o
  CC      crypto/init.o
  CC      crypto/hash.o
  CC      crypto/hash-glib.o
  CC      crypto/hmac.o
  CC      crypto/hmac-glib.o
  CC      crypto/aes.o
  CC      crypto/desrfb.o
  CC      crypto/cipher.o
  CC      crypto/tlscreds.o
  CC      crypto/tlscredsanon.o
  CC      crypto/tlscredsx509.o
  CC      crypto/tlssession.o
  CC      crypto/secret.o
  CC      crypto/random-platform.o
  CC      crypto/pbkdf.o
  CC      crypto/ivgen.o
  CC      crypto/ivgen-essiv.o
  CC      crypto/ivgen-plain.o
  CC      crypto/ivgen-plain64.o
  CC      crypto/afsplit.o
  CC      crypto/xts.o
  CC      crypto/block.o
  CC      crypto/block-qcow.o
  CC      crypto/block-luks.o
  CC      io/channel.o
  CC      io/channel-buffer.o
  CC      io/channel-command.o
  CC      io/channel-file.o
  CC      io/channel-socket.o
  CC      io/channel-tls.o
  CC      io/channel-watch.o
  CC      io/channel-websock.o
  CC      io/channel-util.o
  CC      io/dns-resolver.o
  CC      io/net-listener.o
  CC      io/task.o
  CC      qom/object.o
  CC      qom/container.o
  CC      qom/qom-qobject.o
  CC      qom/object_interfaces.o
  CC      qemu-io.o
  GEN     qemu-img-cmds.h
  CC      scsi/qemu-pr-helper.o
  CC      qemu-bridge-helper.o
  CC      blockdev.o
  CC      blockdev-nbd.o
  CC      bootdevice.o
  CC      iothread.o
  CC      qdev-monitor.o
  CC      device-hotplug.o
  CC      os-posix.o
  CC      bt-host.o
  CC      bt-vhci.o
  CC      dma-helpers.o
  CC      vl.o
  CC      tpm.o
  CC      device_tree.o
  CC      qapi/qapi-commands.o
  CC      qapi/qapi-commands-block-core.o
  CC      qapi/qapi-commands-block.o
  CC      qapi/qapi-commands-char.o
  CC      qapi/qapi-commands-common.o
  CC      qapi/qapi-commands-crypto.o
  CC      qapi/qapi-commands-introspect.o
  CC      qapi/qapi-commands-migration.o
  CC      qapi/qapi-commands-misc.o
  CC      qapi/qapi-commands-rocker.o
  CC      qapi/qapi-commands-net.o
  CC      qapi/qapi-commands-run-state.o
  CC      qapi/qapi-commands-sockets.o
  CC      qapi/qapi-commands-tpm.o
  CC      qapi/qapi-commands-trace.o
  CC      qapi/qapi-commands-transaction.o
  CC      qapi/qapi-commands-ui.o
  CC      qmp.o
  CC      hmp.o
  CC      cpus-common.o
  CC      audio/audio.o
  CC      audio/noaudio.o
  CC      audio/wavaudio.o
  CC      audio/mixeng.o
  CC      audio/wavcapture.o
  CC      backends/rng.o
  CC      backends/rng-egd.o
  CC      backends/rng-random.o
  CC      backends/tpm.o
  CC      backends/hostmem.o
  CC      backends/hostmem-ram.o
  CC      backends/hostmem-file.o
  CC      backends/cryptodev.o
  CC      backends/cryptodev-builtin.o
  CC      backends/cryptodev-vhost.o
  CC      backends/cryptodev-vhost-user.o
  CC      backends/hostmem-memfd.o
  CC      block/stream.o
  CC      chardev/msmouse.o
  CC      chardev/wctablet.o
  CC      chardev/testdev.o
  CC      disas/arm.o
  CC      fsdev/qemu-fsdev-dummy.o
  CC      disas/i386.o
  CC      fsdev/qemu-fsdev-opts.o
  CC      fsdev/qemu-fsdev-throttle.o
  CC      hw/acpi/core.o
  CC      hw/acpi/piix4.o
  CC      hw/acpi/pcihp.o
  CC      hw/acpi/ich9.o
  CC      hw/acpi/tco.o
  CC      hw/acpi/cpu_hotplug.o
  CC      hw/acpi/memory_hotplug.o
  CC      hw/acpi/cpu.o
  CC      hw/acpi/nvdimm.o
  CC      hw/acpi/vmgenid.o
  CC      hw/acpi/acpi_interface.o
  CC      hw/acpi/bios-linker-loader.o
  CC      hw/acpi/aml-build.o
  CC      hw/acpi/ipmi.o
  CC      hw/acpi/acpi-stub.o
  CC      hw/acpi/ipmi-stub.o
  CC      hw/audio/sb16.o
  CC      hw/audio/es1370.o
  CC      hw/audio/ac97.o
  CC      hw/audio/fmopl.o
  CC      hw/audio/adlib.o
  CC      hw/audio/gus.o
  CC      hw/audio/gusemu_hal.o
  CC      hw/audio/gusemu_mixer.o
  CC      hw/audio/cs4231a.o
  CC      hw/audio/intel-hda.o
  CC      hw/audio/hda-codec.o
  CC      hw/audio/pcspk.o
  CC      hw/audio/wm8750.o
  CC      hw/audio/pl041.o
  CC      hw/audio/lm4549.o
  CC      hw/audio/marvell_88w8618.o
  CC      hw/audio/soundhw.o
  CC      hw/block/block.o
  CC      hw/block/cdrom.o
  CC      hw/block/hd-geometry.o
  CC      hw/block/fdc.o
  CC      hw/block/m25p80.o
  CC      hw/block/nand.o
  CC      hw/block/pflash_cfi01.o
  CC      hw/block/pflash_cfi02.o
  CC      hw/block/ecc.o
  CC      hw/block/onenand.o
  CC      hw/block/nvme.o
  CC      hw/bt/core.o
  CC      hw/bt/l2cap.o
  CC      hw/bt/sdp.o
  CC      hw/bt/hci.o
  CC      hw/bt/hid.o
  CC      hw/bt/hci-csr.o
  CC      hw/char/ipoctal232.o
  CC      hw/char/parallel.o
  CC      hw/char/parallel-isa.o
  CC      hw/char/pl011.o
  CC      hw/char/serial.o
  CC      hw/char/serial-isa.o
  CC      hw/char/serial-pci.o
  CC      hw/char/virtio-console.o
  CC      hw/char/cadence_uart.o
  CC      hw/char/cmsdk-apb-uart.o
  CC      hw/char/debugcon.o
  CC      hw/char/imx_serial.o
  CC      hw/core/qdev.o
  CC      hw/core/qdev-properties.o
  CC      hw/core/bus.o
  CC      hw/core/reset.o
  CC      hw/core/qdev-fw.o
  CC      hw/core/fw-path-provider.o
  CC      hw/core/irq.o
  CC      hw/core/hotplug.o
  CC      hw/core/nmi.o
  CC      hw/core/stream.o
  CC      hw/core/ptimer.o
  CC      hw/core/sysbus.o
  CC      hw/core/machine.o
  CC      hw/core/loader.o
  CC      hw/core/qdev-properties-system.o
  CC      hw/core/register.o
  CC      hw/core/or-irq.o
  CC      hw/core/split-irq.o
  CC      hw/core/platform-bus.o
  CC      hw/cpu/core.o
  CC      hw/display/ads7846.o
  CC      hw/display/cirrus_vga.o
  CC      hw/display/pl110.o
  CC      hw/display/sii9022.o
  CC      hw/display/ssd0303.o
  CC      hw/display/ssd0323.o
  CC      hw/display/vga-pci.o
  CC      hw/display/vga-isa.o
  CC      hw/display/vmware_vga.o
  CC      hw/display/blizzard.o
  CC      hw/display/exynos4210_fimd.o
  CC      hw/display/framebuffer.o
  CC      hw/display/tc6393xb.o
  CC      hw/dma/pl080.o
  CC      hw/dma/pl330.o
  CC      hw/dma/i8257.o
  CC      hw/dma/xilinx_axidma.o
  CC      hw/dma/xlnx-zynq-devcfg.o
  CC      hw/gpio/max7310.o
  CC      hw/gpio/pl061.o
  CC      hw/gpio/zaurus.o
  CC      hw/gpio/gpio_key.o
  CC      hw/i2c/core.o
  CC      hw/i2c/smbus.o
  CC      hw/i2c/smbus_eeprom.o
  CC      hw/i2c/i2c-ddc.o
  CC      hw/i2c/versatile_i2c.o
  CC      hw/i2c/smbus_ich9.o
  CC      hw/i2c/pm_smbus.o
  CC      hw/i2c/bitbang_i2c.o
  CC      hw/i2c/exynos4210_i2c.o
  CC      hw/i2c/imx_i2c.o
  CC      hw/i2c/aspeed_i2c.o
  CC      hw/ide/core.o
  CC      hw/ide/atapi.o
  CC      hw/ide/qdev.o
  CC      hw/ide/pci.o
  CC      hw/ide/isa.o
  CC      hw/ide/piix.o
  CC      hw/ide/microdrive.o
  CC      hw/ide/ahci.o
  CC      hw/ide/ich.o
  CC      hw/ide/ahci-allwinner.o
  CC      hw/input/hid.o
  CC      hw/input/lm832x.o
  CC      hw/input/pckbd.o
  CC      hw/input/pl050.o
  CC      hw/input/ps2.o
  CC      hw/input/stellaris_input.o
  CC      hw/input/tsc2005.o
  CC      hw/input/virtio-input.o
  CC      hw/input/virtio-input-hid.o
  CC      hw/input/virtio-input-host.o
  CC      hw/intc/i8259.o
  CC      hw/intc/i8259_common.o
  CC      hw/intc/pl190.o
  CC      hw/intc/xlnx-zynqmp-ipi.o
  CC      hw/intc/xlnx-pmu-iomod-intc.o
  CC      hw/intc/imx_avic.o
  CC      hw/intc/imx_gpcv2.o
  CC      hw/intc/realview_gic.o
  CC      hw/intc/ioapic_common.o
  CC      hw/intc/arm_gic_common.o
  CC      hw/intc/arm_gic.o
  CC      hw/intc/arm_gicv2m.o
  CC      hw/intc/arm_gicv3_common.o
  CC      hw/intc/arm_gicv3.o
  CC      hw/intc/arm_gicv3_dist.o
  CC      hw/intc/arm_gicv3_redist.o
  CC      hw/intc/arm_gicv3_its_common.o
  CC      hw/intc/intc.o
  CC      hw/ipack/ipack.o
  CC      hw/ipack/tpci200.o
  CC      hw/ipmi/ipmi.o
  CC      hw/ipmi/ipmi_bmc_sim.o
  CC      hw/ipmi/ipmi_bmc_extern.o
  CC      hw/ipmi/isa_ipmi_kcs.o
  CC      hw/ipmi/isa_ipmi_bt.o
  CC      hw/isa/isa-bus.o
  CC      hw/isa/isa-superio.o
  CC      hw/isa/smc37c669-superio.o
  CC      hw/isa/apm.o
  CC      hw/mem/pc-dimm.o
  CC      hw/mem/nvdimm.o
  CC      hw/misc/applesmc.o
  CC      hw/misc/max111x.o
  CC      hw/misc/tmp105.o
  CC      hw/misc/tmp421.o
  CC      hw/misc/debugexit.o
  CC      hw/misc/sga.o
  CC      hw/misc/pc-testdev.o
  CC      hw/misc/pci-testdev.o
  CC      hw/misc/edu.o
  CC      hw/misc/unimp.o
  CC      hw/misc/vmcoreinfo.o
  CC      hw/misc/arm_l2x0.o
  CC      hw/misc/arm_integrator_debug.o
  CC      hw/misc/a9scu.o
  CC      hw/misc/arm11scu.o
  CC      hw/net/ne2000.o
  CC      hw/net/eepro100.o
  CC      hw/net/pcnet-pci.o
  CC      hw/net/pcnet.o
  CC      hw/net/e1000.o
  CC      hw/net/e1000x_common.o
  CC      hw/net/net_tx_pkt.o
  CC      hw/net/net_rx_pkt.o
  CC      hw/net/e1000e.o
  CC      hw/net/e1000e_core.o
  CC      hw/net/rtl8139.o
  CC      hw/net/vmxnet3.o
  CC      hw/net/smc91c111.o
  CC      hw/net/lan9118.o
  CC      hw/net/ne2000-isa.o
  CC      hw/net/xgmac.o
  CC      hw/net/xilinx_axienet.o
  CC      hw/net/allwinner_emac.o
  CC      hw/net/imx_fec.o
  CC      hw/net/cadence_gem.o
  CC      hw/net/stellaris_enet.o
  CC      hw/net/ftgmac100.o
  CC      hw/net/rocker/rocker_fp.o
  CC      hw/net/rocker/rocker.o
  CC      hw/net/rocker/rocker_desc.o
  CC      hw/net/rocker/rocker_world.o
  CC      hw/net/rocker/rocker_of_dpa.o
  CC      hw/net/can/can_sja1000.o
  CC      hw/net/can/can_kvaser_pci.o
  CC      hw/net/can/can_pcm3680_pci.o
  CC      hw/net/can/can_mioe3680_pci.o
  CC      hw/nvram/eeprom93xx.o
  CC      hw/nvram/eeprom_at24c.o
  CC      hw/nvram/fw_cfg.o
  CC      hw/nvram/chrp_nvram.o
  CC      hw/pci-bridge/pci_bridge_dev.o
  CC      hw/pci-bridge/pcie_root_port.o
  CC      hw/pci-bridge/gen_pcie_root_port.o
  CC      hw/pci-bridge/pcie_pci_bridge.o
  CC      hw/pci-bridge/pci_expander_bridge.o
  CC      hw/pci-bridge/xio3130_upstream.o
  CC      hw/pci-bridge/xio3130_downstream.o
  CC      hw/pci-bridge/ioh3420.o
  CC      hw/pci-bridge/i82801b11.o
  CC      hw/pci-host/pam.o
  CC      hw/pci-host/versatile.o
  CC      hw/pci-host/piix.o
  CC      hw/pci-host/q35.o
  CC      hw/pci-host/gpex.o
  CC      hw/pci-host/designware.o
  CC      hw/pci/pci.o
  CC      hw/pci/pci_bridge.o
  CC      hw/pci/msix.o
  CC      hw/pci/msi.o
  CC      hw/pci/shpc.o
  CC      hw/pci/slotid_cap.o
  CC      hw/pci/pci_host.o
  CC      hw/pci/pcie_host.o
  CC      hw/pci/pcie.o
  CC      hw/pci/pcie_aer.o
  CC      hw/pci/pcie_port.o
  CC      hw/pci/pci-stub.o
  CC      hw/pcmcia/pcmcia.o
  CC      hw/scsi/scsi-disk.o
  CC      hw/scsi/scsi-generic.o
  CC      hw/scsi/scsi-bus.o
  CC      hw/scsi/lsi53c895a.o
  CC      hw/scsi/mptsas.o
  CC      hw/scsi/mptendian.o
  CC      hw/scsi/mptconfig.o
  CC      hw/scsi/megasas.o
  CC      hw/scsi/vmw_pvscsi.o
  CC      hw/scsi/esp.o
  CC      hw/scsi/esp-pci.o
  CC      hw/sd/pl181.o
  CC      hw/sd/ssi-sd.o
  CC      hw/sd/sd.o
  CC      hw/sd/core.o
  CC      hw/sd/sdmmc-internal.o
  CC      hw/sd/sdhci.o
  CC      hw/smbios/smbios.o
  CC      hw/smbios/smbios_type_38.o
  CC      hw/smbios/smbios-stub.o
  CC      hw/smbios/smbios_type_38-stub.o
  CC      hw/ssi/pl022.o
  CC      hw/ssi/ssi.o
  CC      hw/ssi/xilinx_spips.o
  CC      hw/ssi/aspeed_smc.o
  CC      hw/ssi/stm32f2xx_spi.o
  CC      hw/ssi/mss-spi.o
  CC      hw/timer/arm_timer.o
  CC      hw/timer/arm_mptimer.o
  CC      hw/timer/armv7m_systick.o
  CC      hw/timer/a9gtimer.o
  CC      hw/timer/cadence_ttc.o
  CC      hw/timer/ds1338.o
  CC      hw/timer/hpet.o
  CC      hw/timer/i8254_common.o
  CC      hw/timer/i8254.o
  CC      hw/timer/pl031.o
  CC      hw/timer/twl92230.o
  CC      hw/timer/imx_epit.o
  CC      hw/timer/imx_gpt.o
  CC      hw/timer/xlnx-zynqmp-rtc.o
  CC      hw/timer/stm32f2xx_timer.o
  CC      hw/timer/aspeed_timer.o
  CC      hw/timer/cmsdk-apb-timer.o
  CC      hw/timer/mss-timer.o
  CC      hw/tpm/tpm_util.o
  CC      hw/tpm/tpm_tis.o
  CC      hw/tpm/tpm_crb.o
  CC      hw/tpm/tpm_passthrough.o
  CC      hw/tpm/tpm_emulator.o
  CC      hw/usb/core.o
  CC      hw/usb/combined-packet.o
  CC      hw/usb/bus.o
  CC      hw/usb/libhw.o
  CC      hw/usb/desc.o
  CC      hw/usb/desc-msos.o
  CC      hw/usb/hcd-uhci.o
  CC      hw/usb/hcd-ohci.o
  CC      hw/usb/hcd-ehci.o
  CC      hw/usb/hcd-ehci-pci.o
  CC      hw/usb/hcd-ehci-sysbus.o
  CC      hw/usb/hcd-xhci.o
  CC      hw/usb/hcd-xhci-nec.o
  CC      hw/usb/hcd-musb.o
  CC      hw/usb/dev-hub.o
  CC      hw/usb/dev-hid.o
  CC      hw/usb/dev-wacom.o
  CC      hw/usb/dev-storage.o
  CC      hw/usb/dev-uas.o
  CC      hw/usb/dev-audio.o
  CC      hw/usb/dev-serial.o
  CC      hw/usb/dev-network.o
  CC      hw/usb/dev-bluetooth.o
  CC      hw/usb/dev-smartcard-reader.o
  CC      hw/usb/dev-mtp.o
  CC      hw/usb/host-stub.o
  CC      hw/virtio/virtio-rng.o
  CC      hw/virtio/virtio-pci.o
  CC      hw/virtio/virtio-bus.o
  CC      hw/virtio/virtio-mmio.o
  CC      hw/virtio/vhost-stub.o
  CC      hw/watchdog/watchdog.o
  CC      hw/watchdog/wdt_i6300esb.o
  CC      hw/watchdog/wdt_ib700.o
  CC      hw/watchdog/wdt_aspeed.o
  CC      migration/migration.o
  CC      migration/socket.o
  CC      migration/fd.o
  CC      migration/exec.o
  CC      migration/tls.o
  CC      migration/channel.o
  CC      migration/savevm.o
  CC      migration/colo-comm.o
  CC      migration/colo.o
  CC      migration/colo-failover.o
  CC      migration/vmstate.o
  CC      migration/vmstate-types.o
  CC      migration/page_cache.o
  CC      migration/qemu-file.o
  CC      migration/global_state.o
  CC      migration/qemu-file-channel.o
  CC      migration/xbzrle.o
  CC      migration/postcopy-ram.o
  CC      migration/qjson.o
  CC      migration/block-dirty-bitmap.o
  CC      migration/block.o
  CC      net/net.o
  CC      net/queue.o
  CC      net/checksum.o
  CC      net/util.o
  CC      net/hub.o
  CC      net/socket.o
  CC      net/dump.o
  CC      net/eth.o
  CC      net/l2tpv3.o
  CC      net/vhost-user.o
  CC      net/slirp.o
  CC      net/filter.o
  CC      net/filter-buffer.o
  CC      net/filter-mirror.o
  CC      net/colo-compare.o
  CC      net/colo.o
  CC      net/filter-rewriter.o
  CC      net/filter-replay.o
  CC      net/tap.o
  CC      net/tap-linux.o
  CC      net/can/can_core.o
  CC      net/can/can_host.o
  CC      net/can/can_socketcan.o
  CC      qom/cpu.o
  CC      replay/replay.o
  CC      replay/replay-internal.o
  CC      replay/replay-events.o
  CC      replay/replay-time.o
  CC      replay/replay-input.o
  CC      replay/replay-char.o
  CC      replay/replay-snapshot.o
  CC      replay/replay-net.o
  CC      replay/replay-audio.o
  CC      slirp/cksum.o
  CC      slirp/if.o
  CC      slirp/ip_icmp.o
  CC      slirp/ip6_icmp.o
  CC      slirp/ip6_input.o
  CC      slirp/ip6_output.o
  CC      slirp/ip_input.o
  CC      slirp/ip_output.o
  CC      slirp/dnssearch.o
  CC      slirp/dhcpv6.o
  CC      slirp/slirp.o
  CC      slirp/mbuf.o
  CC      slirp/misc.o
  CC      slirp/sbuf.o
  CC      slirp/socket.o
  CC      slirp/tcp_input.o
  CC      slirp/tcp_output.o
  CC      slirp/tcp_subr.o
  CC      slirp/tcp_timer.o
  CC      slirp/udp.o
  CC      slirp/udp6.o
/tmp/qemu-test/src/slirp/tcp_input.c: In function 'tcp_input':
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_p' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_len' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_tos' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_id' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_off' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_ttl' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_sum' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_src.s_addr' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_dst.s_addr' may be used uninitialized in this function
/tmp/qemu-test/src/slirp/tcp_input.c:220: warning: 'save_ip6.ip_nh' may be used uninitialized in this function
  CC      slirp/bootp.o
  CC      slirp/tftp.o
  CC      slirp/arp_table.o
  CC      slirp/ndp_table.o
  CC      slirp/ncsi.o
  CC      ui/keymaps.o
  CC      ui/console.o
  CC      ui/cursor.o
  CC      ui/qemu-pixman.o
  CC      ui/input.o
  CC      ui/input-keymap.o
  CC      ui/input-legacy.o
  CC      ui/input-linux.o
  CC      ui/vnc.o
  CC      ui/vnc-enc-zlib.o
  CC      ui/vnc-enc-hextile.o
  CC      ui/vnc-enc-tight.o
  CC      ui/vnc-palette.o
  CC      ui/vnc-enc-zrle.o
  CC      ui/vnc-auth-vencrypt.o
  CC      ui/vnc-ws.o
  CC      ui/vnc-jobs.o
  CC      ui/x_keymap.o
  CC      audio/ossaudio.o
  CC      ui/sdl.o
  CC      ui/sdl_zoom.o
  CC      chardev/char.o
  CC      chardev/char-fd.o
  CC      chardev/char-fe.o
  CC      chardev/char-file.o
  CC      chardev/char-io.o
  CC      chardev/char-mux.o
  CC      chardev/char-null.o
  CC      chardev/char-parallel.o
  CC      chardev/char-pipe.o
  CC      chardev/char-pty.o
  CC      chardev/char-ringbuf.o
  CC      chardev/char-serial.o
  CC      chardev/char-socket.o
  CC      chardev/char-stdio.o
  CC      chardev/char-udp.o
  LINK    tests/qemu-iotests/socket_scm_helper
  CC      qga/commands.o
  CC      qga/guest-agent-command-state.o
  CC      qga/main.o
  CC      qga/commands-posix.o
  CC      qga/channel-posix.o
  CC      qga/qapi-generated/qga-qapi-types.o
  CC      qga/qapi-generated/qga-qapi-visit.o
  AS      optionrom/multiboot.o
  CC      qga/qapi-generated/qga-qapi-commands.o
  AR      libqemuutil.a
  CC      qemu-img.o
  AS      optionrom/linuxboot.o
  CC      optionrom/linuxboot_dma.o
  AS      optionrom/kvmvapic.o
  BUILD   optionrom/multiboot.img
  BUILD   optionrom/linuxboot.img
  BUILD   optionrom/multiboot.raw
  BUILD   optionrom/linuxboot.raw
  BUILD   optionrom/kvmvapic.img
  BUILD   optionrom/kvmvapic.raw
  SIGN    optionrom/multiboot.bin
  SIGN    optionrom/linuxboot.bin
  SIGN    optionrom/kvmvapic.bin
cc: unrecognized option '-no-integrated-as'
cc: unrecognized option '-no-integrated-as'
  BUILD   optionrom/linuxboot_dma.img
  BUILD   optionrom/linuxboot_dma.raw
  SIGN    optionrom/linuxboot_dma.bin
  LINK    qemu-ga
  LINK    ivshmem-client
  LINK    ivshmem-server
  LINK    qemu-nbd
  LINK    qemu-img
  LINK    qemu-io
  LINK    scsi/qemu-pr-helper
  LINK    qemu-bridge-helper
  GEN     x86_64-softmmu/hmp-commands.h
  GEN     x86_64-softmmu/hmp-commands-info.h
  GEN     x86_64-softmmu/config-target.h
  CC      x86_64-softmmu/exec.o
  CC      x86_64-softmmu/tcg/tcg.o
  CC      x86_64-softmmu/tcg/tcg-op.o
  CC      x86_64-softmmu/tcg/tcg-op-vec.o
  CC      x86_64-softmmu/tcg/tcg-op-gvec.o
  CC      x86_64-softmmu/tcg/tcg-common.o
  CC      x86_64-softmmu/tcg/optimize.o
  CC      x86_64-softmmu/fpu/softfloat.o
  CC      x86_64-softmmu/disas.o
  GEN     x86_64-softmmu/gdbstub-xml.c
  CC      x86_64-softmmu/arch_init.o
  CC      x86_64-softmmu/cpus.o
  GEN     aarch64-softmmu/hmp-commands.h
/tmp/qemu-test/src/fpu/softfloat.c: In function 'int_to_float':
/tmp/qemu-test/src/fpu/softfloat.c:1520: warning: 'r.exp' may be used uninitialized in this function
/tmp/qemu-test/src/fpu/softfloat.c:1520: warning: 'r.frac' may be used uninitialized in this function
  GEN     aarch64-softmmu/hmp-commands-info.h
  GEN     aarch64-softmmu/config-target.h
  CC      x86_64-softmmu/monitor.o
  CC      x86_64-softmmu/gdbstub.o
  CC      aarch64-softmmu/exec.o
  CC      x86_64-softmmu/balloon.o
  CC      aarch64-softmmu/tcg/tcg.o
  CC      x86_64-softmmu/ioport.o
  CC      aarch64-softmmu/tcg/tcg-op.o
  CC      aarch64-softmmu/tcg/tcg-op-vec.o
  CC      aarch64-softmmu/tcg/tcg-op-gvec.o
  CC      aarch64-softmmu/tcg/tcg-common.o
  CC      aarch64-softmmu/tcg/optimize.o
  CC      aarch64-softmmu/fpu/softfloat.o
  CC      x86_64-softmmu/numa.o
  CC      aarch64-softmmu/disas.o
  GEN     aarch64-softmmu/gdbstub-xml.c
  CC      x86_64-softmmu/qtest.o
/tmp/qemu-test/src/fpu/softfloat.c: In function 'int_to_float':
/tmp/qemu-test/src/fpu/softfloat.c:1520: warning: 'r.exp' may be used uninitialized in this function
/tmp/qemu-test/src/fpu/softfloat.c:1520: warning: 'r.frac' may be used uninitialized in this function
  CC      x86_64-softmmu/memory.o
  CC      x86_64-softmmu/memory_mapping.o
  CC      x86_64-softmmu/dump.o
  CC      aarch64-softmmu/arch_init.o
  CC      aarch64-softmmu/cpus.o
  CC      aarch64-softmmu/monitor.o
  CC      aarch64-softmmu/gdbstub.o
  CC      aarch64-softmmu/balloon.o
  CC      x86_64-softmmu/migration/ram.o
  CC      aarch64-softmmu/ioport.o
  CC      aarch64-softmmu/numa.o
  CC      x86_64-softmmu/accel/accel.o
  CC      aarch64-softmmu/qtest.o
  CC      aarch64-softmmu/memory.o
  CC      x86_64-softmmu/accel/kvm/kvm-all.o
  CC      x86_64-softmmu/accel/stubs/hax-stub.o
  CC      x86_64-softmmu/accel/stubs/hvf-stub.o
  CC      aarch64-softmmu/memory_mapping.o
  CC      aarch64-softmmu/dump.o
  CC      aarch64-softmmu/migration/ram.o
  CC      aarch64-softmmu/accel/accel.o
  CC      aarch64-softmmu/accel/stubs/hax-stub.o
  CC      aarch64-softmmu/accel/stubs/hvf-stub.o
  CC      x86_64-softmmu/accel/stubs/whpx-stub.o
  CC      x86_64-softmmu/accel/tcg/tcg-all.o
  CC      aarch64-softmmu/accel/stubs/whpx-stub.o
  CC      x86_64-softmmu/accel/tcg/cputlb.o
  CC      aarch64-softmmu/accel/stubs/kvm-stub.o
  CC      aarch64-softmmu/accel/tcg/tcg-all.o
  CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
  CC      x86_64-softmmu/accel/tcg/tcg-runtime-gvec.o
  CC      x86_64-softmmu/accel/tcg/cpu-exec.o
  CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
  CC      aarch64-softmmu/accel/tcg/cputlb.o
  CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
  CC      aarch64-softmmu/accel/tcg/tcg-runtime-gvec.o
  CC      aarch64-softmmu/accel/tcg/cpu-exec.o
  CC      x86_64-softmmu/accel/tcg/translate-all.o
  CC      x86_64-softmmu/accel/tcg/translator.o
  CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
  CC      aarch64-softmmu/accel/tcg/translate-all.o
  CC      aarch64-softmmu/accel/tcg/translator.o
  CC      x86_64-softmmu/hw/block/virtio-blk.o
  CC      aarch64-softmmu/hw/block/virtio-blk.o
  CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
  CC      aarch64-softmmu/hw/block/vhost-user-blk.o
  CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
  CC      x86_64-softmmu/hw/block/vhost-user-blk.o
  CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
  CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
  CC      aarch64-softmmu/hw/char/exynos4210_uart.o
  CC      aarch64-softmmu/hw/char/omap_uart.o
  CC      aarch64-softmmu/hw/char/digic-uart.o
  CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
  CC      aarch64-softmmu/hw/char/bcm2835_aux.o
  CC      x86_64-softmmu/hw/core/generic-loader.o
  CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
  CC      aarch64-softmmu/hw/core/generic-loader.o
  CC      aarch64-softmmu/hw/core/null-machine.o
  CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
  CC      x86_64-softmmu/hw/core/null-machine.o
  CC      x86_64-softmmu/hw/display/vga.o
  CC      x86_64-softmmu/hw/display/virtio-gpu.o
  CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
  CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
  CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
  CC      aarch64-softmmu/hw/cpu/a9mpcore.o
  CC      x86_64-softmmu/hw/display/virtio-vga.o
  CC      x86_64-softmmu/hw/intc/apic.o
  CC      x86_64-softmmu/hw/intc/apic_common.o
  CC      x86_64-softmmu/hw/intc/ioapic.o
  CC      aarch64-softmmu/hw/cpu/a15mpcore.o
  CC      x86_64-softmmu/hw/isa/lpc_ich9.o
  CC      x86_64-softmmu/hw/misc/ivshmem.o
  CC      x86_64-softmmu/hw/misc/pvpanic.o
  CC      aarch64-softmmu/hw/display/omap_dss.o
  CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
  CC      aarch64-softmmu/hw/display/omap_lcdc.o
  CC      x86_64-softmmu/hw/misc/mmio_interface.o
  CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
  CC      x86_64-softmmu/hw/net/virtio-net.o
  CC      x86_64-softmmu/hw/net/vhost_net.o
  CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
  CC      aarch64-softmmu/hw/display/bcm2835_fb.o
  CC      aarch64-softmmu/hw/display/vga.o
  CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      aarch64-softmmu/hw/display/virtio-gpu.o
  CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
  CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
  CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
  CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
  CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
  CC      aarch64-softmmu/hw/display/dpcd.o
  CC      x86_64-softmmu/hw/timer/mc146818rtc.o
  CC      aarch64-softmmu/hw/display/xlnx_dp.o
  CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
  CC      x86_64-softmmu/hw/vfio/common.o
  CC      aarch64-softmmu/hw/dma/omap_dma.o
  CC      x86_64-softmmu/hw/vfio/pci.o
  CC      aarch64-softmmu/hw/dma/soc_dma.o
  CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
  CC      x86_64-softmmu/hw/vfio/pci-quirks.o
  CC      x86_64-softmmu/hw/vfio/display.o
  CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
  CC      x86_64-softmmu/hw/vfio/platform.o
  CC      x86_64-softmmu/hw/vfio/spapr.o
  CC      x86_64-softmmu/hw/virtio/virtio.o
  CC      aarch64-softmmu/hw/gpio/omap_gpio.o
  CC      aarch64-softmmu/hw/gpio/imx_gpio.o
  CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
  CC      aarch64-softmmu/hw/i2c/omap_i2c.o
  CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
  CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
  CC      aarch64-softmmu/hw/input/tsc210x.o
  CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
  CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
  CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
  CC      x86_64-softmmu/hw/virtio/vhost.o
  CC      aarch64-softmmu/hw/intc/omap_intc.o
  CC      x86_64-softmmu/hw/virtio/vhost-backend.o
  CC      x86_64-softmmu/hw/virtio/vhost-user.o
  CC      x86_64-softmmu/hw/virtio/virtio-pmem.o
  CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:10:34: error: hw/mem/memory-device.h: No such file or directory
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c: In function 'virtio_pmem_realize':
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:65: warning: implicit declaration of function 'memory_device_get_free_addr'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:65: warning: nested extern declaration of 'memory_device_get_free_addr'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:75: warning: implicit declaration of function 'memory_device_plug_region'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:75: warning: nested extern declaration of 'memory_device_plug_region'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c: At top level:
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:112: warning: type defaults to 'int' in declaration of 'MemoryDeviceState'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:112: error: expected ';', ',' or ')' before '*' token
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:133: warning: type defaults to 'int' in declaration of 'MemoryDeviceState'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:133: error: expected ';', ',' or ')' before '*' token
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:140: warning: type defaults to 'int' in declaration of 'MemoryDeviceState'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:140: error: expected ';', ',' or ')' before '*' token
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:147: warning: type defaults to 'int' in declaration of 'MemoryDeviceState'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:147: error: expected ';', ',' or ')' before '*' token
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c: In function 'virtio_pmem_class_init':
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: error: 'MemoryDeviceClass' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: error: (Each undeclared identifier is reported only once
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: error: for each function it appears in.)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: error: 'mdc' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: warning: implicit declaration of function 'MEMORY_DEVICE_CLASS'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:168: warning: nested extern declaration of 'MEMORY_DEVICE_CLASS'
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:174: error: 'virtio_pmem_md_get_addr' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:175: error: 'virtio_pmem_md_get_plugged_size' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:176: error: 'virtio_pmem_md_get_region_size' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:177: error: 'virtio_pmem_md_fill_device_info' undeclared (first use in this function)
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c: At top level:
/tmp/qemu-test/src/hw/virtio/virtio-pmem.c:187: error: 'TYPE_MEMORY_DEVICE' undeclared here (not in a function)
  CC      aarch64-softmmu/hw/intc/bcm2836_control.o
make[1]: *** [hw/virtio/virtio-pmem.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
  CC      aarch64-softmmu/hw/intc/aspeed_vic.o
  CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
  CC      aarch64-softmmu/hw/misc/ivshmem.o
  CC      aarch64-softmmu/hw/misc/arm_sysctl.o
  CC      aarch64-softmmu/hw/misc/cbus.o
make: *** [subdir-x86_64-softmmu] Error 2
make: *** Waiting for unfinished jobs....
  CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
  CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
  CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
  CC      aarch64-softmmu/hw/misc/imx_ccm.o
  CC      aarch64-softmmu/hw/misc/imx31_ccm.o
  CC      aarch64-softmmu/hw/misc/imx25_ccm.o
  CC      aarch64-softmmu/hw/misc/imx6_ccm.o
  CC      aarch64-softmmu/hw/misc/imx6_src.o
  CC      aarch64-softmmu/hw/misc/imx7_ccm.o
  CC      aarch64-softmmu/hw/misc/imx2_wdt.o
  CC      aarch64-softmmu/hw/misc/imx7_snvs.o
  CC      aarch64-softmmu/hw/misc/imx7_gpr.o
  CC      aarch64-softmmu/hw/misc/mst_fpga.o
  CC      aarch64-softmmu/hw/misc/omap_clk.o
  CC      aarch64-softmmu/hw/misc/omap_gpmc.o
  CC      aarch64-softmmu/hw/misc/omap_l4.o
  CC      aarch64-softmmu/hw/misc/omap_sdrc.o
  CC      aarch64-softmmu/hw/misc/omap_tap.o
  CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
  CC      aarch64-softmmu/hw/misc/bcm2835_property.o
  CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
  CC      aarch64-softmmu/hw/misc/zynq_slcr.o
  CC      aarch64-softmmu/hw/misc/zynq-xadc.o
  CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
  CC      aarch64-softmmu/hw/misc/mps2-fpgaio.o
  CC      aarch64-softmmu/hw/misc/mps2-scc.o
  CC      aarch64-softmmu/hw/misc/tz-ppc.o
  CC      aarch64-softmmu/hw/misc/iotkit-secctl.o
  CC      aarch64-softmmu/hw/misc/auxbus.o
  CC      aarch64-softmmu/hw/misc/aspeed_scu.o
  CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
  CC      aarch64-softmmu/hw/misc/mmio_interface.o
  CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
  CC      aarch64-softmmu/hw/net/virtio-net.o
  CC      aarch64-softmmu/hw/net/vhost_net.o
  CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
  CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
  CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
  CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
  CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
  CC      aarch64-softmmu/hw/sd/omap_mmc.o
  CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
  CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
  CC      aarch64-softmmu/hw/ssi/omap_spi.o
  CC      aarch64-softmmu/hw/ssi/imx_spi.o
  CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
  CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
  CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
  CC      aarch64-softmmu/hw/timer/omap_gptimer.o
  CC      aarch64-softmmu/hw/timer/omap_synctimer.o
  CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
  CC      aarch64-softmmu/hw/timer/digic-timer.o
  CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
  CC      aarch64-softmmu/hw/usb/tusb6010.o
  CC      aarch64-softmmu/hw/usb/chipidea.o
  CC      aarch64-softmmu/hw/vfio/common.o
  CC      aarch64-softmmu/hw/vfio/pci.o
  CC      aarch64-softmmu/hw/vfio/pci-quirks.o
  CC      aarch64-softmmu/hw/vfio/display.o
  CC      aarch64-softmmu/hw/vfio/platform.o
  CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
  CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
  CC      aarch64-softmmu/hw/vfio/spapr.o
  CC      aarch64-softmmu/hw/virtio/virtio.o
  CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
  CC      aarch64-softmmu/hw/virtio/vhost.o
  CC      aarch64-softmmu/hw/virtio/vhost-backend.o
  CC      aarch64-softmmu/hw/virtio/vhost-user.o
  CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
  CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
  CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
  CC      aarch64-softmmu/hw/arm/boot.o
  CC      aarch64-softmmu/hw/arm/virt.o
  CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
  CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
  CC      aarch64-softmmu/hw/arm/digic_boards.o
  CC      aarch64-softmmu/hw/arm/exynos4_boards.o
  CC      aarch64-softmmu/hw/arm/highbank.o
  CC      aarch64-softmmu/hw/arm/integratorcp.o
  CC      aarch64-softmmu/hw/arm/mainstone.o
  CC      aarch64-softmmu/hw/arm/musicpal.o
  CC      aarch64-softmmu/hw/arm/netduino2.o
  CC      aarch64-softmmu/hw/arm/nseries.o
  CC      aarch64-softmmu/hw/arm/omap_sx1.o
  CC      aarch64-softmmu/hw/arm/palm.o
  CC      aarch64-softmmu/hw/arm/gumstix.o
  CC      aarch64-softmmu/hw/arm/spitz.o
  CC      aarch64-softmmu/hw/arm/tosa.o
  CC      aarch64-softmmu/hw/arm/z2.o
  CC      aarch64-softmmu/hw/arm/realview.o
  CC      aarch64-softmmu/hw/arm/stellaris.o
  CC      aarch64-softmmu/hw/arm/collie.o
  CC      aarch64-softmmu/hw/arm/versatilepb.o
  CC      aarch64-softmmu/hw/arm/vexpress.o
  CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
  CC      aarch64-softmmu/hw/arm/armv7m.o
  CC      aarch64-softmmu/hw/arm/exynos4210.o
  CC      aarch64-softmmu/hw/arm/pxa2xx.o
  CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
  CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
  CC      aarch64-softmmu/hw/arm/digic.o
  CC      aarch64-softmmu/hw/arm/omap1.o
  CC      aarch64-softmmu/hw/arm/omap2.o
  CC      aarch64-softmmu/hw/arm/strongarm.o
  CC      aarch64-softmmu/hw/arm/allwinner-a10.o
  CC      aarch64-softmmu/hw/arm/cubieboard.o
  CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
  CC      aarch64-softmmu/hw/arm/bcm2836.o
  CC      aarch64-softmmu/hw/arm/raspi.o
  CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
  CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
  CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
  CC      aarch64-softmmu/hw/arm/fsl-imx25.o
  CC      aarch64-softmmu/hw/arm/imx25_pdk.o
  CC      aarch64-softmmu/hw/arm/fsl-imx31.o
  CC      aarch64-softmmu/hw/arm/kzm.o
  CC      aarch64-softmmu/hw/arm/fsl-imx6.o
  CC      aarch64-softmmu/hw/arm/sabrelite.o
  CC      aarch64-softmmu/hw/arm/aspeed_soc.o
  CC      aarch64-softmmu/hw/arm/aspeed.o
  CC      aarch64-softmmu/hw/arm/mps2.o
  CC      aarch64-softmmu/hw/arm/mps2-tz.o
  CC      aarch64-softmmu/hw/arm/msf2-soc.o
  CC      aarch64-softmmu/hw/arm/msf2-som.o
  CC      aarch64-softmmu/hw/arm/iotkit.o
  CC      aarch64-softmmu/hw/arm/fsl-imx7.o
  CC      aarch64-softmmu/hw/arm/mcimx7d-sabre.o
  CC      aarch64-softmmu/target/arm/arm-semi.o
  CC      aarch64-softmmu/target/arm/machine.o
  CC      aarch64-softmmu/target/arm/psci.o
  CC      aarch64-softmmu/target/arm/arch_dump.o
  CC      aarch64-softmmu/target/arm/monitor.o
  CC      aarch64-softmmu/target/arm/kvm-stub.o
  CC      aarch64-softmmu/target/arm/translate.o
  CC      aarch64-softmmu/target/arm/op_helper.o
  CC      aarch64-softmmu/target/arm/helper.o
  CC      aarch64-softmmu/target/arm/cpu.o
  CC      aarch64-softmmu/target/arm/neon_helper.o
  CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
  CC      aarch64-softmmu/target/arm/vec_helper.o
  CC      aarch64-softmmu/target/arm/gdbstub.o
  CC      aarch64-softmmu/target/arm/cpu64.o
  CC      aarch64-softmmu/target/arm/translate-a64.o
  CC      aarch64-softmmu/target/arm/helper-a64.o
  CC      aarch64-softmmu/target/arm/gdbstub64.o
  CC      aarch64-softmmu/target/arm/crypto_helper.o
  CC      aarch64-softmmu/target/arm/arm-powerctl.o
/tmp/qemu-test/src/target/arm/translate-a64.c: In function 'handle_shri_with_rndacc':
/tmp/qemu-test/src/target/arm/translate-a64.c:6662: warning: 'tcg_src_hi' may be used uninitialized in this function
/tmp/qemu-test/src/target/arm/translate-a64.c: In function 'disas_simd_two_reg_misc_fp16':
/tmp/qemu-test/src/target/arm/translate-a64.c:11727: warning: 'rmode' may be used uninitialized in this function
/tmp/qemu-test/src/target/arm/translate-a64.c: In function 'disas_simd_scalar_two_reg_misc':
/tmp/qemu-test/src/target/arm/translate-a64.c:8621: warning: 'rmode' may be used uninitialized in this function
  GEN     trace/generated-helpers.c
  CC      aarch64-softmmu/trace/control-target.o
  CC      aarch64-softmmu/gdbstub-xml.o
  CC      aarch64-softmmu/trace/generated-helpers.o
  LINK    aarch64-softmmu/qemu-system-aarch64
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 407, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 404, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 261, in run
    return Docker().run(argv, args.keep, quiet=args.quiet)
  File "./tests/docker/docker.py", line 229, in run
    quiet=quiet)
  File "./tests/docker/docker.py", line 147, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=dbbe87ba487d11e89d3e52540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-sqsog4o6/src/docker-src.2018-04-25-07.43.07.4422:/var/tmp/qemu:z,ro', 'qemu:min-glib', '/var/tmp/qemu/run', 'test-build']' returned non-zero exit status 2
make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-sqsog4o6/src'
make: *** [tests/docker/Makefile.include:163: docker-run-test-build@min-glib] Error 2

real	2m59.857s
user	0m4.334s
sys	0m3.953s
=== OUTPUT END ===

Test command exited with code: 2


---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel@redhat.com
