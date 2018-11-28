Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A88A2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A88A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2Cc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:32:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2Ccz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:32:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gS1nd-0006cM-2D; Wed, 28 Nov 2018 15:30:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: fix spelling mistake "manufaucturing" -> "manufacturing"
Date:   Wed, 28 Nov 2018 15:30:48 +0000
Message-Id: <20181128153048.13804-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in some description text, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/mpt3sas/mpt3sas_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 8516713f980b..fb0a17252f86 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -119,7 +119,7 @@ _config_display_some_debug(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 		desc = "raid_volume";
 		break;
 	case MPI2_CONFIG_PAGETYPE_MANUFACTURING:
-		desc = "manufaucturing";
+		desc = "manufacturing";
 		break;
 	case MPI2_CONFIG_PAGETYPE_RAID_PHYSDISK:
 		desc = "physdisk";
-- 
2.19.1

