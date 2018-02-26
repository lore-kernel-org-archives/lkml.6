Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeBZDXF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:23:05 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:60544 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeBZDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:22:37 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v5 9/9] watchdog/hpwdt: Update driver version.
Date: Sun, 25 Feb 2018 20:22:27 -0700
Message-Id: <20180226032227.14615-10-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180226032227.14615-1-jerry.hoemann@hpe.com>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update driver version number to reflect changes.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index b82bbeed0e43..a43ab2cecca2 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -26,7 +26,7 @@
 #include <linux/watchdog.h>
 #include <asm/nmi.h>
 
-#define HPWDT_VERSION			"1.4.0"
+#define HPWDT_VERSION			"2.0.0"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
-- 
2.13.6
