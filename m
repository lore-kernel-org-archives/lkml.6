Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3823620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJDDz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:55:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJDDz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:55:28 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0F4C86F;
        Wed,  3 Oct 2018 21:05:23 +0000 (UTC)
Date:   Wed, 03 Oct 2018 14:05:22 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2018-10-03-14-04 uploaded
Message-ID: <20181003210522.f__73%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm-of-the-moment snapshot 2018-10-03-14-04 has been uploaded to

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


This mmotm tree contains the following patches against 4.19-rc6:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-migration-fix-migration-of-huge-pmd-shared-pages.patch
* mm-migration-fix-migration-of-huge-pmd-shared-pages-v7.patch
* hugetlb-take-pmd-sharing-into-account-when-flushing-tlb-caches.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page-v5.patch
* fix-crash-on-ocfs2_duplicate_clusters_by_page-v5-checkpatch-fixes.patch
* mm-thp-fix-mlocking-thp-page-with-migration-enabled.patch
* mm-gup_benchmark-fix-unsigned-comparison-to-zero-in-__gup_benchmark_ioctl.patch
* ipc-shm-use-err_cast-for-shm_lock-error-return.patch
* mm-migrate-split-only-transparent-huge-pages-when-allocation-fails.patch
* mm-thp-relax-__gfp_thisnode-for-madv_hugepage-mappings.patch
* mm-thp-always-specify-disabled-vmas-as-nh-in-smaps.patch
* mm-hugetlb-add-mmap-encodings-for-32mb-and-512mb-page-sizes.patch
* proc-restrict-kernel-stack-dumps-to-root.patch
* mm-vmstat-fix-outdated-vmstat_text.patch
* mm-vmstat-skip-nr_tlb_remote_flush-properly.patch
* mm-fix-int-overflow-in-callers-of-do_shrink_slab.patch
* ocfs2-fix-locking-for-res-tracking-and-dlm-tracking_list.patch
* arm-arch-arm-include-asm-pageh-needs-personalityh.patch
* linkageh-align-weak-symbols.patch
* arm64-lib-use-c-string-functions-with-kasan-enabled.patch
* lib-test_kasan-add-tests-for-several-string-memory-api-functions.patch
* scripts-tags-add-declare_hashtable.patch
* ocfs2-fix-a-gcc-compiled-warning.patch
* ocfs2-dlm-remove-unnecessary-parentheses.patch
* ocfs2-remove-unused-pointer-eb.patch
* ocfs2-fix-unneeded-null-check.patch
* fs-ocfs2-dlm-fix-a-sleep-in-atomic-context-bug-in-dlm_print_one_mle.patch
* ocfs2-remove-set-but-not-used-variable-rb.patch
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
* mm-slub-remove-useless-condition-in-deactivate_slab.patch
* mm-dont-warn-about-large-allocations-for-slab.patch
* slub-extend-slub-debug-to-handle-multiple-slabs.patch
* mm-rework-memcg-kernel-stack-accounting.patch
* mm-drain-memcg-stocks-on-css-offlining.patch
* mm-dont-miss-the-last-page-because-of-round-off-error.patch
* mm-dont-miss-the-last-page-because-of-round-off-error-fix.patch
* mmpage_alloc-pf_wq_worker-threads-must-sleep-at-should_reclaim_retry.patch
* mmpage_alloc-pf_wq_worker-threads-must-sleep-at-should_reclaim_retry-fix.patch
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
* sched-loadavg-consolidate-load_int-load_frac-calc_load-fix-fix.patch
* sched-loadavg-make-calc_load_n-public.patch
* sched-schedh-make-rq-locking-and-clock-functions-available-in-statsh.patch
* sched-introduce-this_rq_lock_irq.patch
* psi-pressure-stall-information-for-cpu-memory-and-io.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix-2.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix-3.patch
* psi-pressure-stall-information-for-cpu-memory-and-io-fix-4.patch
* psi-cgroup-support.patch
* mm-page_alloc-drop-should_suppress_show_mem.patch
* mm-swap-remove-duplicated-include-from-swapc.patch
* mm-use-match_string-helper-to-simplify-the-code.patch
* kvfree-fix-misleading-comment.patch
* mm-vmalloc-improve-vfree-kerneldoc.patch
* vfree-kvfree-add-debug-might-sleeps.patch
* vfree-kvfree-add-debug-might-sleeps-fix.patch
* mm-mmap-zap-pages-with-read-mmap_sem-in-munmap.patch
* mm-unmap-vm_hugetlb-mappings-with-optimized-path.patch
* mm-unmap-vm_pfnmap-mappings-with-optimized-path.patch
* mm-filemapc-use-existing-variable.patch
* mm-memory_hotplug-spare-unnecessary-calls-to-node_set_state.patch
* mm-memory_hotplug-tidy-up-node_states_clear_node.patch
* mm-memory_hotplug-simplify-node_states_check_changes_online.patch
* mm-memory_hotplug-simplify-node_states_check_changes_online-v2.patch
* mm-memory_hotplug-clean-up-node_states_check_changes_offline.patch
* mm-memory_hotplug-clean-up-node_states_check_changes_offline-v2.patch
* memcg-remove-memcg_kmem_skip_account.patch
* mm-provide-kernel-parameter-to-allow-disabling-page-init-poisoning.patch
* mm-create-non-atomic-version-of-setpagereserved-for-init-use.patch
* mm-defer-zone_device-page-initialization-to-the-point-where-we-init-pgmap.patch
* mm-thp-consolidate-thp-gfp-handling-into-alloc_hugepage_direct_gfpmask.patch
* mm-remove-unnecessary-local-variable-addr-in-__get_user_pages_fast.patch
* hugetlb-harmonize-hugetlbh-arch-specific-defines-with-pgtableh.patch
* hugetlb-introduce-generic-version-of-hugetlb_free_pgd_range.patch
* hugetlb-introduce-generic-version-of-set_huge_pte_at.patch
* hugetlb-introduce-generic-version-of-huge_ptep_get_and_clear.patch
* hugetlb-introduce-generic-version-of-huge_ptep_clear_flush.patch
* hugetlb-introduce-generic-version-of-huge_pte_none.patch
* hugetlb-introduce-generic-version-of-huge_pte_wrprotect.patch
* hugetlb-introduce-generic-version-of-prepare_hugepage_range.patch
* hugetlb-introduce-generic-version-of-huge_ptep_set_wrprotect.patch
* hugetlb-introduce-generic-version-of-huge_ptep_set_access_flags.patch
* hugetlb-introduce-generic-version-of-huge_ptep_get.patch
* mm-filemapc-use-vmf_error.patch
* mm-mremap-downgrade-mmap_sem-to-read-when-shrinking.patch
* mm-mremap-downgrade-mmap_sem-to-read-when-shrinking-fix.patch
* mm-brk-downgrade-mmap_sem-to-read-when-shrinking.patch
* mm-brk-downgrade-mmap_sem-to-read-when-shrinking-fix.patch
* mm-dax-add-comment-for-pfn_special.patch
* mm-recheck-page-table-entry-with-page-table-lock-held.patch
* mm-vmstat-assert-that-vmstat_text-is-in-sync-with-stat_items_size.patch
* userfaultfd-selftest-cleanup-help-messages.patch
* userfaultfd-selftest-generalize-read-and-poll.patch
* userfaultfd-selftest-recycle-lock-threads-first.patch
* zsmalloc-fix-fall-through-annotation.patch
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
* info-task-hung-in-generic_file_write_iter.patch
* fs-proc-vmcorec-convert-to-use-vmf_error.patch
* include-linux-compilerh-add-version-detection-to-asm_volatile_goto.patch
* treewide-remove-current_text_addr.patch
* error-injection-remove-meaningless-null-pointer-check-before-debugfs_remove_recursive.patch
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
* reiserfs-remove-workaround-code-for-gcc-3x.patch
* fat-expand-a-slightly-out-of-date-comment.patch
* kernel-kexec_file-remove-some-duplicated-include-file.patch
* bfs-add-sanity-check-at-bfs_fill_super.patch
* ipc-ipcmni-limit-check-for-msgmni-and-shmmni.patch
* ipc-ipcmni-limit-check-for-semmni.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m-checkpatch-fixes.patch
* ipc-conserve-sequence-numbers-in-extended-ipcmni-mode.patch
* lib-lz4-update-lz4-decompressor-module.patch
  linux-next.patch
  linux-next-rejects.patch
* percpu-cleanup-per_cpu_def_attributes-macro.patch
* mm-remove-config_no_bootmem.patch
* mm-remove-config_no_bootmem-fix.patch
* mm-remove-config_have_memblock.patch
* mm-remove-config_have_memblock-fix.patch
* mm-remove-config_have_memblock-fix-2.patch
* mm-remove-config_have_memblock-fix-3.patch
* mm-remove-bootmem-allocator-implementation.patch
* mm-nobootmem-remove-dead-code.patch
* memblock-rename-memblock_alloc_nid_try_nid-to-memblock_phys_alloc.patch
* memblock-remove-_virt-from-apis-returning-virtual-address.patch
* memblock-replace-alloc_bootmem_align-with-memblock_alloc.patch
* memblock-replace-alloc_bootmem_low-with-memblock_alloc_low.patch
* memblock-replace-__alloc_bootmem_node_nopanic-with-memblock_alloc_try_nid_nopanic.patch
* memblock-replace-alloc_bootmem_pages_nopanic-with-memblock_alloc_nopanic.patch
* memblock-replace-alloc_bootmem_low-with-memblock_alloc_low-2.patch
* memblock-replace-__alloc_bootmem_nopanic-with-memblock_alloc_from_nopanic.patch
* memblock-add-align-parameter-to-memblock_alloc_node.patch
* memblock-replace-alloc_bootmem_pages_node-with-memblock_alloc_node.patch
* memblock-replace-__alloc_bootmem_node-with-appropriate-memblock_-api.patch
* memblock-replace-alloc_bootmem_node-with-memblock_alloc_node.patch
* memblock-replace-alloc_bootmem_low_pages-with-memblock_alloc_low.patch
* memblock-replace-alloc_bootmem_pages-with-memblock_alloc.patch
* memblock-replace-__alloc_bootmem-with-memblock_alloc_from.patch
* memblock-replace-alloc_bootmem-with-memblock_alloc.patch
* mm-nobootmem-remove-bootmem-allocation-apis.patch
* memblock-replace-free_bootmem_node-with-memblock_free.patch
* memblock-replace-free_bootmem_late-with-memblock_free_late.patch
* memblock-rename-free_all_bootmem-to-memblock_free_all.patch
* memblock-rename-__free_pages_bootmem-to-memblock_free_pages.patch
* mm-remove-nobootmem.patch
* memblock-replace-bootmem_alloc_-with-memblock-variants.patch
* mm-remove-include-linux-bootmemh.patch
* mm-remove-include-linux-bootmemh-fix.patch
* docs-boot-time-mm-remove-bootmem-documentation.patch
* android-binder-replace-vm_insert_page-with-vmf_insert_page.patch
* mm-memory_hotplug-make-remove_memory-take-the-device_hotplug_lock.patch
* mm-memory_hotplug-make-add_memory-take-the-device_hotplug_lock.patch
* mm-memory_hotplug-fix-online-offline_pages-called-wo-mem_hotplug_lock.patch
* powerpc-powernv-hold-device_hotplug_lock-when-calling-device_online.patch
* powerpc-powernv-hold-device_hotplug_lock-when-calling-memtrace_offline_pages.patch
* powerpc-powernv-hold-device_hotplug_lock-when-calling-memtrace_offline_pages-v3.patch
* memory-hotplugtxt-add-some-details-about-locking-internals.patch
* mm-fix-warning-in-insert_pfn.patch
* vfs-replace-current_kernel_time64-with-ktime-equivalent.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  slab-leaks3-default-y.patch
  workaround-for-a-pci-restoring-bug.patch
