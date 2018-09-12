Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDEBC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795172146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795172146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeIMErb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:47:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeIMErb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:47:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 960B5C9D;
        Wed, 12 Sep 2018 23:40:41 +0000 (UTC)
Date:   Wed, 12 Sep 2018 16:40:39 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2018-09-12-16-40 uploaded
Message-ID: <20180912234039.Xa5RS%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm-of-the-moment snapshot 2018-09-12-16-40 has been uploaded to

   http://www.ozlabs.org/~akpm/mmotm/

mmotm-readme.txt says

README for mm-of-the-moment:

http://www.ozlabs.org/~akpm/mmotm/

This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
more than once a week.

You will need quilt to apply these patches to the latest Linus release (4.x
or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
http://ozlabs.org/~akpm/mmotm/series

The file broken-out.tar.gz contains two datestamp files: .DATE and
.DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
followed by the base kernel version against which this patch series is to
be applied.

This tree is partially included in linux-next.  To see which patches are
included in linux-next, consult the `series' file.  Only the patches
within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
linux-next.

A git tree which contains the memory management portion of this tree is
maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
by Michal Hocko.  It contains the patches which are between the
"#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
file, http://www.ozlabs.org/~akpm/mmotm/series.


A full copy of the full kernel tree with the linux-next and mmotm patches
already applied is available through git within an hour of the mmotm
release.  Individual mmotm releases are tagged.  The master branch always
points to the latest release, so it's constantly rebasing.

http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/

To develop on top of mmotm git:

  $ git remote add mmotm git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
  $ git remote update mmotm
  $ git checkout -b topic mmotm/master
  <make changes, commit>
  $ git send-email mmotm/master.. [...]

To rebase a branch with older patches to a new mmotm release:

  $ git remote update mmotm
  $ git rebase --onto mmotm/master <topic base> topic




The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is available at

	http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/

and use of this tree is similar to
http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.


This mmotm tree contains the following patches against 4.19-rc3:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-migration-fix-migration-of-huge-pmd-shared-pages.patch
* mm-migration-fix-migration-of-huge-pmd-shared-pages-v7.patch
* hugetlb-take-pmd-sharing-into-account-when-flushing-tlb-caches.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page-v5.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page-v5-checkpatch-fixes.patch
* fork-report-pid-exhaustion-correctly.patch
* mm-disable-deferred-struct-page-for-32-bit-arches.patch
* proc-kcore-fix-invalid-memory-access-in-multi-page-read-optimization-v3.patch
* proc-kcore-fix-invalid-memory-access-in-multi-page-read-optimization-v3-fix.patch
* mm-shmem-correctly-annotate-new-inodes-for-lockdep.patch
* kernel-remove-duplicated-include-from-sysc.patch
* mm-slowly-shrink-slabs-with-a-relatively-small-number-of-objects.patch
* ocfs2-fix-ocfs2-read-block-panic.patch
* arm-arch-arm-include-asm-pageh-needs-personalityh.patch
* ocfs2-get-rid-of-ocfs2_is_o2cb_active-function.patch
* ocfs2-without-quota-support-try-to-avoid-calling-quota-recovery.patch
* ocfs2-dont-use-iocb-when-eiocbqueued-returns.patch
* ocfs2-fix-a-misuse-a-of-brelse-after-failing-ocfs2_check_dir_entry.patch
* ocfs2-dont-put-and-assigning-null-to-bh-allocated-outside.patch
* ocfs2-dlmglue-clean-up-timestamp-handling.patch
* fix-dead-lock-caused-by-ocfs2_defrag_extent.patch
* ocfs2-fix-dead-lock-caused-by-ocfs2_defrag_extent.patch
* fix-clusters-leak-in-ocfs2_defrag_extent.patch
* fix-clusters-leak-in-ocfs2_defrag_extent-fix.patch
* block-restore-proc-partitions-to-not-display-non-partitionable-removable-devices.patch
* vfs-allow-dedupe-of-user-owned-read-only-files.patch
* vfs-dedupe-should-return-eperm-if-permission-is-not-granted.patch
* fs-iomap-change-return-type-to-vm_fault_t.patch
* xtensa-use-generic-vgah.patch
  mm.patch
* mm-slubc-switch-to-bitmap_zalloc.patch
* mm-rework-memcg-kernel-stack-accounting.patch
* mm-drain-memcg-stocks-on-css-offlining.patch
* mm-dont-miss-the-last-page-because-of-round-off-error.patch
* mm-dont-miss-the-last-page-because-of-round-off-error-fix.patch
* mmpage_alloc-pf_wq_worker-threads-must-sleep-at-should_reclaim_retry.patch
* mmpage_alloc-pf_wq_worker-threads-must-sleep-at-should_reclaim_retry-fix.patch
* xen-gntdev-fix-up-blockable-calls-to-mn_invl_range_start.patch
* mm-mmu_notifier-be-explicit-about-range-invalition-non-blocking-mode.patch
* revert-mm-mmu_notifier-annotate-mmu-notifiers-with-blockable-invalidate-callbacks.patch
* kmemleak-add-module-param-to-print-warnings-to-dmesg.patch
* swap-use-__try_to_reclaim_swap-in-free_swap_and_cache.patch
* swap-call-free_swap_slot-in-__swap_entry_free.patch
* swap-clear-si-swap_map-in-swap_free_cluster.patch
* mm-page_alloc-clean-up-check_for_memory.patch
* mm-conveted-to-use-vm_fault_t.patch
* cramfs-convert-to-use-vmf_insert_mixed-v2.patch
* mm-remove-vm_insert_mixed.patch
* mm-introduce-vmf_insert_pfn_prot.patch
* x86-convert-vdso-to-use-vm_fault_t.patch
* mm-make-vm_insert_pfn_prot-static.patch
* mm-remove-references-to-vm_insert_pfn.patch
* mm-remove-vm_insert_pfn.patch
* mm-inline-vm_insert_pfn_prot-into-caller.patch
* mm-convert-__vm_insert_mixed-to-vm_fault_t.patch
* mm-convert-insert_pfn-to-vm_fault_t.patch
* hexagon-switch-to-no_bootmem.patch
* of-ignore-sub-page-memory-regions.patch
* nios2-use-generic-early_init_dt_add_memory_arch.patch
* nios2-switch-to-no_bootmem.patch
* um-setup_physmem-stop-using-global-variables.patch
* um-switch-to-no_bootmem.patch
* unicore32-switch-to-no_bootmem.patch
* alpha-switch-to-no_bootmem.patch
* userfaultfd-allow-get_mempolicympol_f_nodempol_f_addr-to-trigger-userfaults.patch
* arm-arm64-introduce-config_have_memblock_pfn_valid.patch
* mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-arm64.patch
* mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn.patch
* mm-slab-combine-kmalloc_caches-and-kmalloc_dma_caches.patch
* mm-slab-slub-introduce-kmalloc-reclaimable-caches.patch
* dcache-allocate-external-names-from-reclaimable-kmalloc-caches.patch
* mm-rename-and-change-semantics-of-nr_indirectly_reclaimable_bytes.patch
* mm-proc-add-kreclaimable-to-proc-meminfo.patch
* mm-slab-shorten-kmalloc-cache-names-for-large-sizes.patch
* mm-workingset-dont-drop-refault-information-prematurely.patch
* mm-workingset-tell-cache-transitions-from-workingset-thrashing.patch
* delayacct-track-delays-from-thrashing-cache-pages.patch
* sched-loadavg-consolidate-load_int-load_frac-calc_load.patch
* sched-loadavg-consolidate-load_int-load_frac-calc_load-fix.patch
* sched-loadavg-make-calc_load_n-public.patch
* sched-schedh-make-rq-locking-and-clock-functions-available-in-statsh.patch
* sched-introduce-this_rq_lock_irq.patch
* psi-pressure-stall-information-for-cpu-memory-and-io.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix-2.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix-3.patch
* psi-cgroup-support.patch
* mm-page_alloc-drop-should_suppress_show_mem.patch
* z3fold-fix-wrong-handling-of-headless-pages.patch
* mm-make-memmap_init-a-proper-function.patch
* mm-calculate-deferred-pages-after-skipping-mirrored-memory.patch
* mm-calculate-deferred-pages-after-skipping-mirrored-memory-v2.patch
* mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix.patch
* mm-move-mirrored-memory-specific-code-outside-of-memmap_init_zone.patch
* mm-move-mirrored-memory-specific-code-outside-of-memmap_init_zone-v2.patch
* mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch
* mm-swap-fix-race-between-swapoff-and-some-swap-operations-v6.patch
* mm-fix-race-between-swapoff-and-mincore.patch
* list_lru-prefetch-neighboring-list-entries-before-acquiring-lock.patch
* list_lru-prefetch-neighboring-list-entries-before-acquiring-lock-fix.patch
* mm-add-strictlimit-knob-v2.patch
* mm-dont-expose-page-to-fast-gup-before-its-ready.patch
* mm-page_owner-align-with-pageblock_nr_pages.patch
* mm-page_owner-align-with-pageblock_nr-pages.patch
* syzbot-dump-all-threads-upon-global-oom.patch
* info-task-hung-in-generic_file_write_iter.patch
* include-linux-compilerh-add-version-detection-to-asm_volatile_goto.patch
* treewide-remove-current_text_addr.patch
* lib-bitmapc-remove-wrong-documentation.patch
* linux-bitmaph-handle-constant-zero-size-bitmaps-correctly.patch
* linux-bitmaph-remove-redundant-uses-of-small_const_nbits.patch
* linux-bitmaph-fix-type-of-nbits-in-bitmap_shift_right.patch
* linux-bitmaph-relax-comment-on-compile-time-constant-nbits.patch
* lib-bitmapc-fix-remaining-space-computation-in-bitmap_print_to_pagebuf.patch
* lib-bitmapc-fix-remaining-space-computation-in-bitmap_print_to_pagebuf-fix.patch
* lib-bitmapc-fix-remaining-space-computation-in-bitmap_print_to_pagebuf-fix-fix.patch
* lib-bitmapc-simplify-bitmap_print_to_pagebuf.patch
* lib-parserc-switch-match_strdup-over-to-use-kmemdup_nul.patch
* lib-parserc-switch-match_u64int-over-to-use-match_strdup.patch
* lib-parserc-switch-match_number-over-to-use-match_strdup.patch
* zlib-remove-fall-through-warnings.patch
* radix-tree-use-div_round_up-instead-of-reimplementing-its-function.patch
* lib-sg_pool-remove-unnecessary-null-check-when-free-the-object.patch
* checkpatch-remove-gcc_binary_constant-warning.patch
* init-do_mountsc-add-root=partlabel=name-support.patch
* hfsplus-prevent-btree-data-loss-on-root-split.patch
* hfsplus-fix-bug-on-bnode-parent-update.patch
* hfs-prevent-btree-data-loss-on-root-split.patch
* hfs-fix-bug-on-bnode-parent-update.patch
* hfsplus-prevent-btree-data-loss-on-enospc.patch
* hfs-prevent-btree-data-loss-on-enospc.patch
* reiserfs-propagate-errors-from-fill_with_dentries-properly.patch
* bfs-add-sanity-check-at-bfs_fill_super.patch
* ipc-ipcmni-limit-check-for-msgmni-and-shmmni.patch
* ipc-ipcmni-limit-check-for-semmni.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m-checkpatch-fixes.patch
* ipc-conserve-sequence-numbers-in-extended-ipcmni-mode.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* arch-x86-kernel-cpu-commonc-fix-warning.patch
* percpu-cleanup-per_cpu_def_attributes-macro.patch
* vfs-replace-current_kernel_time64-with-ktime-equivalent.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  slab-leaks3-default-y.patch
  workaround-for-a-pci-restoring-bug.patch
