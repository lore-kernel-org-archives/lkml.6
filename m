Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934236AbeEWTR6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:17:58 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36655 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:17:53 -0400
X-Google-Smtp-Source: ADUXVKLWS1Vt7plKZ8C8BmrEvWnbOQWXbCutfLUgnvwUv/83Ri8KIV8og+XSVL4/hvL3N0QrygVDRA==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/5] regulator: mc13783: Switch to SPDX identifier
Date: Wed, 23 May 2018 16:17:36 -0300
Message-Id: <1527103058-8422-3-git-send-email-festevam@gmail.com>
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
 drivers/regulator/mc13783-regulator.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index fe4c7d6..3db9ebc 100644
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
2.7.4
