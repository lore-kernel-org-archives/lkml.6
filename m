Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF22C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3306B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3306B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeK1BZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:25:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44320 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1BZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:25:22 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gReKa-0002GT-78; Tue, 27 Nov 2018 14:27:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: fix spelling mistake "disnabled" -> "disabled"
Date:   Tue, 27 Nov 2018 14:27:15 +0000
Message-Id: <20181127142715.27406-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an ODM_RT_TRACE message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm.c b/drivers/staging/rtlwifi/phydm/phydm.c
index 27635feedba2..52b85b3ddb34 100644
--- a/drivers/staging/rtlwifi/phydm/phydm.c
+++ b/drivers/staging/rtlwifi/phydm/phydm.c
@@ -477,7 +477,7 @@ static void phydm_supportability_init(void *dm_void)
 
 	} else {
 		ODM_RT_TRACE(dm, ODM_COMP_INIT,
-			     "ODM adaptivity is set to disnabled!!!\n");
+			     "ODM adaptivity is set to disabled!!!\n");
 		/**/
 	}
 
-- 
2.19.1

