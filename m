Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966231AbeE2S1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38614 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbeE2S1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:19 -0400
X-Google-Smtp-Source: ADUXVKLdu9ws0k3xcitGyf/JMTSmwb68kZ3zk5UR9Ho2LzE2JU/DNVx4M5y8SREz4nq2QP7VaYirEg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 5/7] clocksource/drivers/timer-imx-gpt: Switch to SPDX identifier
Date: Tue, 29 May 2018 20:26:40 +0200
Message-Id: <1527618402-31974-5-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-imx-gpt.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index b63b834..165fbbb 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -1,23 +1,9 @@
-/*
- *  Copyright (C) 2000-2001 Deep Blue Solutions
- *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
- *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
- *  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
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
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.7.4
