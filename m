Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeFDNKd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:10:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:53224 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753187AbeFDNKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:10:31 -0400
Date: Mon, 4 Jun 2018 07:10:26 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 4.18
Message-ID: <20180604071026.7a7b468c@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.18

for you to fetch changes up to a49d9c0ae46e149a22aefa8251d07dddd5611851:

  Documentation: document hung_task_panic kernel parameter (2018-05-29 06:46:04 -0600)

----------------------------------------------------------------
There's been a fair amount of work in the docs tree this time around,
including:

 - Extensive RST conversions and organizational work in the
   memory-management docs thanks to Mike Rapoport.

 - An update of Documentation/features from Andrea Parri and a script to
   keep it updated.

 - Various LICENSES updates from Thomas, along with a script to check SPDX
   tags.

 - Work to fix dangling references to documentation files; this involved a
   fair number of one-liner comment changes outside of Documentation/

...and the usual list of documentation improvements, typo fixes, etc.

The comment changes led inevitably to a couple of minor merge conflicts
with fairly obvious resolutions.

Mauro has another big set of dangling-reference fixes treewide that I've
held back thus far; you may see that as an end-of-window request in the
hope of minimizing the obnoxiousness for others.

----------------------------------------------------------------
Anders Roxell (1):
      doc: dev-tools: kselftest.rst: update contributing new tests

Andrea Parri (7):
      Documentation/features: Add script that refreshes the arch support status files in place
      Documentation/features: Refresh the arch support status files in place
      Documentation/features/core: Add arch support status files for 'cBPF-JIT' and 'eBPF-JIT'
      Documentation/features/locking: Use '!RWSEM_GENERIC_SPINLOCK' as Kconfig for 'rwsem-optimized'
      Documentation/features/lib: Remove arch support status file for 'strncasecmp'
      Documentation/features/vm: Remove arch support status file for 'pte_special'
      Documentation: refcount-vs-atomic: Update reference to LKMM doc.

Christina Quast (1):
      Some files where renamed from .txt to .rst, but the Documentation was not fixed yet.

Daniel Vetter (1):
      doc: botching-up-ioctls: Make it clearer why structs must be padded

Dong Bo (1):
      vfio: fix documentation

Heikki Krogerus (1):
      Documentation: typec.rst: Use literal-block element with ascii art

Huang Ying (1):
      mm, THP, doc: Add document for thp_swpout/thp_swpout_fallback

Jonathan Corbet (6):
      Merge branch 'mm-rst' into docs-next
      Merge branch 'tglx-license' into docs-next
      Merge tag 'v4.17-rc2' into docs-next
      Merge branch 'features' into docs-next
      Revert "Documentation/features/vm: Remove arch support status file for 'pte_special'"
      docs: Use the kerneldoc comments for memalloc_no*()

Jonathan Neuschäfer (1):
      Documentation: gpio: driver: Fix a typo and some odd grammar

Justin Skists (1):
      Documentation/process/posting: wrap text at 80 cols

Konstantin Ryabitsev (1):
      Documentation/process: updates to the PGP guide

Masanari Iida (1):
      linux-next: ftrace/docs: Fix spelling typos in ftrace-users.rst

Mathieu Poirier (3):
      coresight: Remove obsolete reference to "owner" in CoreSight descriptor
      coresight: Add section for integration with the perf tools
      coresight: Grouping all perf tools oriented section together

Matthew Wilcox (1):
      Docs: tell maintainers to put [GIT PULL] in their subject lines

Mauro Carvalho Chehab (10):
      docs: */index.rst: Add newer documents to their respective index.rst
      docs: admin-guide: add bcache documentation
      docs: core-api: add cachetlb documentation
      docs: core-api: add circular-buffers documentation
      docs: driver-api: add clk documentation
      docs: admin-guide: add cgroup-v2 documentation
      w1: w1_io.c: fix a kernel-doc warning
      docs: uio-howto.rst: use a code block to solve a warning
      scripts/documentation-file-ref-check: rewrite it in perl with auto-fix mode
      docs: ranoops.rst: fix location of ramoops.txt

Michal Hocko (1):
      doc: document scope NOFS, NOIO APIs

Mike Rapoport (54):
      docs/vm: active_mm.txt convert to ReST format
      docs/vm: balance: convert to ReST format
      docs/vm: cleancache.txt: convert to ReST format
      docs/vm: frontswap.txt: convert to ReST format
      docs/vm: highmem.txt: convert to ReST format
      docs/vm: hmm.txt: convert to ReST format
      docs/vm: hugetlbpage.txt: convert to ReST format
      docs/vm: hugetlbfs_reserv.txt: convert to ReST format
      docs/vm: hwpoison.txt: convert to ReST format
      docs/vm: idle_page_tracking.txt: convert to ReST format
      docs/vm: ksm.txt: convert to ReST format
      docs/vm: mmu_notifier.txt: convert to ReST format
      docs/vm: numa_memory_policy.txt: convert to ReST format
      docs/vm: overcommit-accounting: convert to ReST format
      docs/vm: page_frags convert to ReST format
      docs/vm: numa: convert to ReST format
      docs/vm: pagemap.txt: convert to ReST format
      docs/vm: page_migration: convert to ReST format
      docs/vm: page_owner: convert to ReST format
      docs/vm: remap_file_pages.txt: conert to ReST format
      docs/vm: slub.txt: convert to ReST format
      docs/vm: soft-dirty.txt: convert to ReST format
      docs/vm: split_page_table_lock: convert to ReST format
      docs/vm: swap_numa.txt: convert to ReST format
      docs/vm: transhuge.txt: convert to ReST format
      docs/vm: unevictable-lru.txt: convert to ReST format
      docs/vm: userfaultfd.txt: convert to ReST format
      docs/vm: z3fold.txt: convert to ReST format
      docs/vm: zsmalloc.txt: convert to ReST format
      docs/vm: zswap.txt: convert to ReST format
      docs/vm: rename documentation files to .rst
      docs/vm: add index.rst and link MM documentation to top level index
      docs/vm: hugetlbpage: minor improvements
      docs/vm: hugetlbpage: move section about kernel development to hugetlbfs_reserv
      docs/vm: pagemap: formatting and spelling updates
      docs/vm: pagemap: change document title
      docs/admin-guide: introduce basic index for mm documentation
      docs/admin-guide/mm: start moving here files from Documentation/vm
      docs/admin-guide/mm: convert plain text cross references to hyperlinks
      mm/ksm: docs: extend overview comment and make it "DOC:"
      docs/vm: ksm: (mostly) formatting updates
      docs/vm: ksm: add "Design" section
      docs/vm: ksm: reshuffle text between "sysfs" and "design" sections
      docs/vm: ksm: update stable_node_chains_prune_millisecs description
      docs/vm: ksm: udpate description of stable_node_{dups,chains}
      docs/vm: ksm: split userspace interface to admin-guide/mm/ksm.rst
      docs/vm: numa_memory_policy: formatting and spelling updates
      docs/vm: numa_memory_policy: s/Linux memory policy/NUMA memory policy/
      docs/vm: move numa_memory_policy.rst to Documentation/admin-guide/mm
      docs/vm: transhuge: change sections order
      docs/vm: transhuge: minor updates
      docs/vm: transhuge: split userspace bits to admin-guide/mm/transhuge
      docs/vm: move ksm and transhuge from "user" to "internals" section.
      docs/admin-guide/mm: add high level concepts overview

Omar Sandoval (1):
      Documentation: document hung_task_panic kernel parameter

Randy Dunlap (3):
      documentation: core-api: rearrange a few kernel-api chapters and sections
      Documentation: driver-api: fix device_connection.rst kernel-doc error
      Documentation: block: cmdline-partition.txt fixes and additions

Steffen Maier (1):
      Documentation: ftrace: clarify filters with dynamic ftrace and graph

Thomas Gleixner (7):
      LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid identifiers
      LICENSES: Add X11 license
      LICENSES: Add Apache 2.0 license text
      LICENSES: Add CDDL-1.0 license text
      LICENSES: Add CC-BY-SA-4.0 license text
      LICENSES: Add Linux-OpenIB license text
      scripts: Add SPDX checker script

Thomas Hebb (1):
      Documentation: arm: clean up Marvell Berlin family info

Thymo van Beers (1):
      docs: kernel-parameters.txt: Fix whitespace

Tim Bird (1):
      docs: update kernel versions and dates in tables

 Documentation/00-INDEX                             |  10 -
 Documentation/ABI/stable/sysfs-devices-node        |   2 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages          |   2 +-
 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |   2 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |   4 +-
 .../{bcache.txt => admin-guide/bcache.rst}         |   0
 .../{cgroup-v2.txt => admin-guide/cgroup-v2.rst}   |   0
 Documentation/admin-guide/index.rst                |   3 +
 Documentation/admin-guide/kernel-parameters.txt    | 160 ++++---
 Documentation/admin-guide/mm/concepts.rst          | 222 +++++++++
 .../mm/hugetlbpage.rst}                            | 263 +++++-----
 .../mm/idle_page_tracking.rst}                     |  56 ++-
 Documentation/admin-guide/mm/index.rst             |  36 ++
 Documentation/admin-guide/mm/ksm.rst               | 189 ++++++++
 .../admin-guide/mm/numa_memory_policy.rst          | 495 +++++++++++++++++++
 .../{vm/pagemap.txt => admin-guide/mm/pagemap.rst} | 184 +++----
 .../mm/soft-dirty.rst}                             |  20 +-
 Documentation/admin-guide/mm/transhuge.rst         | 418 ++++++++++++++++
 .../mm/userfaultfd.rst}                            |  66 +--
 Documentation/admin-guide/ramoops.rst              |   2 +-
 Documentation/arm/Marvell/README                   |  15 +-
 Documentation/block/cmdline-partition.txt          |  21 +-
 .../{cachetlb.txt => core-api/cachetlb.rst}        |   0
 .../circular-buffers.rst}                          |   0
 Documentation/core-api/gfp_mask-from-fs-io.rst     |  66 +++
 Documentation/core-api/index.rst                   |   3 +
 Documentation/core-api/kernel-api.rst              |  60 +--
 Documentation/core-api/refcount-vs-atomic.rst      |   2 +-
 Documentation/crypto/index.rst                     |   1 +
 Documentation/dev-tools/kasan.rst                  |   2 +-
 Documentation/dev-tools/kselftest.rst              |   5 +
 Documentation/{clk.txt => driver-api/clk.rst}      |   0
 Documentation/driver-api/device_connection.rst     |   2 +-
 Documentation/driver-api/gpio/driver.rst           |   6 +-
 Documentation/driver-api/index.rst                 |   2 +
 Documentation/driver-api/uio-howto.rst             |   3 +-
 Documentation/driver-api/usb/typec.rst             |   2 +-
 .../strncasecmp => core/cBPF-JIT}/arch-support.txt |  14 +-
 .../core/{BPF-JIT => eBPF-JIT}/arch-support.txt    |   8 +-
 .../core/generic-idle-thread/arch-support.txt      |   4 +-
 .../features/core/jump-labels/arch-support.txt     |   2 +
 .../features/core/tracehook/arch-support.txt       |   2 +
 .../features/debug/KASAN/arch-support.txt          |   4 +-
 .../debug/gcov-profile-all/arch-support.txt        |   2 +
 Documentation/features/debug/kgdb/arch-support.txt |   4 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +
 .../features/debug/kprobes/arch-support.txt        |   4 +-
 .../features/debug/kretprobes/arch-support.txt     |   4 +-
 .../features/debug/optprobes/arch-support.txt      |   4 +-
 .../features/debug/stackprotector/arch-support.txt |   2 +
 .../features/debug/uprobes/arch-support.txt        |   6 +-
 .../debug/user-ret-profiler/arch-support.txt       |   2 +
 .../features/io/dma-api-debug/arch-support.txt     |   2 +
 .../features/io/dma-contiguous/arch-support.txt    |   4 +-
 .../features/io/sg-chain/arch-support.txt          |   2 +
 .../locking/cmpxchg-local/arch-support.txt         |   4 +-
 .../features/locking/lockdep/arch-support.txt      |   4 +-
 .../locking/queued-rwlocks/arch-support.txt        |  10 +-
 .../locking/queued-spinlocks/arch-support.txt      |   8 +-
 .../locking/rwsem-optimized/arch-support.txt       |  10 +-
 .../features/perf/kprobes-event/arch-support.txt   |   6 +-
 .../features/perf/perf-regs/arch-support.txt       |   4 +-
 .../features/perf/perf-stackdump/arch-support.txt  |   4 +-
 .../sched/membarrier-sync-core/arch-support.txt    |   2 +
 .../features/sched/numa-balancing/arch-support.txt |   6 +-
 Documentation/features/scripts/features-refresh.sh |  98 ++++
 .../seccomp/seccomp-filter/arch-support.txt        |   6 +-
 .../time/arch-tick-broadcast/arch-support.txt      |   4 +-
 .../features/time/clockevents/arch-support.txt     |   4 +-
 .../time/context-tracking/arch-support.txt         |   2 +
 .../features/time/irq-time-acct/arch-support.txt   |   4 +-
 .../time/modern-timekeeping/arch-support.txt       |   2 +
 .../features/time/virt-cpuacct/arch-support.txt    |   2 +
 .../features/vm/ELF-ASLR/arch-support.txt          |   4 +-
 .../features/vm/PG_uncached/arch-support.txt       |   2 +
 Documentation/features/vm/THP/arch-support.txt     |   2 +
 Documentation/features/vm/TLB/arch-support.txt     |   2 +
 .../features/vm/huge-vmap/arch-support.txt         |   2 +
 .../features/vm/ioremap_prot/arch-support.txt      |   2 +
 .../features/vm/numa-memblock/arch-support.txt     |   4 +-
 .../features/vm/pte_special/arch-support.txt       |   2 +
 Documentation/filesystems/proc.txt                 |   8 +-
 Documentation/filesystems/tmpfs.txt                |   5 +-
 Documentation/index.rst                            |   3 +-
 Documentation/ioctl/botching-up-ioctls.txt         |   4 +-
 Documentation/memory-barriers.txt                  |   4 +-
 Documentation/process/2.Process.rst                |  72 +--
 Documentation/process/5.Posting.rst                |  16 +-
 Documentation/process/index.rst                    |   1 +
 Documentation/process/maintainer-pgp-guide.rst     |  39 +-
 Documentation/process/submitting-patches.rst       |   2 +-
 Documentation/security/index.rst                   |   2 +
 Documentation/sound/alsa-configuration.rst         |   4 +-
 Documentation/sound/soc/codec.rst                  |   2 +-
 Documentation/sound/soc/platform.rst               |   2 +-
 Documentation/sysctl/vm.txt                        |   6 +-
 Documentation/trace/coresight.txt                  | 103 ++--
 Documentation/trace/ftrace-uses.rst                |   4 +-
 Documentation/trace/ftrace.rst                     |   7 +-
 .../translations/ko_KR/memory-barriers.txt         |   4 +-
 Documentation/vfio.txt                             |   5 +-
 Documentation/vm/00-INDEX                          |  58 +--
 Documentation/vm/active_mm.rst                     |  91 ++++
 Documentation/vm/active_mm.txt                     |  83 ----
 Documentation/vm/{balance => balance.rst}          |  15 +-
 .../vm/{cleancache.txt => cleancache.rst}          | 105 ++--
 Documentation/vm/conf.py                           |  10 +
 Documentation/vm/{frontswap.txt => frontswap.rst}  |  59 ++-
 Documentation/vm/{highmem.txt => highmem.rst}      |  87 ++--
 Documentation/vm/{hmm.txt => hmm.rst}              |  78 ++-
 .../{hugetlbfs_reserv.txt => hugetlbfs_reserv.rst} | 220 ++++++---
 Documentation/vm/{hwpoison.txt => hwpoison.rst}    | 141 +++---
 Documentation/vm/index.rst                         |  50 ++
 Documentation/vm/ksm.rst                           |  87 ++++
 Documentation/vm/ksm.txt                           | 178 -------
 Documentation/vm/mmu_notifier.rst                  |  99 ++++
 Documentation/vm/mmu_notifier.txt                  |  93 ----
 Documentation/vm/{numa => numa.rst}                |   6 +-
 Documentation/vm/numa_memory_policy.txt            | 452 ------------------
 Documentation/vm/overcommit-accounting             |  80 ----
 Documentation/vm/overcommit-accounting.rst         |  87 ++++
 Documentation/vm/{page_frags => page_frags.rst}    |   5 +-
 .../vm/{page_migration => page_migration.rst}      | 149 +++---
 .../vm/{page_owner.txt => page_owner.rst}          |  34 +-
 .../{remap_file_pages.txt => remap_file_pages.rst} |   6 +
 Documentation/vm/slub.rst                          | 361 ++++++++++++++
 Documentation/vm/slub.txt                          | 342 -------------
 ...t_page_table_lock => split_page_table_lock.rst} |  12 +-
 Documentation/vm/{swap_numa.txt => swap_numa.rst}  |  55 ++-
 Documentation/vm/transhuge.rst                     | 197 ++++++++
 Documentation/vm/transhuge.txt                     | 527 ---------------------
 .../{unevictable-lru.txt => unevictable-lru.rst}   | 117 ++---
 Documentation/vm/{z3fold.txt => z3fold.rst}        |   6 +-
 Documentation/vm/{zsmalloc.txt => zsmalloc.rst}    |  60 ++-
 Documentation/vm/{zswap.txt => zswap.rst}          |  71 +--
 LICENSES/exceptions/Linux-syscall-note             |   2 +-
 LICENSES/other/Apache-2.0                          | 183 +++++++
 LICENSES/other/CC-BY-SA-4.0                        | 397 ++++++++++++++++
 LICENSES/other/CDDL-1.0                            | 364 ++++++++++++++
 LICENSES/other/Linux-OpenIB                        |  26 +
 LICENSES/other/X11                                 |  37 ++
 LICENSES/preferred/GPL-2.0                         |   6 +
 MAINTAINERS                                        |   2 +-
 arch/alpha/Kconfig                                 |   2 +-
 arch/ia64/Kconfig                                  |   2 +-
 arch/mips/Kconfig                                  |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 drivers/w1/w1_io.c                                 |   1 +
 fs/Kconfig                                         |   2 +-
 fs/dax.c                                           |   2 +-
 fs/proc/task_mmu.c                                 |   4 +-
 include/linux/hmm.h                                |   2 +-
 include/linux/memremap.h                           |   4 +-
 include/linux/mmu_notifier.h                       |   2 +-
 include/linux/sched/mm.h                           |  42 +-
 include/linux/swap.h                               |   2 +-
 mm/Kconfig                                         |   7 +-
 mm/cleancache.c                                    |   2 +-
 mm/frontswap.c                                     |   2 +-
 mm/hmm.c                                           |   2 +-
 mm/huge_memory.c                                   |   4 +-
 mm/hugetlb.c                                       |   4 +-
 mm/ksm.c                                           |  23 +-
 mm/mmap.c                                          |   2 +-
 mm/rmap.c                                          |   6 +-
 mm/util.c                                          |   2 +-
 scripts/documentation-file-ref-check               | 125 ++++-
 scripts/spdxcheck.py                               | 284 +++++++++++
 168 files changed, 5538 insertions(+), 2921 deletions(-)
 rename Documentation/{bcache.txt => admin-guide/bcache.rst} (100%)
 rename Documentation/{cgroup-v2.txt => admin-guide/cgroup-v2.rst} (100%)
 create mode 100644 Documentation/admin-guide/mm/concepts.rst
 rename Documentation/{vm/hugetlbpage.txt => admin-guide/mm/hugetlbpage.rst} (61%)
 rename Documentation/{vm/idle_page_tracking.txt => admin-guide/mm/idle_page_tracking.rst} (72%)
 create mode 100644 Documentation/admin-guide/mm/index.rst
 create mode 100644 Documentation/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/admin-guide/mm/numa_memory_policy.rst
 rename Documentation/{vm/pagemap.txt => admin-guide/mm/pagemap.rst} (53%)
 rename Documentation/{vm/soft-dirty.txt => admin-guide/mm/soft-dirty.rst} (67%)
 create mode 100644 Documentation/admin-guide/mm/transhuge.rst
 rename Documentation/{vm/userfaultfd.txt => admin-guide/mm/userfaultfd.rst} (89%)
 rename Documentation/{cachetlb.txt => core-api/cachetlb.rst} (100%)
 rename Documentation/{circular-buffers.txt => core-api/circular-buffers.rst} (100%)
 create mode 100644 Documentation/core-api/gfp_mask-from-fs-io.rst
 rename Documentation/{clk.txt => driver-api/clk.rst} (100%)
 rename Documentation/features/{lib/strncasecmp => core/cBPF-JIT}/arch-support.txt (70%)
 rename Documentation/features/core/{BPF-JIT => eBPF-JIT}/arch-support.txt (79%)
 create mode 100755 Documentation/features/scripts/features-refresh.sh
 create mode 100644 Documentation/vm/active_mm.rst
 delete mode 100644 Documentation/vm/active_mm.txt
 rename Documentation/vm/{balance => balance.rst} (96%)
 rename Documentation/vm/{cleancache.txt => cleancache.rst} (83%)
 create mode 100644 Documentation/vm/conf.py
 rename Documentation/vm/{frontswap.txt => frontswap.rst} (91%)
 rename Documentation/vm/{highmem.txt => highmem.rst} (64%)
 rename Documentation/vm/{hmm.txt => hmm.rst} (91%)
 rename Documentation/vm/{hugetlbfs_reserv.txt => hugetlbfs_reserv.rst} (86%)
 rename Documentation/vm/{hwpoison.txt => hwpoison.rst} (60%)
 create mode 100644 Documentation/vm/index.rst
 create mode 100644 Documentation/vm/ksm.rst
 delete mode 100644 Documentation/vm/ksm.txt
 create mode 100644 Documentation/vm/mmu_notifier.rst
 delete mode 100644 Documentation/vm/mmu_notifier.txt
 rename Documentation/vm/{numa => numa.rst} (98%)
 delete mode 100644 Documentation/vm/numa_memory_policy.txt
 delete mode 100644 Documentation/vm/overcommit-accounting
 create mode 100644 Documentation/vm/overcommit-accounting.rst
 rename Documentation/vm/{page_frags => page_frags.rst} (97%)
 rename Documentation/vm/{page_migration => page_migration.rst} (63%)
 rename Documentation/vm/{page_owner.txt => page_owner.rst} (86%)
 rename Documentation/vm/{remap_file_pages.txt => remap_file_pages.rst} (92%)
 create mode 100644 Documentation/vm/slub.rst
 delete mode 100644 Documentation/vm/slub.txt
 rename Documentation/vm/{split_page_table_lock => split_page_table_lock.rst} (95%)
 rename Documentation/vm/{swap_numa.txt => swap_numa.rst} (74%)
 create mode 100644 Documentation/vm/transhuge.rst
 delete mode 100644 Documentation/vm/transhuge.txt
 rename Documentation/vm/{unevictable-lru.txt => unevictable-lru.rst} (92%)
 rename Documentation/vm/{z3fold.txt => z3fold.rst} (97%)
 rename Documentation/vm/{zsmalloc.txt => zsmalloc.rst} (71%)
 rename Documentation/vm/{zswap.txt => zswap.rst} (74%)
 create mode 100644 LICENSES/other/Apache-2.0
 create mode 100644 LICENSES/other/CC-BY-SA-4.0
 create mode 100644 LICENSES/other/CDDL-1.0
 create mode 100644 LICENSES/other/Linux-OpenIB
 create mode 100644 LICENSES/other/X11
 create mode 100755 scripts/spdxcheck.py
