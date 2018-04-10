Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDJCmR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:42:17 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60790 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDJCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:42:06 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3A2fuFC026278, This message is accepted by code: ctloc85258
From: <pkshih@realtek.com>
To: <kvalo@codeaurora.org>
CC: <Larry.Finger@lwfinger.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] rtlwifi: btcoex: Add 8822b to Makefile
Date: Tue, 10 Apr 2018 10:41:40 +0800
Message-ID: <20180410024144.5027-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180410024144.5027-1-pkshih@realtek.com>
References: <20180410024144.5027-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.140]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Add btcoex of 8822b to Makefile.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile b/drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile
index d15c58737388..37108c379bd0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile
@@ -4,6 +4,9 @@ btcoexist-objs :=	halbtc8192e2ant.o	\
 			halbtc8723b2ant.o	\
 			halbtc8821a1ant.o	\
 			halbtc8821a2ant.o	\
+			halbtc8822b1ant.o	\
+			halbtc8822b2ant.o	\
+			halbtc8822bwifionly.o	\
 			halbtcoutsrc.o		\
 			rtl_btc.o
 
-- 
2.15.1
