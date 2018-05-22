Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeEVXFK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:05:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40863 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeEVXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:05:06 -0400
X-Google-Smtp-Source: AB8JxZqMJyskFspHNt4X3w8e81tiSg2f7A7xG9oOJsOm/VsUfdnvIpEYASPrQ0kL+FkFBcum8ov9vg==
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/4] clocksource: timer-imx-gpt: Switch to SPDX identifier
Date: Tue, 22 May 2018 20:05:04 -0300
Message-Id: <1527030306-3791-2-git-send-email-festevam@gmail.com>
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
