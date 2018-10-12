Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F93C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeJLWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:40:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:40:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAz2F-0003pj-DS; Fri, 12 Oct 2018 15:07:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: phydm: fix spelling mistake "Abnrormal" -> "Abnormal"
Date:   Fri, 12 Oct 2018 16:07:27 +0100
Message-Id: <20181012150727.21479-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm_dig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_dig.c b/drivers/staging/rtlwifi/phydm/phydm_dig.c
index 3115e7bdc749..f10776fbe2d9 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_dig.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_dig.c
@@ -813,7 +813,7 @@ void odm_DIG(void *dm_void)
 			dig_tab->rx_gain_range_min = 0x1c;
 			ODM_RT_TRACE(
 				dm, ODM_COMP_DIG,
-				"DIG: Abnrormal #beacon (%d) case in STA mode: Force lower bound to 0x%x\n",
+				"DIG: Abnormal #beacon (%d) case in STA mode: Force lower bound to 0x%x\n",
 				dm->phy_dbg_info.num_qry_beacon_pkt,
 				dig_tab->rx_gain_range_min);
 		}
@@ -824,7 +824,7 @@ void odm_DIG(void *dm_void)
 		dig_tab->rx_gain_range_min = dig_tab->rx_gain_range_max;
 		ODM_RT_TRACE(
 			dm, ODM_COMP_DIG,
-			"DIG: Abnrormal lower bound case: Force lower bound to 0x%x\n",
+			"DIG: Abnormal lower bound case: Force lower bound to 0x%x\n",
 			dig_tab->rx_gain_range_min);
 	}
 
-- 
2.17.1

