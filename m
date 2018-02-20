Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBTMif (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:38:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:46266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeBTMic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:38:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="19434752"
Date: Tue, 20 Feb 2018 20:38:19 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [tip:x86/boot 8/9] arch/x86/kernel/x86_init.c:33:5: sparse: symbol
 'u64_x86_init_noop' was not declared. Should it be static?
Message-ID: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
head:   e9cb8fc2e5ca5996417f900ed5149bd9150f6abd
commit: 62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9 [8/9] x86/acpi: Add a new x86_init_acpi structure to x86_init_ops
reproduce:
        # apt-get install sparse
        git checkout 62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/init.h:134:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:135:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:268:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:269:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/printk.h:200:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:32:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:34:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:37:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:38:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:40:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:42:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:43:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:45:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:46:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:49:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/qspinlock.h:53:32: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:646:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:647:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/memory_hotplug.h:221:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:34:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:35:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:62:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:173:8: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:174:8: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:174:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:176:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:178:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:180:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:430:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/io_apic.h:184:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mmzone.h:1292:15: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:113:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:126:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:110:33: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:112:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:114:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:118:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/hrtimer.h:497:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/io.h:47:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/kmemleak.h:29:33: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:29:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:30:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pgtable.h:28:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:135:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:716:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/wait_bit.h:41:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:63:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:65:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:66:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2421:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2422:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:3329:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1753:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1941:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2083:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2671:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/pci.h:1932:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/pci.h:1933:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/swiotlb.h:39:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/swiotlb.h:124:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:9:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:10:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:11:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:12:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/dma-contiguous.h:85:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:120:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:121:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:124:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:146:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pci_x86.h:147:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/setup.h:127:17: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/setup.h:128:17: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/clocksource.h:195:29: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/kernel/x86_init.c:28:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/kernel/x86_init.c:29:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/kernel/x86_init.c:31:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/kernel/x86_init.c:29:12: sparse: symbol 'iommu_init_noop' was not declared. Should it be
   arch/x86/kernel/x86_init.c:31:13: sparse: symbol 'bool_x86_init_noop' was not declared. Should it be
   arch/x86/kernel/x86_init.c:32:6: sparse: symbol 'x86_op_int_noop' was not declared. Should it be
>> arch/x86/kernel/x86_init.c:33:5: sparse: symbol 'u64_x86_init_noop' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
