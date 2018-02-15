Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167484AbeBOXpE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:45:04 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:54356 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167453AbeBOXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:45:01 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 02/11] watchdog/hpwdt: remove include files no longer needed.
Date: Thu, 15 Feb 2018 16:43:51 -0700
Message-Id: <20180215234400.5022-3-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215234400.5022-1-jerry.hoemann@hpe.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove header files used by NMI sourcing and DMI decoding.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 113058644fc3..20a13c5d0285 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -28,16 +28,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
-#ifdef CONFIG_HPWDT_NMI_DECODING
-#include <linux/dmi.h>
-#include <linux/spinlock.h>
-#include <linux/nmi.h>
-#include <linux/kdebug.h>
-#include <linux/notifier.h>
-#include <asm/set_memory.h>
-#endif /* CONFIG_HPWDT_NMI_DECODING */
 #include <asm/nmi.h>
-#include <asm/frame.h>
 
 #define HPWDT_VERSION			"1.4.0"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
-- 
2.13.6
