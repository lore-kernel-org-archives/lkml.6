Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032799AbeEXOUJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:20:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032495AbeEXOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:19:57 -0400
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mc13783: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <1527103058-8422-3-git-send-email-festevam@gmail.com>
Message-Id: <E1fLr5u-0002VN-Gb@debutante>
Date: Thu, 24 May 2018 15:19:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mc13783: Switch to SPDX identifier

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

>From acd70ba4354684d77dc06309a16540fe60f24835 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 23 May 2018 16:17:36 -0300
Subject: [PATCH] regulator: mc13783: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mc13783-regulator.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index fe4c7d677f9c..3db9ebc76b79 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -1,14 +1,10 @@
-/*
- * Regulator Driver for Freescale MC13783 PMIC
- *
- * Copyright 2010 Yong Shen <yong.shen@linaro.org>
- * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator Driver for Freescale MC13783 PMIC
+//
+// Copyright 2010 Yong Shen <yong.shen@linaro.org>
+// Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+// Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
 
 #include <linux/mfd/mc13783.h>
 #include <linux/regulator/machine.h>
-- 
2.17.0
