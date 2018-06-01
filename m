Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeFAAnJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:43:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:60487 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbeFAAnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:43:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="228989924"
Date: Fri, 1 Jun 2018 08:42:27 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: honghui.zhang@mediatek.com
Cc: kbuild-all@01.org, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, honghui.zhang@mediatek.com,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        yong.wu@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
Subject: [RFC PATCH] PCI: mediatek: mtk_pcie_pm_ops can be static
Message-ID: <20180601004227.GA98217@lkp-sb05>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 24dc21cd1e9d ("PCI: mediatek: Add system pm support for MT2712")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index e3b16b0..e01cc66 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -1256,7 +1256,7 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops mtk_pcie_pm_ops = {
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
 				      mtk_pcie_resume_noirq)
 };
