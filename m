Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeCFFFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:05:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:45794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeCFFFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:05:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="205804718"
Date: Tue, 6 Mar 2018 13:05:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Stefan Chulski <stefanc@marvell.com>
Cc: kbuild-all@01.org, Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 5332/5518]
 drivers/net/ethernet/marvell/mvpp2.c:4288:5: sparse: symbol
 'mvpp2_check_hw_buf_num' was not declared. Should it be static?
Message-ID: <201803061326.5AOkQ4Wu%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   9c142d8a6556f069be6278ccab701039da81ad6f
commit: effbf5f58d64b1d1f93cb687d9797b42f291d5fd [5332/5518] net: mvpp2: update the BM buffer free/destroy logic
reproduce:
        # apt-get install sparse
        git checkout effbf5f58d64b1d1f93cb687d9797b42f291d5fd
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/marvell/mvpp2.c:4288:5: sparse: symbol 'mvpp2_check_hw_buf_num' was not declared. Should it be static?
   drivers/net/ethernet/marvell/mvpp2.c:6620:36: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] l3_proto @@    got restricted __be1int [signed] l3_proto @@
   drivers/net/ethernet/marvell/mvpp2.c:6620:36:    expected int [signed] l3_proto
   drivers/net/ethernet/marvell/mvpp2.c:6620:36:    got restricted __be16 [usertype] protocol

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
