Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D23C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370321019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfAWKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:22:04 -0500
Received: from regular1.263xmail.com ([211.150.99.137]:43350 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfAWKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:22:04 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 05:22:02 EST
Received: from hjc?rock-chips.com (unknown [192.168.167.163])
        by regular1.263xmail.com (Postfix) with ESMTP id B3B4F26F;
        Wed, 23 Jan 2019 18:14:44 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3625T140363032495872S1548238482061932_;
        Wed, 23 Jan 2019 18:14:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d70be505612b2cf0b7ae91f5e3d8f503>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, tglx@linutronix.de, heiko@sntech.de,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: rgb: update SPDX license identifier
Date:   Wed, 23 Jan 2019 18:14:39 +0800
Message-Id: <1548238479-171491-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update SPDX License Identifier from GPL-2.0+ to GPL-2.0
and drop some GPL text.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 11 +----------
 drivers/gpu/drm/rockchip/rockchip_rgb.h | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 96ac145..ad9358f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -1,17 +1,8 @@
-//SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.h b/drivers/gpu/drm/rockchip/rockchip_rgb.h
index 38b52e6..27b9635 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.h
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
@@ -1,17 +1,8 @@
-//SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifdef CONFIG_ROCKCHIP_RGB
-- 
2.7.4



