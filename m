Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032708AbeEXOUG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:20:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42432 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032250AbeEXOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:20:01 -0400
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: anatop: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <1527103058-8422-2-git-send-email-festevam@gmail.com>
Message-Id: <E1fLr5y-0002xN-6b@debutante>
Date: Thu, 24 May 2018 15:19:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: anatop: Switch to SPDX identifier

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

>From c07bbfe70263a443a59ec20f1af87af469a1e5b2 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 23 May 2018 16:17:35 -0300
Subject: [PATCH] regulator: anatop: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 7d6478e6a503..d9d8155ed8cb 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -1,22 +1,6 @@
-/*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/slab.h>
 #include <linux/device.h>
-- 
2.17.0
