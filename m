Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeEVXFG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:05:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43615 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeEVXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:05:04 -0400
X-Google-Smtp-Source: AB8JxZra3HNFNH64J779WZj0JEOFGB91zSuNxqIezfOPfp/G2UpnEimRjMWTQdlJuu7PtgEJnBwL7A==
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/4] clocksource: timer-imx-gpt: Remove outdated file path
Date: Tue, 22 May 2018 20:05:03 -0300
Message-Id: <1527030306-3791-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx gpt timer driver has been moved from arch/arm/mach-imx to 
drivers/clocksource/ a long time ago, so remove the reference
to the old file path.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clocksource/timer-imx-gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6ec6d79..b63b834 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/plat-mxc/time.c
- *
  *  Copyright (C) 2000-2001 Deep Blue Solutions
  *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
  *  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
-- 
2.7.4
