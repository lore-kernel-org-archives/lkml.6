Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCVVcN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:32:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:24945 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbeCVVcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:32:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="213813688"
Date: Fri, 23 Mar 2018 05:31:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Yisen Zhuang <yisen.zhuang@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Fuyun Liang <liangfuyun1@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org
Subject: [net-next:master 1115/1116]
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c:82:5: sparse: symbol
 'hclge_inform_reset_assert_to_vf' was not declared. Should it be static?
Message-ID: <201803230525.jlwCIx4C%fengguang.wu@intel.com>
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
head:   6686c459e1449a3ee5f3fd313b0a559ace7a700e
commit: 2bfbd35d8ecd97a4a7f1db1754908b54542fa7aa [1115/1116] net: hns3: Changes required in PF mailbox to support VF reset
reproduce:
        # apt-get install sparse
        git checkout 2bfbd35d8ecd97a4a7f1db1754908b54542fa7aa
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c:82:5: sparse: symbol 'hclge_inform_reset_assert_to_vf' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
