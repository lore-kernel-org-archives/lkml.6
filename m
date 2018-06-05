Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeFEKBA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:01:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeFEKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:00:59 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm/bridge: analogix-anx78xx: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 12:00:50 +0200
Message-Id: <20180605100051.4023-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix-anx78xx.c | 24 ++++++++---------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index b49043866be6..54d7e7981bed 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1,19 +1,11 @@
-/*
- * Copyright(c) 2016, Analogix Semiconductor.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Based on anx7808 driver obtained from chromeos with copyright:
- * Copyright(c) 2013, Google Inc.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+// Driver for ANX78xx SlimPort transmitter.
+//
+// Copyright (C) 2016 Analogix Semiconductor.
+// Copyright (C) 2016 Google, Inc.
+//
+// Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-- 
2.17.1
