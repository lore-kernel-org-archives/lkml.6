Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A014EC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4801C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4801C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJaIEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:04:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJaIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:04:35 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EC0C3A20;
        Tue, 30 Oct 2018 23:09:06 +0000 (UTC)
Date:   Tue, 30 Oct 2018 16:09:05 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2018-10-30-16-08 uploaded
Message-ID: <20181030230905.xHZmM%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm-of-the-moment snapshot 2018-10-30-16-08 has been uploaded to

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


This mmotm tree contains the following patches against 4.19:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-hmm-fix-utf8.patch
* mm-rmap-map_pte-was-not-handling-private-zone_device-page-properly-v3.patch
* mm-hmm-fix-race-between-hmm_mirror_unregister-and-mmu_notifier-callback.patch
* mm-hmm-properly-handle-migration-pmd-v3.patch
* mm-hmm-use-a-structure-for-update-callback-parameters-v2.patch
* mm-hmm-invalidate-device-page-table-at-start-of-invalidation.patch
* mm-gup_benchmark-prevent-integer-overflow-in-ioctl.patch
* fs-proc-vmcorec-convert-to-use-vmf_error.patch
* include-linux-compilerh-add-version-detection-to-asm_volatile_goto.patch
* add-oleksij-rempel-to-mailmap.patch
* treewide-remove-current_text_addr.patch
* error-injection-remove-meaningless-null-pointer-check-before-debugfs_remove_recursive.patch
* lib-bitmapc-remove-wrong-documentation.patch
* linux-bitmaph-handle-constant-zero-size-bitmaps-correctly.patch
* linux-bitmaph-remove-redundant-uses-of-small_const_nbits.patch
* linux-bitmaph-fix-type-of-nbits-in-bitmap_shift_right.patch
* linux-bitmaph-relax-comment-on-compile-time-constant-nbits.patch
* lib-bitmapc-fix-remaining-space-computation-in-bitmap_print_to_pagebuf.patch
* lib-bitmapc-simplify-bitmap_print_to_pagebuf.patch
* lib-parserc-switch-match_strdup-over-to-use-kmemdup_nul.patch
* lib-parserc-switch-match_u64int-over-to-use-match_strdup.patch
* lib-parserc-switch-match_number-over-to-use-match_strdup.patch
* zlib-remove-fall-through-warnings.patch
* lib-sg_pool-remove-unnecessary-null-check-when-free-the-object.patch
* lib-rbtreec-fix-typo-in-comment-of-rb_insert_augmented.patch
* kstrtox-delete-unnecessary-casts.patch
* compat-mark-expected-switch-fall-throughs.patch
* checkpatch-remove-gcc_binary_constant-warning.patch
* init-do_mountsc-add-root=partlabel=name-support.patch
* hfsplus-prevent-btree-data-loss-on-root-split.patch
* hfsplus-fix-bug-on-bnode-parent-update.patch
* hfs-prevent-btree-data-loss-on-root-split.patch
* hfs-fix-bug-on-bnode-parent-update.patch
* hfsplus-prevent-btree-data-loss-on-enospc.patch
* hfs-prevent-btree-data-loss-on-enospc.patch
* hfsplus-fix-return-value-of-hfsplus_get_block.patch
* hfs-fix-return-value-of-hfs_get_block.patch
* hfsplus-update-timestamps-on-truncate.patch
* hfs-update-timestamp-on-truncate.patch
* hfs-fix-array-out-of-bounds-read-of-array-extent.patch
* reiserfs-propagate-errors-from-fill_with_dentries-properly.patch
* reiserfs-remove-workaround-code-for-gcc-3x.patch
* fat-expand-a-slightly-out-of-date-comment.patch
* fat-create-a-function-to-calculate-the-timezone-offest.patch
* fat-add-functions-to-update-and-truncate-timestamps-appropriately.patch
* fat-change-timestamp-updates-to-use-fat_truncate_time.patch
* fat-truncate-inode-timestamp-updates-in-setattr.patch
* kernel-fix-a-comment-error.patch
* signal-mark-expected-switch-fall-throughs.patch
* kernel-panic-do-not-append-newline-to-the-stack-protector-panic-string.patch
* kernel-panic-filter-out-a-potential-trailing-newline.patch
* ipc-ipcmni-limit-check-for-msgmni-and-shmmni.patch
* ipc-ipcmni-limit-check-for-semmni.patch
* lib-lz4-update-lz4-decompressor-module.patch
* kbuild-fix-kernel-boundsc-w=1-warning.patch
* percpu-cleanup-per_cpu_def_attributes-macro.patch
* mm-remove-config_no_bootmem.patch
* mm-remove-config_have_memblock.patch
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
* docs-boot-time-mm-remove-bootmem-documentation.patch
* memblock-stop-using-implicit-alignement-to-smp_cache_bytes.patch
* memblock-warn-if-zero-alignment-was-requested.patch
* android-binder-replace-vm_insert_page-with-vmf_insert_page.patch
* mm-memory_hotplug-make-remove_memory-take-the-device_hotplug_lock.patch
* mm-memory_hotplug-make-add_memory-take-the-device_hotplug_lock.patch
* mm-memory_hotplug-fix-online-offline_pages-called-wo-mem_hotplug_lock.patch
* powerpc-powernv-hold-device_hotplug_lock-when-calling-device_online.patch
* powerpc-powernv-hold-device_hotplug_lock-when-calling-memtrace_offline_pages.patch
* memory-hotplugtxt-add-some-details-about-locking-internals.patch
* mm-fix-warning-in-insert_pfn.patch
* mm-fix-__get_user_pages_fast-comment.patch
* mm-handle-no-memcg-case-in-memcg_kmem_charge-properly.patch
* kernel-srcu-fix-ctags.patch
* mm-dont-reclaim-inodes-with-many-attached-pages.patch
* mm-thp-always-specify-disabled-vmas-as-nh-in-smaps.patch
* mm-thp-relax-__gfp_thisnode-for-madv_hugepage-mappings.patch
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
  mm.patch
* mm-thp-consolidate-thp-gfp-handling-into-alloc_hugepage_direct_gfpmask.patch
* memory_hotplug-free-pages-as-higher-order.patch
* memory_hotplug-free-pages-as-higher-order-fix.patch
* mm-page_alloc-remove-software-prefetching-in-__free_pages_core.patch
* z3fold-fix-wrong-handling-of-headless-pages.patch
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
* kernel-kexec_file-remove-some-duplicated-include-file.patch
* kernel-sysctlc-remove-duplicated-include.patch
* bfs-add-sanity-check-at-bfs_fill_super.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m.patch
* ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m-checkpatch-fixes.patch
* ipc-conserve-sequence-numbers-in-extended-ipcmni-mode.patch
  linux-next.patch
  linux-next-rejects.patch
* vfs-replace-current_kernel_time64-with-ktime-equivalent.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  slab-leaks3-default-y.patch
  workaround-for-a-pci-restoring-bug.patch
