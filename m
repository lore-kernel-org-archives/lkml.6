Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeBKDla (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:41:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:26737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbeBKDl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:41:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,493,1511856000";
   d="scan'208";a="200265982"
Date: Sun, 11 Feb 2018 11:41:15 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: Kconfig:12: can't open file "arch/powerpc64/Kconfig"
Message-ID: <201802111111.M5DJTfR5%fengguang.wu@intel.com>
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
head:   d48fcbd864a008802a90c58a9ceddd9436d11a49
commit: 9e3e10c725360b9d07018cfcd5b7b6b7d325fae5 kconfig: send error messages to stderr
date:   2 days ago
config: powerpc64-defconfig
compiler: powerpc64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9e3e10c725360b9d07018cfcd5b7b6b7d325fae5
        make.cross ARCH=powerpc64  defconfig
        make.cross ARCH=powerpc64 

All errors (new ones prefixed by >>):

   Makefile:499: arch/powerpc64/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
   make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
   make[2]: *** [defconfig] Error 1
   make[1]: *** [defconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:499: arch/powerpc64/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
   make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:499: arch/powerpc64/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
   make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +12 Kconfig

838a2e55 Arnaud Lacombe 2010-09-04   7  
838a2e55 Arnaud Lacombe 2010-09-04   8  config SRCARCH
838a2e55 Arnaud Lacombe 2010-09-04   9  	string
838a2e55 Arnaud Lacombe 2010-09-04  10  	option env="SRCARCH"
838a2e55 Arnaud Lacombe 2010-09-04  11  
838a2e55 Arnaud Lacombe 2010-09-04 @12  source "arch/$SRCARCH/Kconfig"

:::::: The code at line 12 was first introduced by commit
:::::: 838a2e55e6a4e9e8a10451ed2ef0f7a08dabdb04 kbuild: migrate all arch to the kconfig mainmenu upgrade

:::::: TO: Arnaud Lacombe <lacombar@gmail.com>
:::::: CC: Arnaud Lacombe <lacombar@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
