Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA89EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B7B20675
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeLOORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:17:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54304 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:17:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gYAkf-0001bG-R3; Sat, 15 Dec 2018 14:17:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: 3w-xxx: fix indentation issue, add missing tab
Date:   Sat, 15 Dec 2018 14:17:08 +0000
Message-Id: <20181215141708.30883-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a tab missing on a return statement, add the missing tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/3w-xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index a58257645e94..04164d2f03dd 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1174,7 +1174,7 @@ static int tw_setfeature(TW_Device_Extension *tw_dev, int parm, int param_size,
   	command_que_value = tw_dev->command_packet_physical_address[request_id];
 	if (command_que_value == 0) {
 		printk(KERN_WARNING "3w-xxxx: tw_setfeature(): Bad command packet physical address.\n");
-	return 1;
+		return 1;
 	}
 
 	/* Send command packet to the board */
-- 
2.19.1

