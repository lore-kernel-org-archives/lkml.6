Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbeEWTSH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:18:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46702 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934105AbeEWTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:17:51 -0400
X-Google-Smtp-Source: AB8JxZq5RIw4fh2Likw+GinJwE8dzo4xG0MTKFOBk8rpTZ5zxyFBTTzHSnNiXTNLk7a7JOaM7YZq6A==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/5] regulator: anatop: Switch to SPDX identifier
Date: Wed, 23 May 2018 16:17:35 -0300
Message-Id: <1527103058-8422-2-git-send-email-festevam@gmail.com>
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
 drivers/regulator/anatop-regulator.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 7d6478e..d9d8155 100644
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
2.7.4
