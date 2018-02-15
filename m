Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167585AbeBOXqk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:46:40 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:52513 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164340AbeBOXpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:45:03 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 06/11] watchdog/hpwdt: Select WATCHDOG_CORE
Date: Thu, 15 Feb 2018 16:43:55 -0700
Message-Id: <20180215234400.5022-7-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215234400.5022-1-jerry.hoemann@hpe.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
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
