Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeDRKGF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:06:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753536AbeDRKGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:06:03 -0400
From: Zhao Chen <zhaochen6@huawei.com>
To: <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <zhaochen6@huawei.com>,
        <tony.qu@huawei.com>, <yin.yinshi@huawei.com>, <luoshaokai@huawei.com>
Subject: [PATCH net-next] net-next/hinic: add arm64 support
Date: Wed, 18 Apr 2018 06:07:39 -0400
Message-ID: <20180418100739.12948-1-zhaochen6@huawei.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables arm64 platform support for the HINIC driver.

Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/Kconfig b/drivers/net/ethernet/huawei/hinic/Kconfig
index 08db24954f7e..e4e8b24c1a5d 100644
--- a/drivers/net/ethernet/huawei/hinic/Kconfig
+++ b/drivers/net/ethernet/huawei/hinic/Kconfig
@@ -4,7 +4,7 @@
 
 config HINIC
 	tristate "Huawei Intelligent PCIE Network Interface Card"
-	depends on (PCI_MSI && X86)
+	depends on (PCI_MSI && (X86 || ARM64))
 	---help---
 	  This driver supports HiNIC PCIE Ethernet cards.
 	  To compile this driver as part of the kernel, choose Y here.
-- 
2.17.0
