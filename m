Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeFBJFB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:05:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46407 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeFBJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:04:46 -0400
X-Google-Smtp-Source: ADUXVKJTKdE5GrPTPdcqe197PwWCqma/2ypJBkjldfn98SdrLwTbSqsNgijKSZig+dhTI9ywOk0Ghw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH v2 3/3] staging: rtlwifi: Fix "Alwyas"->"Always"
Date: Sat,  2 Jun 2018 11:04:14 +0200
Message-Id: <20180602090414.5208-3-sabin.rapan@gmail.com>
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

 drivers/staging/rtlwifi/rtl8822be/sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/rtl8822be/sw.c b/drivers/staging/rtlwifi/rtl8822be/sw.c
index 7825e85ed091..a2ab19fa94f2 100644
--- a/drivers/staging/rtlwifi/rtl8822be/sw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/sw.c
@@ -43,7 +43,7 @@ static void rtl8822be_init_aspm_vars(struct ieee80211_hw *hw)
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
