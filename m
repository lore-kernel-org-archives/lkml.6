Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEPTsn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:48:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:56505 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeEPTsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:48:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="54971941"
Date: Thu, 17 May 2018 03:47:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: kbuild-all@01.org, davem@davemloft.net, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: [RFC PATCH] net: hns3: hns3_pci_sriov_configure() can be static
Message-ID: <20180516194742.GA85037@lkp-sb05>
References: <20180515182014.42196-10-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515182014.42196-10-salil.mehta@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fdb793670a00 ("net: hns3: Add support of .sriov_configure in HNS3 driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hns3_enet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e85ff38..3617b9d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1579,7 +1579,7 @@ static void hns3_remove(struct pci_dev *pdev)
  * Enable or change the number of VFs. Called when the user updates the number
  * of VFs in sysfs.
  **/
-int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+static int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	int ret;
 
