Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeBGLpi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:45:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:23713 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753454AbeBGLpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:45:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="17934129"
Date: Wed, 07 Feb 2018 19:44:47 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
branch HEAD: a2e5790d841658485d642196dbb0927303d6c22f  Merge branch 'akpm' (patches from Andrew)

Regressions in current branch:

arch/x86/tools/insn_decoder_test: warning: ffffffff810010d7:	0f ff eb             	ud0    %ebx,%ebp
arch/x86/tools/insn_decoder_test: warning: ffffffff81001152:	0f ff bf 09 00 00 00 	ud0    0x9(%rdi),%edi
arch/x86/tools/insn_decoder_test: warning: ffffffff81001275:	0f ff eb             	ud0    %ebx,%ebp
arch/x86/tools/insn_decoder_test: warning: ffffffff810013fd:	0f ff bf 09 00 00 00 	ud0    0x9(%rdi),%edi
arch/x86/tools/insn_decoder_test: warning: ffffffff81001499:	0f ff bf 09 00 00 00 	ud0    0x9(%rdi),%edi
arch/x86/tools/insn_decoder_test: warning: ffffffff812296eb:	0f ff e8             	ud0    %eax,%ebp

Error ids grouped by kconfigs:

recent_errors
├── x86_64-randconfig-r0-02071059
│   ├── arch-x86-tools-insn_decoder_test:warning:ffffffff810013fd:0f-ff-bf-ud0-(-rdi)-edi
│   └── arch-x86-tools-insn_decoder_test:warning:ffffffff81001499:0f-ff-bf-ud0-(-rdi)-edi
└── x86_64-randconfig-s3-02070914
    ├── arch-x86-tools-insn_decoder_test:warning:ffffffff810010d7:0f-ff-eb-ud0-ebx-ebp
    ├── arch-x86-tools-insn_decoder_test:warning:ffffffff81001152:0f-ff-bf-ud0-(-rdi)-edi
    ├── arch-x86-tools-insn_decoder_test:warning:ffffffff81001275:0f-ff-eb-ud0-ebx-ebp
    └── arch-x86-tools-insn_decoder_test:warning:ffffffff812296eb:0f-ff-e8-ud0-eax-ebp

elapsed time: 302m

configs tested: 124

x86_64                           allmodconfig
i386                               tinyconfig
i386                   randconfig-x019-201805
i386                   randconfig-x010-201805
i386                   randconfig-x015-201805
i386                   randconfig-x014-201805
i386                   randconfig-x011-201805
i386                   randconfig-x012-201805
i386                   randconfig-x017-201805
i386                   randconfig-x016-201805
i386                   randconfig-x018-201805
i386                   randconfig-x013-201805
i386                     randconfig-n0-201805
i386                     randconfig-i0-201805
i386                     randconfig-i1-201805
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
i386                     randconfig-a1-201805
i386                     randconfig-a0-201805
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-x017-201805
x86_64                 randconfig-x018-201805
x86_64                 randconfig-x013-201805
x86_64                 randconfig-x016-201805
x86_64                 randconfig-x011-201805
x86_64                 randconfig-x014-201805
x86_64                 randconfig-x012-201805
x86_64                 randconfig-x015-201805
x86_64                 randconfig-x010-201805
x86_64                 randconfig-x019-201805
i386                     randconfig-s0-201805
i386                     randconfig-s1-201805
x86_64                 randconfig-i0-02051046
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
i386                   randconfig-x071-201805
i386                   randconfig-x079-201805
i386                   randconfig-x072-201805
i386                   randconfig-x077-201805
i386                   randconfig-x076-201805
i386                   randconfig-x073-201805
i386                   randconfig-x070-201805
i386                   randconfig-x075-201805
i386                   randconfig-x078-201805
i386                   randconfig-x074-201805
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x004-201805
i386                   randconfig-x007-201805
i386                   randconfig-x002-201805
i386                   randconfig-x009-201805
i386                   randconfig-x003-201805
i386                   randconfig-x006-201805
i386                   randconfig-x005-201805
i386                   randconfig-x000-201805
i386                   randconfig-x008-201805
i386                   randconfig-x001-201805
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
s390                        default_defconfig
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
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                 randconfig-x008-201805
x86_64                 randconfig-x000-201805
x86_64                 randconfig-x005-201805
x86_64                 randconfig-x002-201805
x86_64                 randconfig-x007-201805
x86_64                 randconfig-x009-201805
x86_64                 randconfig-x001-201805
x86_64                 randconfig-x006-201805
x86_64                 randconfig-x003-201805
x86_64                 randconfig-x004-201805
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
