Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19314C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FA2217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfAVPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59659 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbfAVPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1glxos-0002ZT-SA; Tue, 22 Jan 2019 15:18:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: clean up two indentation issues
Date:   Tue, 22 Jan 2019 15:18:30 +0000
Message-Id: <20190122151830.7230-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two statements that are indented incorrectly. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/hpsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index ff67ef5d5347..5284444fdd10 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1327,7 +1327,7 @@ static int hpsa_scsi_add_entry(struct ctlr_info *h,
 		dev_warn(&h->pdev->dev, "physical device with no LUN=0,"
 			" suspect firmware bug or unsupported hardware "
 			"configuration.\n");
-			return -1;
+		return -1;
 	}
 
 lun_assigned:
@@ -4110,7 +4110,7 @@ static int hpsa_gather_lun_info(struct ctlr_info *h,
 			"maximum logical LUNs (%d) exceeded.  "
 			"%d LUNs ignored.\n", HPSA_MAX_LUN,
 			*nlogicals - HPSA_MAX_LUN);
-			*nlogicals = HPSA_MAX_LUN;
+		*nlogicals = HPSA_MAX_LUN;
 	}
 	if (*nlogicals + *nphysicals > HPSA_MAX_PHYS_LUN) {
 		dev_warn(&h->pdev->dev,
-- 
2.19.1

