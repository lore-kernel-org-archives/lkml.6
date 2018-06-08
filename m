Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id A/pIIeqcGlsRRgAAmS7hNA
	; Fri, 08 Jun 2018 15:12:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7683B607E4; Fri,  8 Jun 2018 15:12:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 035F4601B4;
	Fri,  8 Jun 2018 15:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 035F4601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeFHPMi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:12:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:17808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFHPMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:12:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 08:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="55800367"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2018 08:12:34 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRJ46-000Xu5-4T; Fri, 08 Jun 2018 23:12:34 +0800
Date: Fri, 08 Jun 2018 23:11:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [linus:master] BUILD REGRESSION
 68abbe729567cef128b2c2141f2ed2567f3b8372
Message-ID: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
branch HEAD: 68abbe729567cef128b2c2141f2ed2567f3b8372  Merge branch 'akpm' (patches from Andrew)

Regressions in current branch:

arch/sh/include/asm/io.h:246:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
arch/x86/net/bpf_jit_comp32.c:2449 do_jit() warn: potential off by one 'addrs[]' limit 'bpf_prog->len'
drivers/acpi/battery.c:720:3-9: preceding lock on line 701
drivers/gpu/drm/amd/amdkfd/Kconfig:8: unknown option "imply"
drivers/gpu/drm/amd/amdkfd/Kconfig:9: syntax error
drivers/gpu/drm/bridge/Kconfig:77: unknown option "imply"
drivers/gpu/drm/bridge/Kconfig:78: syntax error
drivers/net/dsa/mv88e6xxx/Kconfig:26: unknown option "imply"
drivers/net/dsa/mv88e6xxx/Kconfig:27: syntax error
drivers/net/ethernet/adi/Kconfig:61: unknown option "imply"
drivers/net/ethernet/adi/Kconfig:62: syntax error
drivers/net/ethernet/amd/Kconfig:180: unknown option "imply"
drivers/net/ethernet/amd/Kconfig:181: syntax error
drivers/net/ethernet/broadcom/Kconfig:113: unknown option "imply"
drivers/net/ethernet/broadcom/Kconfig:114: syntax error
drivers/net/ethernet/cadence/Kconfig:38: unknown option "imply"
drivers/net/ethernet/cadence/Kconfig:39: syntax error
drivers/net/ethernet/cavium/Kconfig:56: unknown option "imply"
drivers/net/ethernet/cavium/Kconfig:57: syntax error
drivers/net/ethernet/freescale/Kconfig:28: unknown option "imply"
drivers/net/ethernet/freescale/Kconfig:29: syntax error
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4448:4: note: in expansion of macro 'xchg'
drivers/net/ethernet/intel/Kconfig:61: unknown option "imply"
drivers/net/ethernet/intel/Kconfig:62: syntax error
drivers/net/ethernet/mellanox/mlx4/Kconfig:10: unknown option "imply"
drivers/net/ethernet/mellanox/mlx4/Kconfig:11: syntax error
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:17: unknown option "imply"
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:18: syntax error
drivers/net/ethernet/qlogic/Kconfig:107: unknown option "imply"
drivers/net/ethernet/qlogic/Kconfig:108: syntax error
drivers/net/ethernet/renesas/Kconfig:40: unknown option "imply"
drivers/net/ethernet/renesas/Kconfig:41: syntax error
drivers/net/ethernet/samsung/Kconfig:24: unknown option "imply"
drivers/net/ethernet/samsung/Kconfig:25: syntax error
drivers/net/ethernet/sfc/Kconfig:8: unknown option "imply"
drivers/net/ethernet/sfc/Kconfig:9: syntax error
drivers/net/ethernet/stmicro/stmmac/Kconfig:7: unknown option "imply"
drivers/net/ethernet/stmicro/stmmac/Kconfig:8: syntax error
drivers/net/ethernet/ti/Kconfig:79: unknown option "imply"
drivers/net/ethernet/ti/Kconfig:80: syntax error
drivers/net/ethernet/tile/Kconfig:12: unknown option "imply"
drivers/net/ethernet/tile/Kconfig:13: syntax error
drivers/ptp/Kconfig:79: unknown option "imply"
drivers/ptp/Kconfig:80: syntax error
include/linux/syscalls.h:233:18: error: 'sys_getdomainname' alias between functions of incompatible types 'long int(char *, int)' and 'long int(long int,  long int)' [-Werror=attribute-alias]
include/linux/syscalls.h:233:18: error: 'sys_mmap2' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
include/linux/syscalls.h:233:18: error: 'sys_mmap' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
include/linux/syscalls.h:233:18: error: 'sys_sparc_remap_file_pages' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
include/net/mac80211.h:955: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
include/net/mac80211.h:955: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
include/net/mac80211.h:955: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
init/Kconfig:1278: unknown option "imply"
init/Kconfig:1279: syntax error
kernel/sched/fair.c:3760: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
mm/nobootmem.c:65:8: note: in expansion of macro 'phys_to_virt'
net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
scripts/kconfig/zconf.gperf:47:78: error: 'T_OPT_ALLNOCONFIG_Y' undeclared (first use in this function)
scripts/kconfig/zconf.gperf:47:78: error: 'T_OPT_ALLNOCONFIG_Y' undeclared (first use in this function); did you mean 'T_OPT_DEFCONFIG_LIST'?
scripts/kconfig/zconf.lex.c_shipped:2357:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
scripts/kconfig/zconf.lex.c_shipped:805:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
scripts/kconfig/zconf.lex.c_shipped:805:9: warning: implicit declaration of function 'xmalloc'; did you mean 'malloc'? [-Wimplicit-function-declaration]
scripts/kconfig/zconf.lex.c_shipped:805:9: warning: implicit declaration of function 'xmalloc' [-Wimplicit-function-declaration]
security/Kconfig:146: unknown option "imply"
security/Kconfig:147: syntax error

Error ids grouped by kconfigs:

recent_errors
├── i386-allmodconfig
│   └── drivers-acpi-battery.c:preceding-lock-on-line
├── i386-allnoconfig
│   ├── include-net-mac80211.h:warning:Function-parameter-or-member-control.rates-not-described-in-ieee80211_tx_info
│   ├── include-net-mac80211.h:warning:Function-parameter-or-member-status.is_valid_ack_signal-not-described-in-ieee80211_tx_info
│   ├── include-net-mac80211.h:warning:Function-parameter-or-member-status.status_driver_data-not-described-in-ieee80211_tx_info
│   ├── kernel-sched-fair.c:warning:Function-parameter-or-member-flags-not-described-in-attach_entity_load_avg
│   ├── net-mac80211-sta_info.h:warning:Function-parameter-or-member-status_stats.ack_signal_filled-not-described-in-sta_info
│   ├── net-mac80211-sta_info.h:warning:Function-parameter-or-member-status_stats.last_ack_signal-not-described-in-sta_info
│   ├── net-mac80211-sta_info.h:warning:Function-parameter-or-member-status_stats.msdu_failed-not-described-in-sta_info
│   ├── net-mac80211-sta_info.h:warning:Function-parameter-or-member-status_stats.msdu_retries-not-described-in-sta_info
│   └── net-mac80211-sta_info.h:warning:Function-parameter-or-member-tx_stats.msdu-not-described-in-sta_info
├── i386-allyesconfig
│   └── arch-x86-net-bpf_jit_comp32.c-do_jit()-warn:potential-off-by-one-addrs-limit-bpf_prog-len
├── openrisc-or1ksim_defconfig
│   ├── scripts-kconfig-zconf.gperf:error:T_OPT_ALLNOCONFIG_Y-undeclared-(first-use-in-this-function)-did-you-mean-T_OPT_DEFCONFIG_LIST
│   ├── scripts-kconfig-zconf.lex.c_shipped:warning:assignment-makes-pointer-from-integer-without-a-cast
│   ├── scripts-kconfig-zconf.lex.c_shipped:warning:implicit-declaration-of-function-xmalloc-did-you-mean-malloc
│   └── scripts-kconfig-zconf.lex.c_shipped:warning:initialization-makes-pointer-from-integer-without-a-cast
├── s390-allmodconfig
│   ├── drivers-net-ethernet-adi-Kconfig:syntax-error
│   ├── drivers-net-ethernet-adi-Kconfig:unknown-option-imply
│   ├── drivers-net-ethernet-tile-Kconfig:syntax-error
│   └── drivers-net-ethernet-tile-Kconfig:unknown-option-imply
├── sh-allmodconfig
│   ├── arch-sh-include-asm-io.h:warning:cast-to-pointer-from-integer-of-different-size
│   └── mm-nobootmem.c:note:in-expansion-of-macro-phys_to_virt
├── sh-allyesconfig
│   ├── arch-sh-include-asm-io.h:warning:cast-to-pointer-from-integer-of-different-size
│   └── mm-nobootmem.c:note:in-expansion-of-macro-phys_to_virt
├── sparc64-allyesconfig
│   └── drivers-net-ethernet-intel-ixgbevf-ixgbevf_main.c:note:in-expansion-of-macro-xchg
├── sparc-allyesconfig
│   └── drivers-net-ethernet-intel-ixgbevf-ixgbevf_main.c:note:in-expansion-of-macro-xchg
├── sparc-defconfig
│   ├── include-linux-syscalls.h:error:sys_getdomainname-alias-between-functions-of-incompatible-types-long-int(char-int)-and-long-int(long-int-long-int)
│   ├── include-linux-syscalls.h:error:sys_mmap2-alias-between-functions-of-incompatible-types-long-int(long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-
│   ├── include-linux-syscalls.h:error:sys_mmap-alias-between-functions-of-incompatible-types-long-int(long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-i
│   └── include-linux-syscalls.h:error:sys_sparc_remap_file_pages-alias-between-functions-of-incompatible-types-long-int(long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-int-long-unsigned-i
├── um-i386_defconfig
│   ├── scripts-kconfig-zconf.gperf:error:T_OPT_ALLNOCONFIG_Y-undeclared-(first-use-in-this-function)
│   └── scripts-kconfig-zconf.lex.c_shipped:warning:implicit-declaration-of-function-xmalloc
└── x86_64-randconfig-v2-201822
    ├── drivers-gpu-drm-amd-amdkfd-Kconfig:syntax-error
    ├── drivers-gpu-drm-amd-amdkfd-Kconfig:unknown-option-imply
    ├── drivers-gpu-drm-bridge-Kconfig:syntax-error
    ├── drivers-gpu-drm-bridge-Kconfig:unknown-option-imply
    ├── drivers-net-dsa-mv88e6xxx-Kconfig:syntax-error
    ├── drivers-net-dsa-mv88e6xxx-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-amd-Kconfig:syntax-error
    ├── drivers-net-ethernet-amd-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-broadcom-Kconfig:syntax-error
    ├── drivers-net-ethernet-broadcom-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-cadence-Kconfig:syntax-error
    ├── drivers-net-ethernet-cadence-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-cavium-Kconfig:syntax-error
    ├── drivers-net-ethernet-cavium-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-freescale-Kconfig:syntax-error
    ├── drivers-net-ethernet-freescale-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-intel-Kconfig:syntax-error
    ├── drivers-net-ethernet-intel-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-mellanox-mlx4-Kconfig:syntax-error
    ├── drivers-net-ethernet-mellanox-mlx4-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-mellanox-mlx5-core-Kconfig:syntax-error
    ├── drivers-net-ethernet-mellanox-mlx5-core-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-qlogic-Kconfig:syntax-error
    ├── drivers-net-ethernet-qlogic-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-renesas-Kconfig:syntax-error
    ├── drivers-net-ethernet-renesas-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-samsung-Kconfig:syntax-error
    ├── drivers-net-ethernet-samsung-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-sfc-Kconfig:syntax-error
    ├── drivers-net-ethernet-sfc-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-stmicro-stmmac-Kconfig:syntax-error
    ├── drivers-net-ethernet-stmicro-stmmac-Kconfig:unknown-option-imply
    ├── drivers-net-ethernet-ti-Kconfig:syntax-error
    ├── drivers-net-ethernet-ti-Kconfig:unknown-option-imply
    ├── drivers-ptp-Kconfig:syntax-error
    ├── drivers-ptp-Kconfig:unknown-option-imply
    ├── init-Kconfig:syntax-error
    ├── init-Kconfig:unknown-option-imply
    ├── security-Kconfig:syntax-error
    └── security-Kconfig:unknown-option-imply


i386-tinyconfig vmlinux size:

=============================================================================================================================================
 TOTAL  TEXT  is_pageblock_removable_nolock()  percpu_ida_alloc()                                                                            
=============================================================================================================================================
     0     0                                0                   0  5d752600a8c3 mm: restructure memfd code                                   
     0     0                                0                   0  230671533d64 mm: memory.low hierarchical behavior                         
     0     0                                0                   0  5f93ad67436b mm: treat memory.low value inclusive                         
     0     0                                0                   0  7854207fe954 mm/docs: describe memory.low refinements                     
     0     0                                0                   0  9ccc36171636 memcg: writeback: use memcg->cgwb_list directly              
     0     0                                0                   0  8dd53fd3b702 memcg: mark memcg1_events static const                       
     0     0                                0                   0  bb4a7ea2b144 mm: memcontrol: drain stocks on resize limit                 
     0     0                                0                   0  d12c60f64cf8 mm: memcontrol: drain memcg stock on force_empty             
     0     0                                0                   0  25cf23d7a957 mm/memblock: print memblock_remove                           
     0     0                                                    0  d62ff365b812 mm/vmpressure.c: use kstrndup instead of kmalloc+strncpy     
     0     0                                                    0  3cadfa2b9497 mm/vmpressure.c: convert to use match_string() helper        
     0     0                                                    0  a380b40abbce mm/page_alloc.c: remove useless parameter of finalise_ac()   
     0     0                                                    0  2bcd6454bae7 mm: use new return type vm_fault_t                           
     0     0                                                    0  b3ec9f33acb8 mm: change return type to vm_fault_t                         
     0     0                                                    0  285b8dcaacfc mm, hugetlbfs: pass fault address to no page handler         
     0     0                                                    0  e67d4ca79aaf mm: save two stranded bits in gfp_mask                       
    +1    +1                                                    0  1d40a5ea01d5 mm: mark pages in use for page tables                        
     0     0                                                    0  d4fc5069a394 mm: switch s_mem and slab_cache in struct page               
     0     0                                                    0  7d27a04bb2b5 mm: move 'private' union within struct page                  
     0     0                                                    0  b21999da02f8 mm: move _refcount out of struct page union                  
     0     0                                                    0  66a6ffd2af42 mm: combine first three unions in struct page                
     0     0                                                    0  fa3015b7eed5 mm: use page->deferred_list                                  
     0     0                                                    0  b7ccc7f8c643 mm: move lru union within struct page                        
     0     0                                                    0  4da1984edbbe mm: combine LRU and main union in struct page                
     0     0                                                    0  97b4a6719871 mm: improve struct page documentation                        
     0     0                                                    0  a052f0a5168e mm: add pt_mm to struct page                                 
     0     0                                                    0  50e7fbc3bf0c mm: add hmm_data to struct page                              
     0     0                                                    0  bf68c214df6d slab,slub: remove rcu_head size checks                       
     0     0                                                    0  9736d2a95e36 slub: remove kmem_cache->reserved                            
     0     0                                                    0  df2cc96e7701 userfaultfd: prevent non-cooperative events vs mcopy_atomic  
    -9    -9                                                    0  7810e6781e0f mm, page_alloc: do not break __GFP_THISNODE by zonelist rese 
     0     0                                                    0  e81bf9793b18 mem_cgroup: make sure moving_account, move_lock_task and sta 
     0     0                                                    0  941169298a3e proc: smaller RCU section in ->getattr()                     
     0     0                                                    0  a4ef3895655c proc: use "unsigned int" in proc_fill_cache()                
     0     0                                                    0  197850a1e04a proc: use "unsigned int" for sigqueue length                 
     0     0                                                    0  5d008fb414f7 proc: use "unsigned int" for /proc/*/stack                   
     0     0                                                    0  b2f5de0334f0 tools/testing/selftests/proc: test /proc/*/fd a bit (+ PF_KT 
     0     0                                                    0  6d8e41080782 int-ll64.h: define u{8,16,32,64} and s{8,16,32,64} based on  
   -14   -14                                                    0  ca1250bbd4e0 lib/bitmap.c: micro-optimization for __bitmap_complement()   
     0     0                                                    0  b94078e69533 lib/idr.c: remove simple_ida_lock                            
  -388  -388                                                 -404  804209d8a009 lib/percpu_ida.c: use _irqsave() instead of local_irq_save() 
     0     0                                                    0  5cc41e099504 fs/binfmt_misc.c: do not allow offset overflow               
     0     0                                                    0  ef8b42f78e88 autofs4: merge auto_fs.h and auto_fs4.h                      
     0     0                                                    0  47206e012a0a autofs4: use autofs instead of autofs4 everywhere            
     0     0                                                    0  2a3ae0a1212d autofs: create autofs Kconfig and Makefile                   
     0     0                                                    0  9005d8333855 autofs: rename autofs documentation files                    
     0     0                                                    0  b6bb226a72f0 autofs: use autofs instead of autofs4 in documentation       
     0     0                                                    0  016e92da037e autofs: small cleanup in autofs_getpath()                    
   -16   -16                                                    0  68abbe729567 Merge branch 'akpm' (patches from Andrew)                    
  -387  -387                              -77                -404  89e85bce4b02..68abbe729567 (ALL COMMITS)                                  
=============================================================================================================================================

elapsed time: 780m

configs tested: 126

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                           allyesdebian
x86_64                                nfsroot
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
i386                               tinyconfig
i386                   randconfig-x012-201822
i386                   randconfig-x016-201822
i386                   randconfig-x014-201822
i386                   randconfig-x017-201822
i386                   randconfig-x018-201822
i386                   randconfig-x013-201822
i386                   randconfig-x011-201822
i386                   randconfig-x015-201822
i386                   randconfig-x019-201822
i386                   randconfig-x010-201822
i386                     randconfig-n0-201822
x86_64                 randconfig-x003-201822
x86_64                 randconfig-x007-201822
x86_64                 randconfig-x000-201822
x86_64                 randconfig-x004-201822
x86_64                 randconfig-x005-201822
x86_64                 randconfig-x001-201822
x86_64                 randconfig-x008-201822
x86_64                 randconfig-x002-201822
x86_64                 randconfig-x006-201822
x86_64                 randconfig-x009-201822
i386                     randconfig-i0-201822
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201822
i386                     randconfig-a1-201822
x86_64                 randconfig-x011-201822
x86_64                 randconfig-x015-201822
x86_64                 randconfig-x018-201822
x86_64                 randconfig-x010-201822
x86_64                 randconfig-x014-201822
x86_64                 randconfig-x019-201822
x86_64                 randconfig-x013-201822
x86_64                 randconfig-x017-201822
x86_64                 randconfig-x016-201822
x86_64                 randconfig-x012-201822
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allmodconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201822
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                   randconfig-x009-201822
i386                   randconfig-x008-201822
i386                   randconfig-x005-201822
i386                   randconfig-x001-201822
i386                   randconfig-x003-201822
i386                   randconfig-x000-201822
i386                   randconfig-x004-201822
i386                   randconfig-x006-201822
i386                   randconfig-x002-201822
i386                   randconfig-x007-201822
i386                   randconfig-x078-201822
i386                   randconfig-x079-201822
i386                   randconfig-x070-201822
i386                   randconfig-x074-201822
i386                   randconfig-x076-201822
i386                   randconfig-x075-201822
i386                   randconfig-x071-201822
i386                   randconfig-x073-201822
i386                   randconfig-x077-201822
i386                   randconfig-x072-201822
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
x86_64                                   rhel
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
