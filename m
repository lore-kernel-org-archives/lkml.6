Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D820BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3D820BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeGQKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:09:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729640AbeGQKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:09:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F27ED56B2CEFC;
        Tue, 17 Jul 2018 17:37:12 +0800 (CST)
Received: from vm107-89-192.huawei.com (100.107.89.192) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 17:37:05 +0800
From:   Li Wei <liwei213@huawei.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>,
        <arnd@arndb.de>, <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>,
        <yamada.masahiro@socionext.com>, <riku.voipio@linaro.org>,
        <treding@nvidia.com>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC:     <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <sunzhaosheng@hisilicon.com>, <ian.rickards@arm.com>,
        <guodong.xu@linaro.org>, <puck.chen@hisilicon.com>,
        <john.stultz@linaro.org>, <liwei213@huawei.com>,
        <fengbaopeng@hisilicon.com>
Subject: [PATCH v11 4/4] [RESEND] arm64: defconfig: enable configs for Hisilicon ufs
Date:   Tue, 17 Jul 2018 17:36:59 +0800
Message-ID: <20180717093659.103263-5-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180717093659.103263-1-liwei213@huawei.com>
References: <20180717093659.103263-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f6af8a..2c07e233012b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -193,6 +193,7 @@ CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_SCSI_UFSHCD=m
 CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
-- 
2.15.0

