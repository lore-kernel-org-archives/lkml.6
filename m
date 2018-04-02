Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeDBO0O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:26:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:47886 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeDBO0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:26:11 -0400
Date: Mon, 2 Apr 2018 08:26:09 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [PULL] Documentation for 4.17
Message-ID: <20180402082609.5dc13279@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.17

for you to fetch changes up to 86afad7d87f535ebb1a0e978bc32a8c58ac99268:

  Documentation/process: update FUSE project website (2018-03-29 15:49:18 -0600)

----------------------------------------------------------------
There's been a fair amount of activity in Documentation/ this time around:

 - Lots of work aligning Documentation/ABI with reality, done by Aishwarya
   Pant.

 - The trace documentation has been converted to RST by Changbin Du

 - I thrashed up kernel-doc to deal with a parsing issue and to try to make
   the code more readable.  It's still a 20+-year-old Perl hack, though.

 - Lots of other updates, typo fixes, and more.

Expect some annoying merge conflicts with ftrace - changes in
Documentation/trace were made independently of the RST conversion.
Probably the conversion should have gone through that tree as well, in
retrospect.  The resolution in linux-next seems good.
----------------------------------------------------------------
Aaro Koskinen (1):
      documentation: add my name to kernel driver statement

Aishwarya Pant (13):
      Documentation/ABI: clean up sysfs-class-pktcdvd
      Documentation/ABI: add sysfs interface for s6e63m0 lcd driver
      aoe: document sysfs interface
      Documentation/ABI: update infiniband sysfs interfaces
      block/loop: add documentation for sysfs interface
      backlight: lm3639: document sysfs attributes
      backlight: adp5520: document sysfs attributes
      backlight: adp8860: document sysfs attributes
      Documentation: rapidio: move sysfs interface to ABI
      block: rbd: update sysfs interface
      acpi: nfit: document sysfs interface
      char/bsr: add sysfs interface documentation
      Input: trackpoint: document sysfs interface

Andy Shevchenko (3):
      dmaengine: Add note to dmatest documentation about supported channels
      dmaengine: Make dmatest.rst indeed reST compatible
      dmaengine: Fix spelling for parenthesis in dmatest documentation

Changbin Du (17):
      Documentation: add Linux tracing to Sphinx TOC tree
      trace doc: convert trace/ftrace-design.txt to rst format
      trace doc: add ftrace-uses.rst to doc tree
      trace doc: convert trace/tracepoint-analysis.txt to rst format
      trace doc: convert trace/ftrace.txt to rst format
      trace doc: convert trace/kprobetrace.txt to rst format
      trace doc: convert trace/uprobetracer.txt to rst format
      trace doc: convert trace/tracepoints.txt to rst format
      trace doc: convert trace/events.txt to rst format
      trace doc: convert trace/events-kmem.txt to rst format
      trace doc: convert trace/events-power.txt to rst format
      trace doc: convert trace/events-nmi.txt to rst format
      trace doc: convert trace/events-msr.txt to rst format
      trace doc: convert trace/mmiotrace.txt to rst format
      trace doc: convert trace/hwlat_detector.txt to rst fromat
      trace doc: convert trace/intel_th.txt to rst format
      trace doc: convert trace/stm.txt to rst format

Dave Hansen (1):
      docs: clarify security-bugs disclosure policy

Dominik Brodowski (1):
      Documentation/process: Co-developed-by instead of Co-Developed-by

Eric Engestrom (1):
      Documentation/sparse: fix typo

Gary R Hook (1):
      Documentation/CodingStyle: Add an example for braces

Joel Stanley (1):
      Documentation: Mention why %p prints ptrval

Jonathan Corbet (12):
      docs: kernel-doc: Get rid of xml_escape() and friends
      docs: kernel-doc: Rename and split STATE_FIELD
      docs: kernel-doc: Move STATE_NORMAL processing into its own function
      docs: kernel-doc: Move STATE_NAME processing into its own function
      docs: kernel-doc: Move STATE_BODY processing to a separate function
      docs: kernel-doc: Move STATE_PROTO processing into its own function
      docs: kernel-doc: Finish moving STATE_* code out of process_file()
      docs: kernel-doc: Don't mangle literal code blocks in comments
      docs: Add an SPDX header to kernel-doc
      Merge branch 'kerneldoc2' into docs-next
      docs: ftrace: fix a few formatting issues
      Docs: Added a pointer to the formatted docs to README

Jonathan Neuschäfer (2):
      Documentation/process/howto: Remove outdated info about bugzilla mailing lists
      admin-guide: Fix list formatting in tained-kernels.html

Martin Kepplinger (4):
      README: Improve documentation descriptions
      Documentation: admin-guide: add kvmconfig, xenconfig and tinyconfig commands
      Documentation: magic-numbers: Fix typo
      Documentation/process: update FUSE project website

Masanari Iida (2):
      linux-next: SLIMbus: doc: Fix a warning "Title underline too short"
      xfs: Change URL for the project in xfs.txt

Matthew Wilcox (7):
      Add documentation for Context section
      Minor fixes to kernel-doc.rst
      Add scripts/split-man.pl
      Fix whitespace in example
      Restructure kernel-doc.rst
      Documentation/sphinx: Fix Directive import error
      kernel-doc: Remove __sched markings

Mauro Carvalho Chehab (8):
      doc-guide: kernel-doc: fix example for nested_foobar struct
      doc-guide: kernel-doc: fix example for inlined comments
      doc-guide: kernel-doc: move in-line section to be after nested struct
      scripts: kernel-doc: support in-line comments on nested structs/unions
      doc-guide: kernel-doc: add examples about nested union/structs
      COPYING: create a new file with points to the Kernel license files
      COPYING: use the new text with points to the license files
      docs: kernel-doc: fix parsing of arrays

Mike Rapoport (3):
      scripts: kernel_doc: fixup reporting of function identifiers
      doc-guide: kernel-doc: add comment about formatting verification
      docs/vm: update 00-INDEX

Minghui Liu (1):
      Documentation: Delete reference to the kernel-mentors mailing list

Pali Rohár (1):
      Input: alps - Update documentation for trackstick v3 format

Philipp Hahn (2):
      doc: Rename .system_keyring to .builtin_trusted_keys
      doc: module-signing.rst: Fix reST formatting

Tobin C. Harding (1):
      docs: add Co-Developed-by docs

Xiongwei Song (1):
      tracing: Fix incorrect file name

 COPYING                                            |  358 +--
 Documentation/ABI/stable/sysfs-class-infiniband    |  818 +++++
 Documentation/ABI/testing/sysfs-block-aoe          |   45 +
 Documentation/ABI/testing/sysfs-block-loop         |   50 +
 Documentation/ABI/testing/sysfs-bus-nfit           |  233 ++
 Documentation/ABI/testing/sysfs-bus-rapidio        |  198 ++
 Documentation/ABI/testing/sysfs-bus-rbd            |  203 +-
 .../ABI/testing/sysfs-class-backlight-adp5520      |   31 +
 .../ABI/testing/sysfs-class-backlight-adp8860      |   54 +
 .../ABI/testing/sysfs-class-backlight-lm3639       |   11 +
 Documentation/ABI/testing/sysfs-class-bsr          |   25 +
 Documentation/ABI/testing/sysfs-class-infiniband   |   16 -
 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0  |   27 +
 Documentation/ABI/testing/sysfs-class-pktcdvd      |  129 +-
 Documentation/ABI/testing/sysfs-class-rapidio      |   55 +
 .../ABI/testing/sysfs-devices-platform-trackpoint  |  115 +
 Documentation/admin-guide/README.rst               |    7 +
 Documentation/admin-guide/module-signing.rst       |   10 +-
 Documentation/admin-guide/security-bugs.rst        |   24 +-
 Documentation/admin-guide/tainted-kernels.rst      |   18 +-
 Documentation/core-api/printk-formats.rst          |    4 +-
 Documentation/dev-tools/sparse.rst                 |    2 +-
 Documentation/doc-guide/kernel-doc.rst             |  555 ++--
 Documentation/driver-api/dmaengine/dmatest.rst     |   40 +-
 Documentation/driver-api/slimbus.rst               |    2 +-
 Documentation/filesystems/xfs.txt                  |    2 +-
 Documentation/index.rst                            |    1 +
 Documentation/infiniband/sysfs.txt                 |  129 +-
 Documentation/input/devices/alps.rst               |    7 +-
 Documentation/process/5.Posting.rst                |    2 +-
 Documentation/process/changes.rst                  |    2 +-
 Documentation/process/coding-style.rst             |    9 +
 Documentation/process/howto.rst                    |   15 -
 Documentation/process/kernel-driver-statement.rst  |    1 +
 Documentation/process/license-rules.rst            |   20 +-
 Documentation/process/magic-number.rst             |    2 +-
 Documentation/process/submitting-patches.rst       |    9 +-
 Documentation/rapidio/sysfs.txt                    |  161 +-
 Documentation/sphinx/kerneldoc.py                  |    3 +-
 .../trace/{events-kmem.txt => events-kmem.rst}     |   50 +-
 Documentation/trace/events-msr.rst                 |   40 +
 Documentation/trace/events-msr.txt                 |   37 -
 Documentation/trace/events-nmi.rst                 |   45 +
 Documentation/trace/events-nmi.txt                 |   43 -
 .../trace/{events-power.txt => events-power.rst}   |   52 +-
 Documentation/trace/{events.txt => events.rst}     |  677 ++--
 .../trace/{ftrace-design.txt => ftrace-design.rst} |  252 +-
 Documentation/trace/ftrace-uses.rst                |   23 +-
 Documentation/trace/ftrace.rst                     | 3332 ++++++++++++++++++++
 Documentation/trace/ftrace.txt                     | 3220 -------------------
 .../{hwlat_detector.txt => hwlat_detector.rst}     |   26 +-
 Documentation/trace/index.rst                      |   23 +
 Documentation/trace/{intel_th.txt => intel_th.rst} |   43 +-
 .../trace/{kprobetrace.txt => kprobetrace.rst}     |  100 +-
 .../trace/{mmiotrace.txt => mmiotrace.rst}         |   86 +-
 Documentation/trace/{stm.txt => stm.rst}           |   23 +-
 ...epoint-analysis.txt => tracepoint-analysis.rst} |   41 +-
 .../trace/{tracepoints.txt => tracepoints.rst}     |   77 +-
 .../trace/{uprobetracer.txt => uprobetracer.rst}   |   44 +-
 Documentation/vm/00-INDEX                          |   18 +
 README                                             |   11 +-
 scripts/kernel-doc                                 |  671 ++--
 scripts/split-man.pl                               |   28 +
 63 files changed, 6901 insertions(+), 5454 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-infiniband
 create mode 100644 Documentation/ABI/testing/sysfs-block-aoe
 create mode 100644 Documentation/ABI/testing/sysfs-block-loop
 create mode 100644 Documentation/ABI/testing/sysfs-bus-nfit
 create mode 100644 Documentation/ABI/testing/sysfs-bus-rapidio
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639
 create mode 100644 Documentation/ABI/testing/sysfs-class-bsr
 delete mode 100644 Documentation/ABI/testing/sysfs-class-infiniband
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
 create mode 100644 Documentation/ABI/testing/sysfs-class-rapidio
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-trackpoint
 rename Documentation/trace/{events-kmem.txt => events-kmem.rst} (76%)
 create mode 100644 Documentation/trace/events-msr.rst
 delete mode 100644 Documentation/trace/events-msr.txt
 create mode 100644 Documentation/trace/events-nmi.rst
 delete mode 100644 Documentation/trace/events-nmi.txt
 rename Documentation/trace/{events-power.txt => events-power.rst} (65%)
 rename Documentation/trace/{events.txt => events.rst} (82%)
 rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (74%)
 create mode 100644 Documentation/trace/ftrace.rst
 delete mode 100644 Documentation/trace/ftrace.txt
 rename Documentation/trace/{hwlat_detector.txt => hwlat_detector.rst} (83%)
 create mode 100644 Documentation/trace/index.rst
 rename Documentation/trace/{intel_th.txt => intel_th.rst} (82%)
 rename Documentation/trace/{kprobetrace.txt => kprobetrace.rst} (63%)
 rename Documentation/trace/{mmiotrace.txt => mmiotrace.rst} (78%)
 rename Documentation/trace/{stm.txt => stm.rst} (91%)
 rename Documentation/trace/{tracepoint-analysis.txt => tracepoint-analysis.rst} (93%)
 rename Documentation/trace/{tracepoints.txt => tracepoints.rst} (74%)
 rename Documentation/trace/{uprobetracer.txt => uprobetracer.rst} (86%)
 create mode 100755 scripts/split-man.pl
