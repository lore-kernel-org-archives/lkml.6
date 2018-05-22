Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeEVVbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:31:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:51973 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752950AbeEVVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:31:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43945460"
Date: Wed, 23 May 2018 05:30:34 +0800
From: kbuild test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:rcu/dev 98/99] kernel/rcu/rcutorture.c:1145:1: sparse: symbol
 '__pcpu_scope_rcu_torture_timer_rand' was not declared. Should it be static?
Message-ID: <201805230516.7z5kOC3u%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
head:   477fc1978395d58ae0406293a1d963629778a39d
commit: 816e0790625af6848ef768adead22dd6302a9c41 [98/99] rcutorture: Use per-CPU random state for rcu_torture_timer()
reproduce:
        # apt-get install sparse
        git checkout 816e0790625af6848ef768adead22dd6302a9c41
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> kernel/rcu/rcutorture.c:1145:1: sparse: symbol '__pcpu_scope_rcu_torture_timer_rand' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
