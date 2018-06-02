Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeFBJEt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:04:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34069 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeFBJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:04:42 -0400
X-Google-Smtp-Source: ADUXVKIh+u3n0VZUdDQ10nzJRnnV7d7ccSgPJAoP+KvcyTUwez0yeFCrUIEHjTwPWolu2j3x2G2r8w==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH v2 2/3] staging: rtlwifi: Fix "writen"->"written"
Date: Sat,  2 Jun 2018 11:04:13 +0200
Message-Id: <20180602090414.5208-2-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602090414.5208-1-sabin.rapan@gmail.com>
References: <20180601060740.GA25648@kroah.com>
 <20180602090414.5208-1-sabin.rapan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in comment text.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
Changes in v2:
 - Added proper to and cc fields to the patch series.

 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index efec7281511c..a40396614814 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -82,7 +82,7 @@ static void _rtl8822be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 	}
 
 	while (!bwrite_success) {
-		/* 2. Find the last BOX number which has been writen. */
+		/* 2. Find the last BOX number which has been written. */
 		boxnum = rtlhal->last_hmeboxnum;
 		switch (boxnum) {
 		case 0:
-- 
2.17.0
