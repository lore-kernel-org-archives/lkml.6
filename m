Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbeEWTRw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:17:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44430 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:17:49 -0400
X-Google-Smtp-Source: AB8JxZpbT38OcNMOgjj+lY6sFKflvnufIbaSQ6uLcrMxZ08rdSPcs6BpTaWkRg0AcScd4Fu2kYVmzQ==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/5] regulator: pfuze100: Switch to SPDX identifier
Date: Wed, 23 May 2018 16:17:34 -0300
Message-Id: <1527103058-8422-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 680f076..8cd692d 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -1,20 +1,7 @@
-/*
- * Copyright (C) 2011-2013 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
2.7.4
