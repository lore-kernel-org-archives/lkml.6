Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeFATrL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:47:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:57842 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeFATrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:47:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="46594363"
Date: Sat, 2 Jun 2018 03:46:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>, linux-kernel@vger.kernel.org
Subject: [net-next:master 379/380]
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:144:5: sparse: symbol
 'mvpp2_percpu_read_relaxed' was not declared. Should it be static?
Message-ID: <201806020329.B1k6qmEB%fengguang.wu@intel.com>
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
head:   07f7ee6ec0e2193f1abca36cd7154986aec4893e
commit: db9d7d36eecc8926f03a8f2e46781887577b3353 [379/380] net: mvpp2: Split the PPv2 driver to a dedicated directory
reproduce:
        # apt-get install sparse
        git checkout db9d7d36eecc8926f03a8f2e46781887577b3353
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:144:5: sparse: symbol 'mvpp2_percpu_read_relaxed' was not declared. Should it be static?
>> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1699:15: sparse: expression using sizeof(void)
>> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2620:36: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] l3_proto @@    got restricted __be1int [signed] l3_proto @@
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2620:36:    expected int [signed] l3_proto
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2620:36:    got restricted __be16 [usertype] protocol
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2874:28: sparse: expression using sizeof(void)
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2874:28: sparse: expression using sizeof(void)
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2885:34: sparse: expression using sizeof(void)
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:2885:34: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
