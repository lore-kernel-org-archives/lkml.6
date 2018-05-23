Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeEWTS0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:18:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37916 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934220AbeEWTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:17:58 -0400
X-Google-Smtp-Source: AB8JxZo6SwZdnnspDQJ6ePbc7Q1A/ir7ze4OIpV2WHnl0ehIpl5Tq5yrt+xHTXHjesualgacAQLdbQ==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 5/5] regulator: mc13xxx-core: Switch to SPDX identifier
Date: Wed, 23 May 2018 16:17:38 -0300
Message-Id: <1527103058-8422-5-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527103058-8422-1-git-send-email-festevam@gmail.com>
References: <1527103058-8422-1-git-send-email-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/regulator/mc13xxx-regulator-core.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 0281c31..41271ae 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -1,19 +1,15 @@
-/*
- * Regulator Driver for Freescale MC13xxx PMIC
- *
- * Copyright 2010 Yong Shen <yong.shen@linaro.org>
- *
- * Based on mc13783 regulator driver :
- * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Regs infos taken from mc13xxx drivers from freescale and mc13xxx.pdf file
- * from freescale
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator Driver for Freescale MC13xxx PMIC
+//
+// Copyright 2010 Yong Shen <yong.shen@linaro.org>
+//
+// Based on mc13783 regulator driver :
+// Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+// Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
+//
+// Regs infos taken from mc13xxx drivers from freescale and mc13xxx.pdf file
+// from freescale
 
 #include <linux/mfd/mc13xxx.h>
 #include <linux/regulator/machine.h>
-- 
2.7.4
