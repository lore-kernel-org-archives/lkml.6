Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934584AbeBMKPw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:15:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934095AbeBMKOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:14:38 -0500
From: Li Wei <liwei213@huawei.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <xuwei5@hisilicon.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>, <arnd@arndb.de>,
        <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>, <yamada.masahiro@socionext.com>,
        <riku.voipio@linaro.org>, <treding@nvidia.com>, <krzk@kernel.org>,
        <eric@anholt.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <zhangfei.gao@linaro.org>,
        <fengbaopeng@hisilicon.com>, <liwei213@huawei.com>
Subject: [PATCH v8 4/5] arm64: defconfig: enable configs for Hisilicon ufs
Date: Tue, 13 Feb 2018 18:14:11 +0800
Message-ID: <20180213101412.5717-5-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180213101412.5717-1-liwei213@huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enable configs for Hisilicon Hixxxx UFS driver.

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6da34ea..fa6f921eed86 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -174,6 +174,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.15.0
