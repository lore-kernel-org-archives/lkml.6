Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeDZCqL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:46:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:34576 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeDZCqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:46:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,329,1520924400";
   d="scan'208";a="46114899"
Date: Thu, 26 Apr 2018 10:45:34 +0800
From: kbuild test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Makefile:505: arch/mn10300/Makefile: No such file or directory
Message-ID: <201804261028.Q6FIxTjW%fengguang.wu@intel.com>
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

Hi David,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26ed24e429d89e045e5eb2d2b75215244347b7f2
commit: 739d875dd6982618020d30f58f8acf10f6076e6d mn10300: Remove the architecture
date:   7 weeks ago
config: mn10300-asb2364_defconfig
compiler: am33_2.0-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 739d875dd6982618020d30f58f8acf10f6076e6d
        make.cross ARCH=mn10300  asb2364_defconfig
        make.cross ARCH=mn10300 

All errors (new ones prefixed by >>):

>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [asb2364_defconfig] Error 1
   make[1]: *** [asb2364_defconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:636: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +505 Makefile

^1da177e Linus Torvalds  2005-04-16  501  
^1da177e Linus Torvalds  2005-04-16  502  # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
^1da177e Linus Torvalds  2005-04-16  503  # KBUILD_DEFCONFIG may point out an alternative default configuration
^1da177e Linus Torvalds  2005-04-16  504  # used for 'make defconfig'
a436bb7b Masahiro Yamada 2015-03-27 @505  include arch/$(SRCARCH)/Makefile
61bee204 Al Viro         2008-08-25  506  export KBUILD_DEFCONFIG KBUILD_KCONFIG
^1da177e Linus Torvalds  2005-04-16  507  

:::::: The code at line 505 was first introduced by commit
:::::: a436bb7b806383ae0593cab53d17fc9676270cd3 kbuild: use relative path more to include Makefile

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
