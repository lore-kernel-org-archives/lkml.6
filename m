Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeEVXFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:05:13 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35133 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeEVXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:05:10 -0400
X-Google-Smtp-Source: AB8JxZrS+00/aaw8MMe/TrF3UiqDxlTG/8SUoVeOQCvtBWc/3YRCsfZj96JsNhGF3KF9N1+FPbFaIw==
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4/4] clocksource: mxs_timer: Switch to SPDX identifier
Date: Tue, 22 May 2018 20:05:06 -0300
Message-Id: <1527030306-3791-4-git-send-email-festevam@gmail.com>
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
