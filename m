Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeBZDWh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:22:37 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:3712 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeBZDWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:22:32 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v5 1/9] watchdog/hpwdt: Update Module info and copyright.
Date: Sun, 25 Feb 2018 20:22:19 -0700
Message-Id: <20180226032227.14615-2-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180226032227.14615-1-jerry.hoemann@hpe.com>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Copyright and Module description to reflect branding changes.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index f1f00dfc0e68..542dfc598716 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -4,7 +4,7 @@
  *
  *	SoftDog	0.05:	A Software Watchdog Device
  *
- *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
+ *	(c) Copyright 2018 Hewlett Packard Enterprise Development LP
  *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
  *
  *	This program is free software; you can redistribute it and/or
@@ -908,7 +908,7 @@ static struct pci_driver hpwdt_driver = {
 };
 
 MODULE_AUTHOR("Tom Mingarelli");
-MODULE_DESCRIPTION("hp watchdog driver");
+MODULE_DESCRIPTION("hpe watchdog driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HPWDT_VERSION);
 
-- 
2.13.6
