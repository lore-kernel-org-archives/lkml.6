Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031489AbeEZILh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:11:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031131AbeEZILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:11:32 -0400
X-Google-Smtp-Source: AB8JxZoocC7qrrGmUsOtzYH80EPi1uLDNPSjyQ9RppBAgchXeHWuZe9826VbGgDYl/NGjw0RDb+rTQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.king@canonical.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v4 3/5] staging: rtl8192e: Correct indentation of switch statements - coding style
Date: Sat, 26 May 2018 09:10:17 +0100
Message-Id: <20180526081019.4738-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180526081019.4738-1-johnfwhitmore@gmail.com>
References: <20180526081019.4738-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two switch statements had wrong indentation of 'case' options

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 48 +++++++++++-----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 2cf67b50a995..1b61a8de1edf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -177,35 +177,35 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tPrimary channel = %d\n", pHTInfoEle->ControlChl);
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tSecondary channel =");
 	switch (pHTInfoEle->ExtChlOffset) {
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
-			break;
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
+		break;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
 	switch (pHTInfoEle->OptMode) {
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
-			break;
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
+		break;
 	}
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set = [%x][%x][%x][%x][%x]\n", pHTInfoEle->BasicMSC[0],\
-- 
2.16.3
