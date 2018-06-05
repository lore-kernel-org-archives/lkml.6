Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeFERyu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:54:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeFERyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:54:45 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 7/8] extcon: usbc-cros-ec: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 19:54:28 +0200
Message-Id: <20180605175429.9072-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605175429.9072-1-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- [8/9] Fixed wrong copyright year.

 drivers/extcon/extcon-usbc-cros-ec.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 6721ab01fe7d..ef5a23e46e71 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -1,18 +1,8 @@
-/**
- * drivers/extcon/extcon-usbc-cros-ec - ChromeOS Embedded Controller extcon
- *
- * Copyright (C) 2017 Google, Inc
- * Author: Benson Leung <bleung@chromium.org>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// ChromeOS Embedded Controller extcon
+//
+// Copyright (C) 2017 Google, Inc.
+// Author: Benson Leung <bleung@chromium.org>
 
 #include <linux/extcon-provider.h>
 #include <linux/kernel.h>
-- 
2.17.1
