Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF985C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A904620652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A904620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeJWQdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:33:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:44844 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbeJWQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:33:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 231E230A;
        Tue, 23 Oct 2018 08:11:29 +0000 (UTC)
Date:   Tue, 23 Oct 2018 02:11:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 4.20 (or whatever it's called)
Message-ID: <20181023021126.41bdb1e0@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.20

for you to fetch changes up to aea74de4b216cdacda797d54220b8ac19daa1bf7:

  docs: Fix typos in histogram.rst (2018-10-18 12:33:08 -0600)

----------------------------------------------------------------
This is a fairly typical cycle for documentation.  There's some welcome
readability improvements for the formatted output, some LICENSES updates
including the addition of the ISC license, the removal of the unloved and
unmaintained 00-INDEX files, the deprecated APIs document from Kees, more
MM docs from Mike Rapoport, and the usual pile of typo fixes and
corrections.

----------------------------------------------------------------
Akinobu Mita (1):
      docs: fix typo in table describing 4.16 development cycle

Anders Roxell (1):
      doc: dev-tools: kselftest.rst: update config file location

Andrew Murray (1):
      Documentation: preempt-locking: Use better example

Baoquan He (1):
      docs/vm/hmm.rst: Add missed space

Darrick J. Wong (1):
      docs: improve readability for people with poorer eyesight

David Hildenbrand (1):
      docs/core-api: memory-hotplug: add some details about locking internals

Felix Eckhofer (1):
      doc: Fix acronym "FEKEK" in ecryptfs

Geert Uytterhoeven (1):
      doc: printk-formats: Remove bogus kobject references for device nodes

Grant Likely (1):
      efi_stub: update documentation on dtb= parameter

Guillaume Dore (1):
      doc: fix a typo in adding-syscalls.rst

Hans de Goede (2):
      LICENSES: Add note to CDDL-1.0 license that it should not be used
      LICENSES: Add ISC license text

Henrik Austad (1):
      Drop all 00-INDEX files from Documentation/

Himanshu Jha (1):
      docs: dev-tools: coccinelle: Update documentation

John Garry (1):
      docs/completion.txt: Fix a couple of punctuation nits

Kees Cook (1):
      docs: Introduce deprecated APIs list

Markus Heiser (1):
      docs: tidy up TOCs and refs to license-rules.rst

Masami Hiramatsu (1):
      docs: tracing: Add stacktrace filter command

Masanari Iida (1):
      docs: Fix typos in histogram.rst

Mauro Carvalho Chehab (1):
      docs: fix some broken documentation references

Mike Rapoport (8):
      docs/boot-time-mm: fix kernel-doc directive for including all but DOC:
      docs: core-api/gfp_mask-from-fs-io: add a label for cross-referencing
      docs: core-api/mm-api: add a lable for GFP flags section
      docs: core-api: add memory allocation guide
      docs: move memory hotplug description into admin-guide/mm
      docs/vm: split memory hotplug notifier description to Documentation/core-api
      docs/core-api: rename memory-hotplug-notifier to memory-hotplug
      docs/admin-guide: memory-hotplug: remove table of contents

Nikolay Borisov (1):
      dm flakey: Document "error_writes" feature

Randy Dunlap (6):
      Documentation/fb/vesafb.txt: "inverse" option corrections
      FireWire: clean up firewire-cdev.h kernel-doc
      FireWire: clean up core-iso.c kernel-doc
      FireWire: clean up core-transaction.c kernel-doc
      FireWire: add a Documentation driver-api chapter
      kernel-doc: fix declaration type determination

Robin Murphy (1):
      iommu: Fix passthrough option documentation

Salvatore Bonaccorso (1):
      Documentation/l1tf: Fix small spelling typo

Takashi Sakamoto (1):
      FireWire: add driver-api Introduction section

Wolfram Sang (2):
      MAINTAINERS: sort excludes for Documentation
      MAINTAINERS: add i2c to the excludes for Documentation

Yves-Alexis Perez (1):
      yama: clarify ptrace_scope=2 in Yama documentation

 Documentation/00-INDEX                             | 428 ---------------------
 Documentation/PCI/00-INDEX                         |  26 --
 Documentation/RCU/00-INDEX                         |  34 --
 Documentation/RCU/rcu.txt                          |   4 -
 Documentation/admin-guide/LSM/Yama.rst             |   4 +-
 Documentation/admin-guide/README.rst               |   3 +-
 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 Documentation/admin-guide/l1tf.rst                 |   2 +-
 Documentation/admin-guide/mm/index.rst             |   1 +
 .../mm/memory-hotplug.rst}                         | 169 ++------
 Documentation/arm/00-INDEX                         |  50 ---
 Documentation/block/00-INDEX                       |  34 --
 Documentation/blockdev/00-INDEX                    |  18 -
 Documentation/cdrom/00-INDEX                       |  11 -
 Documentation/cgroup-v1/00-INDEX                   |  26 --
 Documentation/conf.py                              |   6 +-
 Documentation/core-api/boot-time-mm.rst            |   4 +-
 Documentation/core-api/gfp_mask-from-fs-io.rst     |   2 +
 Documentation/core-api/index.rst                   |   3 +
 Documentation/core-api/memory-allocation.rst       | 122 ++++++
 Documentation/core-api/memory-hotplug.rst          | 125 ++++++
 Documentation/core-api/mm-api.rst                  |   2 +
 Documentation/core-api/printk-formats.rst          |   6 +-
 Documentation/dev-tools/coccinelle.rst             |  23 +-
 Documentation/dev-tools/kselftest.rst              |   2 +-
 Documentation/device-mapper/dm-flakey.txt          |   4 +
 Documentation/devicetree/00-INDEX                  |  12 -
 Documentation/driver-api/basics.rst                |   3 +
 Documentation/driver-api/firewire.rst              |  48 +++
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/efi-stub.txt                         |  17 +-
 Documentation/fb/00-INDEX                          |  75 ----
 Documentation/fb/vesafb.txt                        |   4 +-
 Documentation/filesystems/00-INDEX                 | 153 --------
 Documentation/filesystems/dax.txt                  |   2 +-
 Documentation/filesystems/ext2.txt                 |   2 +-
 Documentation/filesystems/nfs/00-INDEX             |  26 --
 Documentation/fmc/00-INDEX                         |  38 --
 Documentation/gpio/00-INDEX                        |   4 -
 Documentation/ide/00-INDEX                         |  14 -
 Documentation/index.rst                            |   5 +-
 Documentation/ioctl/00-INDEX                       |  12 -
 Documentation/isdn/00-INDEX                        |  42 --
 Documentation/kbuild/00-INDEX                      |  14 -
 Documentation/laptops/00-INDEX                     |  16 -
 Documentation/leds/00-INDEX                        |  32 --
 Documentation/locking/00-INDEX                     |  16 -
 Documentation/m68k/00-INDEX                        |   7 -
 Documentation/mips/00-INDEX                        |   4 -
 Documentation/mmc/00-INDEX                         |  10 -
 Documentation/netlabel/00-INDEX                    |  10 -
 Documentation/netlabel/cipso_ipv4.txt              |  11 +-
 Documentation/netlabel/introduction.txt            |   2 +-
 Documentation/networking/00-INDEX                  | 234 -----------
 Documentation/parisc/00-INDEX                      |   6 -
 Documentation/power/00-INDEX                       |  44 ---
 Documentation/powerpc/00-INDEX                     |  34 --
 Documentation/preempt-locking.txt                  |  12 +-
 Documentation/process/2.Process.rst                |   2 +-
 Documentation/process/adding-syscalls.rst          |   2 +-
 Documentation/process/deprecated.rst               | 119 ++++++
 Documentation/process/howto.rst                    |  13 +-
 Documentation/process/index.rst                    |   2 +
 Documentation/process/license-rules.rst            |   2 +
 Documentation/s390/00-INDEX                        |  28 --
 Documentation/scheduler/00-INDEX                   |  18 -
 Documentation/scheduler/completion.txt             |   6 +-
 Documentation/scsi/00-INDEX                        | 108 ------
 Documentation/security/keys/ecryptfs.rst           |   8 +-
 Documentation/serial/00-INDEX                      |  16 -
 Documentation/sphinx-static/theme_overrides.css    |  38 ++
 Documentation/spi/00-INDEX                         |  16 -
 Documentation/sysctl/00-INDEX                      |  16 -
 Documentation/timers/00-INDEX                      |  16 -
 Documentation/trace/ftrace.rst                     |   3 +
 Documentation/trace/histogram.rst                  |   6 +-
 Documentation/virtual/00-INDEX                     |  11 -
 Documentation/virtual/kvm/00-INDEX                 |  35 --
 Documentation/vm/00-INDEX                          |  50 ---
 Documentation/vm/hmm.rst                           |  14 +-
 Documentation/w1/00-INDEX                          |  10 -
 Documentation/w1/masters/00-INDEX                  |  12 -
 Documentation/w1/slaves/00-INDEX                   |  14 -
 Documentation/x86/00-INDEX                         |  20 -
 Documentation/x86/x86_64/00-INDEX                  |  16 -
 LICENSES/other/CDDL-1.0                            |   6 +-
 LICENSES/other/ISC                                 |  24 ++
 MAINTAINERS                                        |  13 +-
 README                                             |   1 -
 drivers/firewire/core-iso.c                        |   7 +
 drivers/firewire/core-transaction.c                |  10 +
 include/uapi/linux/firewire-cdev.h                 |  22 +-
 lib/vsprintf.c                                     |  20 +-
 net/bridge/Kconfig                                 |   2 +-
 scripts/check_00index.sh                           |  67 ----
 scripts/kernel-doc                                 |   8 +-
 96 files changed, 680 insertions(+), 2122 deletions(-)
 delete mode 100644 Documentation/00-INDEX
 delete mode 100644 Documentation/PCI/00-INDEX
 delete mode 100644 Documentation/RCU/00-INDEX
 rename Documentation/{memory-hotplug.txt => admin-guide/mm/memory-hotplug.rst} (74%)
 delete mode 100644 Documentation/arm/00-INDEX
 delete mode 100644 Documentation/block/00-INDEX
 delete mode 100644 Documentation/blockdev/00-INDEX
 delete mode 100644 Documentation/cdrom/00-INDEX
 delete mode 100644 Documentation/cgroup-v1/00-INDEX
 create mode 100644 Documentation/core-api/memory-allocation.rst
 create mode 100644 Documentation/core-api/memory-hotplug.rst
 delete mode 100644 Documentation/devicetree/00-INDEX
 create mode 100644 Documentation/driver-api/firewire.rst
 delete mode 100644 Documentation/fb/00-INDEX
 delete mode 100644 Documentation/filesystems/00-INDEX
 delete mode 100644 Documentation/filesystems/nfs/00-INDEX
 delete mode 100644 Documentation/fmc/00-INDEX
 delete mode 100644 Documentation/gpio/00-INDEX
 delete mode 100644 Documentation/ide/00-INDEX
 delete mode 100644 Documentation/ioctl/00-INDEX
 delete mode 100644 Documentation/isdn/00-INDEX
 delete mode 100644 Documentation/kbuild/00-INDEX
 delete mode 100644 Documentation/laptops/00-INDEX
 delete mode 100644 Documentation/leds/00-INDEX
 delete mode 100644 Documentation/locking/00-INDEX
 delete mode 100644 Documentation/m68k/00-INDEX
 delete mode 100644 Documentation/mips/00-INDEX
 delete mode 100644 Documentation/mmc/00-INDEX
 delete mode 100644 Documentation/netlabel/00-INDEX
 delete mode 100644 Documentation/networking/00-INDEX
 delete mode 100644 Documentation/parisc/00-INDEX
 delete mode 100644 Documentation/power/00-INDEX
 delete mode 100644 Documentation/powerpc/00-INDEX
 create mode 100644 Documentation/process/deprecated.rst
 delete mode 100644 Documentation/s390/00-INDEX
 delete mode 100644 Documentation/scheduler/00-INDEX
 delete mode 100644 Documentation/scsi/00-INDEX
 delete mode 100644 Documentation/serial/00-INDEX
 delete mode 100644 Documentation/spi/00-INDEX
 delete mode 100644 Documentation/sysctl/00-INDEX
 delete mode 100644 Documentation/timers/00-INDEX
 delete mode 100644 Documentation/virtual/00-INDEX
 delete mode 100644 Documentation/virtual/kvm/00-INDEX
 delete mode 100644 Documentation/vm/00-INDEX
 delete mode 100644 Documentation/w1/00-INDEX
 delete mode 100644 Documentation/w1/masters/00-INDEX
 delete mode 100644 Documentation/w1/slaves/00-INDEX
 delete mode 100644 Documentation/x86/00-INDEX
 delete mode 100644 Documentation/x86/x86_64/00-INDEX
 create mode 100644 LICENSES/other/ISC
 delete mode 100755 scripts/check_00index.sh
