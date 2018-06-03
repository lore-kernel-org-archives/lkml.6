Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeFCMFL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50669 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeFCMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:05:08 -0400
X-Google-Smtp-Source: ADUXVKL9dvDVf20RjiA8zLwVpwz0/x226Qx5fvem2a5ZtQsQBzt+zBJn37UwAuNiETGwMADz4HFCSw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 6/8] staging: rtl8192e: Correct declaration of HTResetIOTSetting - Coding Style
Date: Sun,  3 Jun 2018 13:04:11 +0100
Message-Id: <20180603120413.13042-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
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
