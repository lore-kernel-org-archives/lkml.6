Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeEaLFE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:05:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36988 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbeEaLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:04:56 -0400
X-Google-Smtp-Source: ADUXVKKDPrID18nYwq1T3SPQrFMf9MM75aRdM2oWjEZkZwhLOIbQt5g+G+R7FNUyxG8q/XBwLysB0g==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 2/3] staging: rtlwifi: Fix "writen"->"written"
Date: Thu, 31 May 2018 13:03:13 +0200
Message-Id: <20180531110314.3760-2-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531110314.3760-1-sabin.rapan@gmail.com>
References: <20180531110314.3760-1-sabin.rapan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in comment text.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index 483ea85943c3..55b5c9df9d81 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -93,7 +93,7 @@ static void _rtl8822be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 	}
 
 	while (!bwrite_success) {
-		/* 2. Find the last BOX number which has been writen. */
+		/* 2. Find the last BOX number which has been written. */
 		boxnum = rtlhal->last_hmeboxnum;
 		switch (boxnum) {
 		case 0:
-- 
2.17.0
