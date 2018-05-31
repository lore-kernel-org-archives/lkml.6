Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeEaLFY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:05:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55918 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeEaLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:04:57 -0400
X-Google-Smtp-Source: ADUXVKIIEYB0WghBIUUfxBmiAkhGjYpl/5z0ElWeILqqu8yCfTgFcAnKLZSlPp9YAahtWQxroBeMGQ==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 3/3] staging: rtlwifi: Fix "Alwyas"->"Always"
Date: Thu, 31 May 2018 13:03:14 +0200
Message-Id: <20180531110314.3760-3-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531110314.3760-1-sabin.rapan@gmail.com>
References: <20180531110314.3760-1-sabin.rapan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in comment text.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/rtlwifi/rtl8822be/sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/rtl8822be/sw.c b/drivers/staging/rtlwifi/rtl8822be/sw.c
index 91b784b6d1c5..68629728ec4b 100644
--- a/drivers/staging/rtlwifi/rtl8822be/sw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/sw.c
@@ -54,7 +54,7 @@ static void rtl8822be_init_aspm_vars(struct ieee80211_hw *hw)
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
 	 * 2 - Enable ASPM with Clock Req,
-	 * 3 - Alwyas Enable ASPM with Clock Req,
+	 * 3 - Always Enable ASPM with Clock Req,
 	 * 4 - Always Enable ASPM without Clock Req.
 	 * set default to RTL8822BE:3 RTL8822B:2
 	 *
-- 
2.17.0
