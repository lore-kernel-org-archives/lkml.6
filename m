Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbeDZG1a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:27:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:47854 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbeDZG1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:27:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,329,1520924400";
   d="scan'208";a="37149905"
Date: Thu, 26 Apr 2018 14:26:35 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Kconfig:12: can't open file "arch/tile/Kconfig"
Message-ID: <201804261418.I7Eav1aZ%fengguang.wu@intel.com>
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
head:   69bfd470f4623d2d57ad62cb33791cded0c662f4
commit: bb9d812643d8a121df7d614a2b9c60193a92deb0 arch: remove tile port
date:   6 weeks ago
config: tile-allmodconfig
compiler: tilegx-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bb9d812643d8a121df7d614a2b9c60193a92deb0
        make.cross ARCH=tile  allmodconfig
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   Makefile:497: arch/tile/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
>> Kconfig:12: can't open file "arch/tile/Kconfig"
   make[2]: *** [allmodconfig] Error 1
   make[1]: *** [allmodconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/tile/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
>> Kconfig:12: can't open file "arch/tile/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/tile/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
>> Kconfig:12: can't open file "arch/tile/Kconfig"
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
