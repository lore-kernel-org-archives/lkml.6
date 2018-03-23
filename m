Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCWTrw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:47:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:16738 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeCWTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:47:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="26516563"
Date: Sat, 24 Mar 2018 03:47:41 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Jon Maloy <jon.maloy@ericsson.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Ying Xue <ying.xue@windriver.com>,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [net-next:master 1142/1149] net/tipc/discover.c:137:6: sparse:
 symbol 'tipc_disc_addr_trial_msg' was not declared. Should it be static?
Message-ID: <201803240317.PGXU57zT%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   f452518c982e57538e6d49da0a2c80eef22087ab
commit: 25b0b9c4e835ffaa65b61c3efe2e28acf84d0259 [1142/1149] tipc: handle collisions of 32-bit node address hash values
reproduce:
        # apt-get install sparse
        git checkout 25b0b9c4e835ffaa65b61c3efe2e28acf84d0259
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/tipc/discover.c:137:6: sparse: symbol 'tipc_disc_addr_trial_msg' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
