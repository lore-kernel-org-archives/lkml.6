Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeFEKAb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:00:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFEKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:00:30 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: tps65217: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 12:00:21 +0200
Message-Id: <20180605100021.3789-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/power/supply/tps65217_charger.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 1f5234098aaf..814c2b81fdfe 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -1,20 +1,8 @@
-/*
- * Battery charger driver for TI's tps65217
- *
- * Copyright (c) 2015, Collabora Ltd.
-
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
-
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
-
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Battery charger driver for TI's tps65217
+//
+// Copyright (C) 2015 Collabora Ltd.
+// Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
 
 /*
  * Battery charger driver for TI's tps65217
-- 
2.17.1
