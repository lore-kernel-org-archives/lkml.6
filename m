Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC8EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F132081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F132081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeKHFzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:55:15 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:33164 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeKHFzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:55:15 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 2459419F5D0;
        Wed,  7 Nov 2018 21:23:09 +0100 (CET)
Subject: [PATCH 8/9] arm64: defconfig: Change SCSI_UFS_HISI=m
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <6dd30abb-7bec-2ae6-49d7-305ab783dca5@free.fr>
Date:   Wed, 7 Nov 2018 21:18:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI_UFS_HISI depends on SCSI_UFSHCD_PLATFORM=m

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e4957df18f23..75d5ed7ea53d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -222,7 +222,7 @@ CONFIG_SCSI_HISI_SAS_PCI=y
 CONFIG_SCSI_UFSHCD=m
 CONFIG_SCSI_UFSHCD_PLATFORM=m
 CONFIG_SCSI_UFS_QCOM=m
-CONFIG_SCSI_UFS_HISI=y
+CONFIG_SCSI_UFS_HISI=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
-- 
2.17.1
