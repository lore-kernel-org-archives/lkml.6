Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966070AbeE2S1W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54872 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965941AbeE2S1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:18 -0400
X-Google-Smtp-Source: ADUXVKIfVlzPdRtrhXANwhmogZmaf2Zrl4hUPbWEnxexzcU3BOBsKhMbIryRhF3nR3HRbB17OB2fbQ==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4/7] clocksource/drivers/timer-imx-gpt: Remove outdated file path
Date: Tue, 29 May 2018 20:26:39 +0200
Message-Id: <1527618402-31974-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
References: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
 <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx gpt timer driver has been moved from arch/arm/mach-imx to
drivers/clocksource/ a long time ago, so remove the reference
to the old file path.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
