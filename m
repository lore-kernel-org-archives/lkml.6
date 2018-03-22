Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeCVVbs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:31:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:5921 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCVVbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:31:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="210551782"
Date: Fri, 23 Mar 2018 05:31:07 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Yisen Zhuang <yisen.zhuang@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Fuyun Liang <liangfuyun1@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: hns3: hclge_inform_reset_assert_to_vf()
 can be static
Message-ID: <20180322213107.GA29844@roam>
References: <201803230525.jlwCIx4C%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803230525.jlwCIx4C%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2bfbd35d8ecd ("net: hns3: Changes required in PF mailbox to support VF reset")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hclge_mbx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 3901333..a6f7ffa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -79,7 +79,7 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 	return status;
 }
 
-int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
+static int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 {
 	u8 msg_data[2];
 	u8 dest_vfid;
