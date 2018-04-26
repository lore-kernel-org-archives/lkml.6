Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDZDEO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:04:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:2360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbeDZDEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:04:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,329,1520924400";
   d="scan'208";a="34718136"
Date: Thu, 26 Apr 2018 11:03:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Jesper Nilsson <jesper@jni.nu>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Makefile:628: arch/cris/Makefile: No such file or directory
Message-ID: <201804261116.J3AUuUNS%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26ed24e429d89e045e5eb2d2b75215244347b7f2
commit: c690eddc2f3b44b24520f4a77cc3a4c9bde7d571 CRIS: Drop support for the CRIS port
date:   6 weeks ago
config: cris-etrax-100lx_v2_defconfig
compiler: cris-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c690eddc2f3b44b24520f4a77cc3a4c9bde7d571
        make.cross ARCH=cris  etrax-100lx_v2_defconfig
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

>> Makefile:628: arch/cris/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
   Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [etrax-100lx_v2_defconfig] Error 1
   make[1]: *** [etrax-100lx_v2_defconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
   Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
   Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +628 Makefile

433dc2eb Masahiro Yamada    2017-10-12  622  
6dd3f13e Michal Marek       2015-07-16  623  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
6dd3f13e Michal Marek       2015-07-16  624  # values of the respective KBUILD_* variables
6dd3f13e Michal Marek       2015-07-16  625  ARCH_CPPFLAGS :=
6dd3f13e Michal Marek       2015-07-16  626  ARCH_AFLAGS :=
6dd3f13e Michal Marek       2015-07-16  627  ARCH_CFLAGS :=
a436bb7b Masahiro Yamada    2015-03-27 @628  include arch/$(SRCARCH)/Makefile
a1c48bb1 Geert Uytterhoeven 2014-05-27  629  

:::::: The code at line 628 was first introduced by commit
:::::: a436bb7b806383ae0593cab53d17fc9676270cd3 kbuild: use relative path more to include Makefile

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
