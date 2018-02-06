Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeBFXB1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:01:27 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:13046 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbeBFXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:00:15 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 05/10] watchdog/hpwdt: Update Module info.
Date: Tue,  6 Feb 2018 15:58:50 -0700
Message-Id: <20180206225855.30582-6-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Module Author and permission on parameters so that the
parameters show up in sysfs.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index a275f14bbcb0..3fae3119369f 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -427,20 +427,20 @@ static struct pci_driver hpwdt_driver = {
 	.remove		= hpwdt_exit,
 };
 
-MODULE_AUTHOR("Tom Mingarelli");
-MODULE_DESCRIPTION("hp watchdog driver");
+MODULE_AUTHOR("Jerry Hoemann");
+MODULE_DESCRIPTION("hpe watchdog driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HPWDT_VERSION);
 
-module_param(soft_margin, int, 0);
+module_param(soft_margin, int, 0444);
 MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
 
-module_param(nowayout, bool, 0);
+module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
-module_param(allow_kdump, int, 0);
+module_param(allow_kdump, int, 0444);
 MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
 #endif					/* } */
 
-- 
2.13.6
