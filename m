Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeDZCQ7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:16:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:65100 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeDZCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:16:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,328,1520924400";
   d="scan'208";a="223470523"
Date: Thu, 26 Apr 2018 10:15:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Jesper Nilsson <jesper@jni.nu>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Kconfig:12: can't open file "arch/cris/Kconfig"
Message-ID: <201804261044.Z7UwOQza%fengguang.wu@intel.com>
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
config: cris-allmodconfig
compiler: cris-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c690eddc2f3b44b24520f4a77cc3a4c9bde7d571
        make.cross ARCH=cris  allmodconfig
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [allmodconfig] Error 1
   make[1]: *** [allmodconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
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
