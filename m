Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeEWTSD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:18:03 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33938 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934218AbeEWTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:17:55 -0400
X-Google-Smtp-Source: ADUXVKJQN3D9fGX4CM4pki61JCfwIghArGWWlyuHzn+YvnkzJEgzkDBdChlwGxwKTF+INy4INsSqJg==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4/5] regulator: mc13892: Switch to SPDX identifier
Date: Wed, 23 May 2018 16:17:37 -0300
Message-Id: <1527103058-8422-4-git-send-email-festevam@gmail.com>
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
 drivers/regulator/mc13892-regulator.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 0d17c92..ab309ab 100644
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
2.7.4
