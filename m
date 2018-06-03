Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeFCMFH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40814 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeFCMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:05:05 -0400
X-Google-Smtp-Source: ADUXVKJFxSGyPdu9uFpD9WK8yguJOZmNAe3fk3zE2E10zZt9vO5/plN5VWVj9yPVhy0U7AemDIQeAg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 5/8] staging: rtl8192e: Remove unrequired space at start of line - Coding Style
Date: Sun,  3 Jun 2018 13:04:10 +0100
Message-Id: <20180603120413.13042-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
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
