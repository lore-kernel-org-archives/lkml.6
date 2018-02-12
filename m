Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeBLFXG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:23:06 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:30147 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeBLFW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:28 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 07/11] watchdog/hpwdt: Select WATCHDOG_CORE
Date: Sun, 11 Feb 2018 22:21:07 -0700
Message-Id: <20180212052111.12010-8-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212052111.12010-1-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Kconfig file to show that hpwdt now selects WATCHDOG_CORE.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6a602f70aaa4..4d219c3fa8b4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1108,6 +1108,7 @@ config IT87_WDT
 
 config HP_WATCHDOG
 	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
+	select WATCHDOG_CORE
 	depends on X86 && PCI
 	help
 	  A software monitoring watchdog and NMI sourcing driver. This driver
-- 
2.13.6
