Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966282AbeE2S1d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52197 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965993AbeE2S1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:22 -0400
X-Google-Smtp-Source: ADUXVKLlPyElsxDpAhgUJAKfwHHjmWUtCYLs24GEplVZsVEWVZcU2UYTjEhK/p/f00KKI1uBaLe56w==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 7/7] clocksource/drivers/mxs_timer: Switch to SPDX identifier
Date: Tue, 29 May 2018 20:26:42 +0200
Message-Id: <1527618402-31974-7-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/mxs_timer.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index a03434e..f6ddae3 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -1,24 +1,10 @@
-/*
- *  Copyright (C) 2000-2001 Deep Blue Solutions
- *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
- *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
- *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
- *  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  Copyright (C) 2000-2001 Deep Blue Solutions
+//  Copyright (C) 2002 Shane Nay (shane@minirl.com)
+//  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
+//  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
+//  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/err.h>
 #include <linux/interrupt.h>
-- 
2.7.4
