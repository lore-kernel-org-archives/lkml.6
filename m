Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeFEJWw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:22:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeFEJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:22:23 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-i2c@vger.kernel.org
Subject: [PATCH 9/9] i2c: i2c-cros-ec-tunnel: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 11:22:09 +0200
Message-Id: <20180605092209.22887-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605092209.22887-1-enric.balletbo@collabora.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index eb76b76f4754..82bcd9a78759 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -1,13 +1,7 @@
-/*
- *  Copyright (C) 2013 Google, Inc
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * Expose an I2C passthrough to the ChromeOS EC.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Expose an I2C passthrough to the ChromeOS EC.
+//
+// Copyright (C) 2013 Google, Inc.
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-- 
2.17.1
