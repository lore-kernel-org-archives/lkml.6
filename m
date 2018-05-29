Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966349AbeE2S20 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:28:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50881 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965980AbeE2S1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:21 -0400
X-Google-Smtp-Source: ADUXVKLa26/F6vNjjfC7Rppc8ObiLUlxiqF3/448JxRTEqGdwByZbiZacqvSnb1x7SoNE7+PyFRkFA==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 6/7] clocksource/drivers/timer-imx-tpm: Switch to SPDX identifier
Date: Tue, 29 May 2018 20:26:41 +0200
Message-Id: <1527618402-31974-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
References: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
 <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
