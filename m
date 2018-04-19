Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeDSSpW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:45:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34384 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbeDSSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:45:21 -0400
X-Google-Smtp-Source: AIpwx48EayoTqeQsyTPPGVh9Nm86b2vtRjwY3pYrDoU+6dQMTxOUxpaCSYpf4WjkZneHKEVIqdfwVQ==
From: Masanari Iida <standby24x7@gmail.com>
To: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        trivial@kernel.org, linux-input@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Input: touchscreen: Fix a typo in Kconfig
Date: Fri, 20 Apr 2018 03:45:14 +0900
Message-Id: <20180419184514.9668-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.17.0.140.g0b0cc9f86731
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo found in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4f15496fec8b..3e613afa10b4 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -362,7 +362,7 @@ config TOUCHSCREEN_HIDEEP
 
 	  If unsure, say N.
 
-	  To compile this driver as a moudle, choose M here : the
+	  To compile this driver as a module, choose M here : the
 	  module will be called hideep_ts.
 
 config TOUCHSCREEN_ILI210X
-- 
2.17.0.140.g0b0cc9f86731
