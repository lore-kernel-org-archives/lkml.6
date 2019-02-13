Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E18DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05090222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083582;
	bh=bUH9GX+26SvKWTptuJ+OL6vDK9Ossh72M8Cb5eq8OGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QGtpHcBDDLhX/pG3GUahGmJ0tL4FlxnJuJW+O0/VgsRoL7VU1YLOeZWchRrdO27KI
	 M8FCUoWb+KLu0gpwyZJhu4kliftJD1mVnHklLQ5XWug2wT/YK00G8LUFRjgplTP9v0
	 j+spgShFSTcmTHHEHUgfwfs3wTqwlxRaqQzfQ2Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406431AbfBMSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfBMSqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 982A520811;
        Wed, 13 Feb 2019 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083577;
        bh=bUH9GX+26SvKWTptuJ+OL6vDK9Ossh72M8Cb5eq8OGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhSJ+1BiLhWxPFeaNkVRO/B+r+aqR/MRw/O/VoC7sas4/Ky8SPsLuz3MGw+IGWAdD
         C7A+cgUGRTeaeeVIfP7TDt3KUV4swSILmc06qWutgoEhpvRHEUZ3oW47tQ5CyrgJwN
         E8QL27qm8duxrd7Kw6LdaPgnoTHWjxn/n4WsXfxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.20 38/50] drm/rockchip: rgb: update SPDX license identifier
Date:   Wed, 13 Feb 2019 19:38:43 +0100
Message-Id: <20190213183658.703685353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandy Huang <hjc@rock-chips.com>

commit 053ff09f1a8f2151339f9fda457c5250929d1c49 upstream.

Update SPDX License Identifier from GPL-2.0+ to GPL-2.0
and drop some GPL text.
This fixes a mismatch between the existing SPDX headers and GPL
boilerplate text.

Fixes: 1f0f01515172 ("Add support for Rockchip Soc RGB output interface")
Cc: stable@vger.kernel.org
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/1548238479-171491-1-git-send-email-hjc@rock-chips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_rgb.c |   11 +----------
 drivers/gpu/drm/rockchip/rockchip_rgb.h |   11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

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


