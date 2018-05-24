Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032631AbeEXOT7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:19:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42196 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032250AbeEXOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:19:53 -0400
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mc13892: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <1527103058-8422-4-git-send-email-festevam@gmail.com>
Message-Id: <E1fLr5q-0001zA-Hn@debutante>
Date: Thu, 24 May 2018 15:19:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mc13892: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0f56839902fedfb95cb00d30342dd0ce5a69f7c3 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 23 May 2018 16:17:37 -0300
Subject: [PATCH] regulator: mc13892: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mc13892-regulator.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 0d17c9206816..ab309ab693ba 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -1,14 +1,10 @@
-/*
- * Regulator Driver for Freescale MC13892 PMIC
- *
- * Copyright 2010 Yong Shen <yong.shen@linaro.org>
- *
- * Based on draft driver from Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator Driver for Freescale MC13892 PMIC
+//
+// Copyright 2010 Yong Shen <yong.shen@linaro.org>
+//
+// Based on draft driver from Arnaud Patard <arnaud.patard@rtp-net.org>
 
 #include <linux/mfd/mc13892.h>
 #include <linux/regulator/machine.h>
-- 
2.17.0
