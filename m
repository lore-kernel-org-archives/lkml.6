Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C31AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DB620685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DB620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbeIXW2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:28:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeIXW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:28:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Tfq-0004mb-5D; Mon, 24 Sep 2018 16:25:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix spelling mistake "toogle" -> "toggle"
Date:   Mon, 24 Sep 2018 17:25:25 +0100
Message-Id: <20180924162525.1644-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in struct field name

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 2 +-
 drivers/staging/rtl8723bs/include/drv_types.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index f852fde47350..a2a2cefd1786 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -657,7 +657,7 @@ int proc_get_suspend_resume_info(struct seq_file *m, void *v)
 	DBG_871X_SEL_NL(m, "dbg_enwow_dload_fw_fail_cnt =%d\n", pdbgpriv->dbg_enwow_dload_fw_fail_cnt);
 	DBG_871X_SEL_NL(m, "dbg_ips_drvopen_fail_cnt =%d\n", pdbgpriv->dbg_ips_drvopen_fail_cnt);
 	DBG_871X_SEL_NL(m, "dbg_poll_fail_cnt =%d\n", pdbgpriv->dbg_poll_fail_cnt);
-	DBG_871X_SEL_NL(m, "dbg_rpwm_toogle_cnt =%d\n", pdbgpriv->dbg_rpwm_toogle_cnt);
+	DBG_871X_SEL_NL(m, "dbg_rpwm_toggle_cnt =%d\n", pdbgpriv->dbg_rpwm_toggle_cnt);
 	DBG_871X_SEL_NL(m, "dbg_rpwm_timeout_fail_cnt =%d\n", pdbgpriv->dbg_rpwm_timeout_fail_cnt);
 
 	return 0;
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index c57f290f605a..062fda9962be 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -381,7 +381,7 @@ struct debug_priv {
 	u32 dbg_enwow_dload_fw_fail_cnt;
 	u32 dbg_ips_drvopen_fail_cnt;
 	u32 dbg_poll_fail_cnt;
-	u32 dbg_rpwm_toogle_cnt;
+	u32 dbg_rpwm_toggle_cnt;
 	u32 dbg_rpwm_timeout_fail_cnt;
 	u64 dbg_rx_fifo_last_overflow;
 	u64 dbg_rx_fifo_curr_overflow;
-- 
2.17.1

