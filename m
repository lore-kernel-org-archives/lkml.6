Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJl6abyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A04F607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeFFLkq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:40:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40504 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeFFLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:42 -0400
X-Google-Smtp-Source: ADUXVKLi0v+EdYkSwzrbo98zBl9B/Vw2sjk0o50Dtp7pcyf6rBv/fAh6oOJTanB9+yoy9uAs4KtoFQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v6 6/8] staging: rtl8192e: Correct declaration of HTResetIOTSetting - Coding Style
Date: Wed,  6 Jun 2018 12:40:01 +0100
Message-Id: <20180606114003.22654-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaration of function was spread over three lines.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 981433f6c4f2..7ea516609d4c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -498,9 +498,7 @@ static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 	return retValue;
 }
 
-void HTResetIOTSetting(
-	PRT_HIGH_THROUGHPUT		pHTInfo
-)
+void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
 {
 	pHTInfo->IOTAction = 0;
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
-- 
2.17.0
