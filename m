Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDZCYB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:24:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:41343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeDZCX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:23:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,329,1520924400";
   d="scan'208";a="44683010"
Date: Thu, 26 Apr 2018 10:23:17 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Makefile:636: arch/score/Makefile: No such file or directory
Message-ID: <201804261013.6YZ6XwpM%fengguang.wu@intel.com>
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

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26ed24e429d89e045e5eb2d2b75215244347b7f2
commit: b8c9c8f0190f4004d3d4364edb2dea5978dfc824 arch: remove score port
date:   7 weeks ago
config: score-spct6600_defconfig
compiler: score-elf-gcc (GCC) 4.9.4
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b8c9c8f0190f4004d3d4364edb2dea5978dfc824
        make.cross ARCH=score  spct6600_defconfig
        make.cross ARCH=score 

All errors (new ones prefixed by >>):

>> Makefile:636: arch/score/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/score/Makefile'.
   make[1]: Failed to remake makefile 'arch/score/Makefile'.
   make: *** [sub-make] Error 2
--
   Makefile:505: arch/score/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/score/Makefile'.
   make[1]: Failed to remake makefile 'arch/score/Makefile'.
>> Kconfig:12: can't open file "arch/score/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:505: arch/score/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/score/Makefile'.
   make[1]: Failed to remake makefile 'arch/score/Makefile'.
>> Kconfig:12: can't open file "arch/score/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:505: arch/score/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/score/Makefile'.
   make[1]: Failed to remake makefile 'arch/score/Makefile'.
>> Kconfig:12: can't open file "arch/score/Kconfig"
   make[2]: *** [spct6600_defconfig] Error 1
   make[1]: *** [spct6600_defconfig] Error 2
   make: *** [sub-make] Error 2

vim +636 Makefile

433dc2eb Masahiro Yamada    2017-10-12  630  
6dd3f13e Michal Marek       2015-07-16  631  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
6dd3f13e Michal Marek       2015-07-16  632  # values of the respective KBUILD_* variables
6dd3f13e Michal Marek       2015-07-16  633  ARCH_CPPFLAGS :=
6dd3f13e Michal Marek       2015-07-16  634  ARCH_AFLAGS :=
6dd3f13e Michal Marek       2015-07-16  635  ARCH_CFLAGS :=
a436bb7b Masahiro Yamada    2015-03-27 @636  include arch/$(SRCARCH)/Makefile
a1c48bb1 Geert Uytterhoeven 2014-05-27  637  

:::::: The code at line 636 was first introduced by commit
:::::: a436bb7b806383ae0593cab53d17fc9676270cd3 kbuild: use relative path more to include Makefile

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
