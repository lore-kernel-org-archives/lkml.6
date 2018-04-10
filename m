Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeDJCmP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:42:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60793 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeDJCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:42:06 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3A2ftUH026266, This message is accepted by code: ctloc85258
From: <pkshih@realtek.com>
To: <kvalo@codeaurora.org>
CC: <Larry.Finger@lwfinger.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/9] rtlwifi: btcoex: Add 8822b header files to precomp.h
Date: Tue, 10 Apr 2018 10:41:38 +0800
Message-ID: <20180410024144.5027-4-pkshih@realtek.com>
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

Add 8822b header files to precomp.h for routing functions.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
index 02dff4c3f664..858318fd3d63 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
@@ -48,6 +48,9 @@
 #include "halbtc8723b2ant.h"
 #include "halbtc8821a2ant.h"
 #include "halbtc8821a1ant.h"
+#include "halbtc8822b1ant.h"
+#include "halbtc8822b2ant.h"
+#include "halbtc8822bwifionly.h"
 
 #define GetDefaultAdapter(padapter)	padapter
 
-- 
2.15.1
