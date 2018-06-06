Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpN1zlvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC1C36070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeFFLlc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:41:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52049 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:41 -0400
X-Google-Smtp-Source: ADUXVKJG5e7Y+noScSAq5w8/fuZ82UgS1XQyvHLi0AmdoF6tWlomWbpsP+DE39gyHMjGyXGUz5cHYQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v6 5/8] staging: rtl8192e: Remove unrequired space at start of line - Coding Style
Date: Wed,  6 Jun 2018 12:40:00 +0100
Message-Id: <20180606114003.22654-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function HTIOTActIsDisableMCS14 contained spurious space at start of line.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 10d9c58680a2..981433f6c4f2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -394,7 +394,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 {
 	return 0;
- }
+}
 
 /**
 * Function:	HTIOTActIsDisableMCS15
-- 
2.17.0
