Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeEVXFe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:05:34 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42075 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeEVXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:05:08 -0400
X-Google-Smtp-Source: ADUXVKInXFFprwxkP+pfwp1HtIyKUu7Uu/b73p22bM3en3UrYxsFcbhxv5NBM/PLT4jg9Q4N/AZ+6Q==
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/4] clocksource: timer-imx-tpm: Switch to SPDX identifier
Date: Tue, 22 May 2018 20:05:05 -0300
Message-Id: <1527030306-3791-3-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527030306-3791-1-git-send-email-festevam@gmail.com>
References: <1527030306-3791-1-git-send-email-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 6c83184..b7aa2b8 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -1,12 +1,7 @@
-/*
- * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2017 NXP
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2017 NXP
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
-- 
2.7.4
